#!/usr/bin/env bash
# Trusted bootstrap for the pinned Palomar verifier on Ubuntu 24.04 amd64.
set -euo pipefail
umask 022
export PATH=/usr/sbin:/usr/bin:/sbin:/bin
unset LD_LIBRARY_PATH PYTHONPATH PYTHONHOME BASH_ENV ENV CDPATH
readonly policy=14aa8d6b3c2f14a8540605e37144560b9a00e7e7
readonly base=/opt/palomar-verifier-14aa8d6b
readonly python_dir=/opt/hostedtoolcache/Python/3.11.10/x64
readonly python_sha=afd148857762e10695475b013cdf9cb6898ac6817d58ae9961c2619b76e36fc2
readonly python_url=https://github.com/actions/python-versions/releases/download/3.11.10-10765870205/python-3.11.10-linux-24.04-x64.tar.gz
readonly installer_sha=c290df6cebdf1cb26edb69ed4164d9551062bfeb65243b93d1d1d3b77eac0a35
readonly req_sha=5144c14fbd798e2eb36ce329776b1c7f15f309f007f93003c30d29ddd9261536
fail() { printf '%s\n' "$*" >&2; exit 1; }
[[ $EUID == 0 ]] || fail 'Run setup as root; the proof must run as grhreplay.'
. /etc/os-release
[[ $ID == ubuntu && $VERSION_ID == 24.04 && $(dpkg --print-architecture) == amd64 ]] || fail 'Expected Ubuntu 24.04 amd64.'
# Existing parents must be owned by root and unwritable by group or other.
safe_dir() {
  /usr/bin/python3 -I - "$1" <<'PY'
import os, pathlib, stat, sys
p=pathlib.Path(sys.argv[1])
for d in [*reversed(p.parents),p]:
    try: s=d.lstat()
    except FileNotFoundError: d.mkdir(mode=0o755); s=d.lstat()
    if not stat.S_ISDIR(s.st_mode) or s.st_uid or s.st_mode & 0o022:
        raise SystemExit(f"Untrusted directory {d}")
PY
}
safe_dir "$base"
exec 9>"$base/setup.lock"
flock -n 9 || fail 'Another trusted bootstrap is active.'
safe_dir "$base/downloads"
safe_dir "$(dirname "$python_dir")"
get() {
  local url=$1 hash=$2 dest=$3
  if [[ -f $dest ]]; then
    printf '%s  %s\n' "$hash" "$dest" | sha256sum --check --status || fail "Digest mismatch for $dest"
  else
    curl --fail --location --silent --show-error --proto '=https' --tlsv1.2 --retry 3 "$url" -o "$dest.part"
    printf '%s  %s\n' "$hash" "$dest.part" | sha256sum --check --status || fail "Download failed verification: $url"
    mv -T "$dest.part" "$dest"
  fi
}
get "$python_url" "$python_sha" "$base/downloads/python.tar.gz"
get "https://raw.githubusercontent.com/PalomarRegistry/PalomarSubmission/$policy/scripts/install_bwrap.sh" "$installer_sha" "$base/downloads/install_bwrap.sh"
get "https://raw.githubusercontent.com/PalomarRegistry/PalomarSubmission/$policy/requirements.txt" "$req_sha" "$base/downloads/requirements.txt"

[[ ! -L $python_dir ]] || fail "Refusing a symlink at $python_dir."
if [[ ! -e $python_dir ]]; then
  python_tmp=$(mktemp -d "$(dirname "$python_dir")/.palomar-python.XXXXXX")
  tar --extract --gzip --file "$base/downloads/python.tar.gz" --directory "$python_tmp" --no-same-owner
  chmod 0755 "$python_tmp"
  printf '%s\n' "$python_sha" >"$python_tmp/.palomar-archive-sha256"
  mv -T "$python_tmp" "$python_dir"
fi
safe_dir "$python_dir"
if [[ ! -f $python_dir/.palomar-archive-sha256 ]]; then
  fail "Existing versioned Python prefix has no trusted archive receipt: $python_dir. It was left untouched."
fi
[[ $(cat "$python_dir/.palomar-archive-sha256") == "$python_sha" ]] || fail 'Existing Python origin mismatch.'
"$python_dir/bin/python3.11" -I -c 'import sys,ssl; assert sys.version_info[:3]==(3,11,10); print(sys.version,ssl.OPENSSL_VERSION)'
if [[ ! -x $base/venv/bin/python ]]; then "$python_dir/bin/python3.11" -I -m venv --copies "$base/venv"; fi
if ! "$base/venv/bin/python" -I -c 'import yaml; assert yaml.__version__=="6.0.3"' 2>/dev/null; then
  "$base/venv/bin/python" -I -m pip --isolated install --disable-pip-version-check --no-cache-dir --require-hashes --no-deps --only-binary=:all: -r "$base/downloads/requirements.txt"
