#!/usr/bin/env bash
# Launch the reviewed source once per CloudShell workspace, then follow the receipt.
set -euo pipefail

commit=d6b1bfd523e2c54b6e4bb72844deeddf8341879a
tree=ddc22b3144b7147ce91c5c767690d9d56aac50ee
runner_rev=bea3421af2bc1d9607d542dd8f9613764156c0da
archive_sha=03e8b1d7d48ff94a1713b1a28096d648e0b0bf37d83a0b16b180e10203a316e3
base=https://raw.githubusercontent.com/elliotglazer/ternary-goldbach/$runner_rev/verification/community-grh/compact

case ${1:-} in
  '') mode=stock; project_options=() ;;
  --tuned)
    mode=tuned
    project_options=(--lake-threads 4
      --preflight-module Lib.General.NumberTheory.QuadField
      --preflight-module Lib.General.Analysis.ZpowSum
      --preflight-module Lib.General.Algebra.RingActions
      --preflight-module Lib.GaloisRep.Pseudocharacter.SemisimpleReps
      --preflight-module TernaryGoldbach.MajorArcs.HHFourier
      --preflight-module Lib.Shimura.Uniformisation.Frames
      --preflight-module Lib.General.Groups.ArtinDefs
      --preflight-module Lib.ClassField.GaloisCohomology.DiscreteUnits
      --preflight-module Lib.DiscreteSeries.Haar.CompactDualMeasure
      --preflight-module Main
      --preflight-module Lib.PadicHodge.PeriodRings.AmaxStructure
      --preflight-module Lib.Adelic.Unitary.CongruenceLevel
      --preflight-module Lib.ClassField.GreenbergWiles.ExtendCharacter
      --preflight-module Lib.Shimura.Uniformisation.ModuliPoint
      --preflight-module Lib.DiscreteSeries.FlenstedJensen.RightDerivatives
      --preflight-module Lib.Adelic.QuotientMeasure.CocompactIntegrable
      --preflight-module Lib.LocalGL.Green.MackeyFormula
      --preflight-module MajorEnergy
      --preflight-module New.Data.Magnitudes
      --preflight-module Lib.DiscreteSeries.CuspKernel.BumpConvolution
    ) ;;
  *) printf '%s\n' 'Expected no option or --tuned.' >&2; exit 2 ;;
esac
if (( $# > 1 )); then exit 2; fi

shared="$HOME/tg-community-run/replay-$commit-$runner_rev"
dir="$shared/$mode"
mkdir -p "$dir"
cd "$dir"
umask 077
exec 9>"$shared/launch.lock"
flock -x 9
curl -fsSL "$base/compact-joint-435.tar.gz" -o bundle.download
printf '%s  %s\n' "$archive_sha" bundle.download | sha256sum -c -
tar -xzf bundle.download
sha256sum -c SHA256SUMS
for f in compact_collect.py compact_watch.py; do
  curl -fsSL "$base/$f" -o "$f.download"
  mv "$f.download" "$f"
done
submission_id() {
  awk '$1=="Submitted" && $2=="compact" && $3=="joint" && $4=="verification," && $5=="attempt" && $7=="profile" && $8=="palomar-32x64"{print $6}' launch.log | tail -1
}
attempt=
if [[ -s launch.log ]]; then
  attempt=$(submission_id)
fi
if [[ ! $attempt =~ ^[0-9a-f]{32}$ ]]; then
  python3 compact_joint_stack.py --commit "$commit" --tree "$tree" --profile palomar-32x64 "${project_options[@]}" | tee -a launch.log
  attempt=$(submission_id)
fi
if [[ ! $attempt =~ ^[0-9a-f]{32}$ ]]; then
  printf '%s\n' "The launcher did not record a submitted attempt. Its output is in $dir/launch.log." >&2
  exit 1
fi
flock -u 9
instance=$(aws --region us-east-1 --no-cli-pager cloudformation describe-stack-resource --stack-name tg-grh-source-replay --logical-resource-id Host --query StackResourceDetail.PhysicalResourceId --output text)
printf 'Following attempt %s. Its receipts will be saved in %s.\n' "$attempt" "$dir"
python3 compact_watch.py --instance "$instance" --commit "$commit" --tree "$tree" --attempt "$attempt" --watch
