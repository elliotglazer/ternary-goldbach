#!/bin/sh
set -eu
set -C
cd "$(dirname "$0")"
label=${1:?usage: sh run_traversal_cv.sh fresh_label}
case "$label" in *[!A-Za-z0-9_]*|'') exit 2;; esac
setup="$(cd ../../hol4-setup && pwd -P)"
hol="$setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92"
test -f ../c10004-traversal-refinement/RESULT_REVIEW.md
test -f ../c10004-transform/RESULT_REVIEW.md
sha256sum -c source_expected.sha256 > "${label}_precheck.log"
sha256sum source_expected.sha256 C10004TraversalCVScript.sml traversal_cv_audit.sml \
 Holmakefile run_traversal_cv.sh > "${label}_source.sha256"
sha256sum ../c10004-traversal/.hol/objs/C10004TraversalBaseTheory.uo \
 ../c10004-traversal/.hol/objs/C10004TraversalBaseTheory.dat \
 ../c10004-traversal-refinement/.hol/objs/C10004TraversalRefinementTheory.uo \
 ../c10004-traversal-refinement/.hol/objs/C10004TraversalRefinementTheory.dat \
 ../c10004-projection/.hol/objs/C10004ProjectionTheory.uo \
 ../c10004-projection/.hol/objs/C10004ProjectionTheory.dat \
 ../c10004-transform/.hol/objs/C10004TransformTheory.uo \
 ../c10004-transform/.hol/objs/C10004TransformTheory.dat \
 ../c10004-transform/.hol/objs/C10004TransformTestsTheory.uo \
 ../c10004-transform/.hol/objs/C10004TransformTestsTheory.dat \
 "$setup/.hol/objs/BlockRoundTheory.uo" "$setup/.hol/objs/BlockRoundTheory.dat" \
 "$setup/run.sh" "$hol/bin/Holmake" "$hol/bin/hol.state" \
 "$hol/src/num/theories/cv_compute/cv_computeLib.sml" \
 "$hol/src/num/theories/cv_compute/automation/cv_transLib.sml" \
 "$hol/src/thm/Compute.sml" > "${label}_dependency.sha256"
ulimit -v 4194304
phase () {
 key=$1; shift
 printf '%s\n' "$@" > "${label}_${key}.argv"
 set +e
 "$setup/run.sh" /usr/bin/time -v -o "${label}_${key}.time" timeout -k 15 600 "$@" > "${label}_${key}.log" 2>&1
 status=$?
 set -e
 printf '%s\n' "$status" > "${label}_${key}.status"
 test "$status" -eq 0
}
phase theory "$hol/bin/Holmake" --no_prereqs --no-project --no_preexecs --no-cache -j1 C10004TraversalCVTheory.uo
phase audit_build "$hol/bin/Holmake" --no_prereqs --no-project --no_preexecs --no-cache -j1 traversal_cv_audit.uo
for mode in controls reference_first sequential_first; do
 phase "$mode" env C10004_TRAVERSAL_CV_MODE="$mode" "$hol/bin/hol" --gcthreads=1 run --holstate="$hol/bin/hol.state" traversal_cv_audit
 if test "$mode" = controls; then expected=7; else expected=16; fi
 test "$(grep -c '^TRAVERSAL_CV_TIME,' "${label}_${mode}.log")" -eq "$expected"
 test "$(grep -c '^TRAVERSAL_CV_GENERIC,' "${label}_${mode}.log")" -eq 2
 test "$(grep -c "^C10004_TRAVERSAL_CV_DONE,${mode},INTEGER_ONLY$" "${label}_${mode}.log")" -eq 1
done
sha256sum .hol/objs/C10004TraversalCVTheory.uo .hol/objs/C10004TraversalCVTheory.dat \
 .hol/objs/traversal_cv_audit.uo \
 .hol/objs/C10004TraversalCVControlsDiagnosticsTheory.dat \
 .hol/objs/C10004TraversalCVReferenceFirstDiagnosticsTheory.dat \
 .hol/objs/C10004TraversalCVSequentialFirstDiagnosticsTheory.dat > "${label}_output.sha256"
sha256sum -c "${label}_source.sha256" > "${label}_source_postcheck.log"
sha256sum -c "${label}_dependency.sha256" > "${label}_dependency_postcheck.log"
printf '%s\n' 'C10004_TRAVERSAL_CV_RUN_COMPLETE_REQUIRES_RESULT_REVIEW'