fi
"$base/venv/bin/python" -I -c 'import yaml,sys; print(sys.executable,yaml.__version__)'

readonly bdir="$base/bwrap-bin" profile=/etc/apparmor.d/palomar-bwrap
if [[ $(sysctl -n kernel.apparmor_restrict_unprivileged_userns 2>/dev/null || echo 0) == 1 ]]; then
  command -v apparmor_parser >/dev/null || fail 'The official installer requires apparmor_parser on this host.'
  [[ -r /sys/kernel/security/apparmor/profiles ]] || fail 'Cannot identify existing AppArmor profiles.'
  printf '%s\n' 'abi <abi/4.0>,' 'include <tunables/global>' "profile palomar-bwrap $bdir/bwrap flags=(unconfined) {" '  userns,' '}' > "$base/expected-apparmor"
  if [[ -e $profile || -L $profile ]]; then
    [[ -f $profile && ! -L $profile ]] && cmp -s "$base/expected-apparmor" "$profile" || fail 'Conflicting existing palomar-bwrap profile. Left untouched.'
  elif grep -Eq '^palomar-bwrap[[:space:]]' /sys/kernel/security/apparmor/profiles; then
    fail 'Existing loaded palomar-bwrap profile has no matching on-disk definition. Left untouched.'
  fi
fi
safe_dir "$bdir"
# Native build prerequisites stay out of the dpkg database. The Ubuntu APT
# indexes authenticate the packages. Keep the exact chosen package list and hashes.
readonly deps="$base/build-deps"
safe_dir "$deps"
safe_dir "$base/debs"
if [[ ! -f $base/build-deps.sha256 ]]; then
  (
    fetch=$(mktemp -d "$base/.apt.XXXXXX")
    chown _apt:root "$fetch"
    cd "$fetch"
    runuser -u _apt -- apt-get -o APT::Get::AllowUnauthenticated=false download meson ninja-build pkgconf pkgconf-bin pkg-config libpkgconf3 libcap-dev libcap2 python3-packaging python3-setuptools
    for deb in ./*.deb; do install -m 0644 "$deb" "$base/debs/"; done
    cd "$base/debs"
    for deb in ./*.deb; do dpkg-deb -x "$deb" "$deps"; done
    sha256sum ./*.deb > "$base/build-deps.sha256"
  )
fi
(cd "$base/debs" && sha256sum --check --quiet "$base/build-deps.sha256")
export PATH="$deps/usr/bin:/usr/sbin:/usr/bin:/sbin:/bin"
export PYTHONPATH="$deps/usr/lib/python3/dist-packages"
export PKG_CONFIG_PATH="$deps/usr/lib/x86_64-linux-gnu/pkgconfig:$deps/usr/share/pkgconfig"
export LD_LIBRARY_PATH="$deps/usr/lib/x86_64-linux-gnu"
export LIBRARY_PATH="$deps/usr/lib/x86_64-linux-gnu"
export C_INCLUDE_PATH="$deps/usr/include"
meson --version; ninja --version; pkg-config --modversion libcap
if [[ -f $base/bwrap.sha256 ]]; then
  sha256sum --check --quiet "$base/bwrap.sha256" || fail 'Installed bubblewrap no longer matches its receipt.'
  [[ $("$bdir/bwrap" --version) == 'bubblewrap 0.12.0' ]] || fail 'Wrong installed bubblewrap.'
  if [[ -f $base/expected-apparmor ]] && ! grep -Eq '^palomar-bwrap[[:space:]]' /sys/kernel/security/apparmor/profiles; then
    cmp -s "$base/expected-apparmor" "$profile" || fail 'Expected scoped AppArmor profile is missing.'
    apparmor_parser -a "$profile"
  fi
else
  [[ ! -e $bdir/bwrap && ! -L $bdir/bwrap ]] || fail 'Existing unreceipted bwrap binary. Left untouched.'
  /bin/bash "$base/downloads/install_bwrap.sh" "$bdir"
  [[ $("$bdir/bwrap" --version) == 'bubblewrap 0.12.0' ]]
  sha256sum "$bdir/bwrap" > "$base/bwrap.sha256"
fi
printf 'Trusted Python %s\nPinned bubblewrap %s\n' "$base/venv/bin/python" "$bdir/bwrap"
