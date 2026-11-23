#!/bin/sh
set -eu
set -C
cd "$(dirname "$0")"
label=${1:?usage: sh run_inspection.sh fresh_label}
case "$label" in *[!A-Za-z0-9_]*|'') exit 2;; esac
setup="$(cd ../../../hol4-setup && pwd -P)"
hol="$setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92"
sha256sum inspect_cv.sml Holmakefile run_inspection.sh > "${label}_sources.sha256"
(cd .. && sha256sum -c round03_artifacts.sha256) > "${label}_dependency_check_before.log"
ulimit -v 4194304
"$setup/run.sh" /usr/bin/time -v -o "${label}_build.time" \
  timeout 600 "$hol/bin/Holmake" --no_prereqs inspect_cv.exe \
  > "${label}_build.log" 2>&1
"$setup/run.sh" /usr/bin/time -v -o "${label}_run.time" \
  timeout 600 ./inspect_cv.exe > "${label}_run.log" 2>&1
sha256sum -c "${label}_sources.sha256" > "${label}_source_check.log"
(cd .. && sha256sum -c round03_artifacts.sha256) > "${label}_dependency_check_after.log"
printf '%s\n' 'CV_INSPECTION_COMPLETED'
