#!/bin/sh
set -eu
root=/mnt/host/c/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean
base=$root/work/backend-costs-20261112
local=$base/hol-platt/source-raw-head-bridge/h1-head-match
setup=$base/hol4-setup
hol=$setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92
mode=${1:?mode required}
label=${2:?fresh label required}
case "$label" in *[!A-Za-z0-9_]*|'') exit 2;; esac
cd "$local"
test ! -e "${label}.status"
mount --make-rprivate /
mount --bind "$root" "$root"
mount --bind "$local" "$local"
mount -o remount,bind,ro "$root"
for dep in source-raw-head-bridge raw-pair-round-proof source-log-real source-log-horner source-log-range source-phase-range source-exp-horner source-state-error source-state-bounds source-inverse-root source-initial source-phase-taylor source-raw-state-bridge ../raw-state-handoff source-producer raw-analytic/dependency-build-win01 c10004-full-integer c10004-packed-input-hol c10004-horner-price c10004-hol-shared-phase c10004-traversal-cv c10004-traversal c10004-traversal-refinement c10004-transform c10004-projection ../hol4-setup; do
  d="$base/hol-platt/$dep/.hol/make-deps"
  dest="$local/metadata/$(basename "$dep")"
  mkdir -p "$dest"
  cp -a "$d/." "$dest/"
  mount --bind "$dest" "$d"
done
ulimit -v 4194304
sha256sum H1RawCvScript.sml Holmakefile run.sh ../.hol/objs/SourceRawHeadBoundsTheory.dat ../.hol/objs/SourceRawHeadBridgeTheory.dat ../../c10004-p20-source/h1-rawhead.tsv ../../c10004-full-integer/heads.txt ../../c10004-full-integer/.hol/objs/C10004FullAdmissionTheory.dat ../../c10004-full-integer/.hol/objs/C10004FullIdentityTheory.dat ../../c10004-full-integer/.hol/objs/C10004FullIntegerTheory.dat > "${label}.sha256"
case "$mode" in
 generic) target=H1RawCvTheory.uo;;
 data) target=H1FiniteHeadsTheory.uo; sha256sum H1FiniteHeadsScript.sml >> "${label}.sha256";;
 audit) target=match_audit.uo; sha256sum H1FiniteHeadsScript.sml match_audit.sml .hol/objs/H1FiniteHeadsTheory.dat .hol/objs/H1RawCvTheory.dat >> "${label}.sha256";;
 *) exit 2;;
esac
set +e
"$setup/run.sh" /usr/bin/time -v -o "${label}_build.time" timeout -k 10 900 "$hol/bin/Holmake" --no_prereqs --no-project --no_preexecs --no-cache -j1 "$target" > "${label}.log" 2>&1
code=$?
if test "$code" -eq 0 && test "$mode" = audit; then
   "$setup/run.sh" /usr/bin/time -v -o "${label}_audit.time" timeout -k 10 600 "$hol/bin/hol" --gcthreads=1 run --holstate="$hol/bin/hol.state" match_audit >> "${label}.log" 2>&1
   code=$?
fi
set -e
if test "$code" -eq 0; then
 sha256sum -c "${label}.sha256" > "${label}_postcheck.log"
 if test "$mode" = audit; then
   grep -qx 'HEAD_MATCH_AUDIT_DONE' "${label}.log"
   sha256sum .hol/objs/H1RawCvTheory.dat .hol/objs/H1FiniteHeadsTheory.dat > "${label}_output.sha256"
 fi
fi
printf '%s\n' "$code" > "${label}.status"
tail -n 25 "${label}.log"
exit "$code"
