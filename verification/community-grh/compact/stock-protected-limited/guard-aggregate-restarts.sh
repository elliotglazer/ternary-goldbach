#!/bin/sh
# Defer needrestart's automatic restart of the diagnostic proof service on Ubuntu Noble.
set -eu
export PATH=/usr/sbin:/usr/bin:/sbin:/bin
action=${1:-status}
cfg=/etc/needrestart/conf.d/99-tg-palomar-aggregate.conf
candidate='$nrconf{override_rc}{qr(^tg-palomar-aggregate-[0-9a-f]{24}\.service$)} = 0;'
version=$(dpkg-query -W -f='${Version}' needrestart)
case "$version" in 3.6-7ubuntu4*) ;; *) echo "Unreviewed Ubuntu needrestart version: $version" >&2; exit 2;; esac
same() { [ -f "$cfg" ] && [ ! -L "$cfg" ] && [ "$(stat -c %u:%a "$cfg")" = 0:644 ] && printf '%s\n' "$candidate" | cmp -s - "$cfg"; }
case "$action" in
  install)
    [ "$(id -u)" = 0 ]
    if same; then echo "Already installed"; exit; fi
    [ ! -e "$cfg" ] && [ ! -L "$cfg" ] || { echo "Preserving a different existing file at $cfg" >&2; exit 1; }
    [ -d /etc/needrestart/conf.d ] && [ ! -L /etc/needrestart/conf.d ]
    tmp=$(mktemp /etc/needrestart/conf.d/.tg-palomar-aggregate.XXXXXXXX)
    trap 'rm -f -- "$tmp"' EXIT HUP INT TERM
    printf '%s\n' "$candidate" > "$tmp"
    chmod 0644 "$tmp"
    ln -T -- "$tmp" "$cfg"
    same
    echo "Deferred the bounded Palomar system controller for future needrestart scans"
    ;;
  status)
    if same; then echo "Active on needrestart $version"; elif [ -e "$cfg" ] || [ -L "$cfg" ]; then echo "Conflicting file: $cfg" >&2; exit 1; else echo "Inactive"; fi
    ;;
  list)
    # Explicit list-only mode scans outdated processes. It never requests a restart.
    exec /usr/sbin/needrestart -r l -l -m u
    ;;
  remove)
    [ "$(id -u)" = 0 ]
    if [ ! -e "$cfg" ] && [ ! -L "$cfg" ]; then echo "Already absent"; exit; fi
    same || { echo "Preserving a different file at $cfg" >&2; exit 1; }
    rm -- "$cfg"
    echo "Restored normal selection for the bounded Palomar system controller"
    ;;
  *) echo "Usage: guard-warm-restarts.sh install|status|list|remove" >&2; exit 2;;
esac
