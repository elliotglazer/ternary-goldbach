"""Maximum permissible batch opportunities when only equal conductor/kernel tiles are shared."""
import json,sys
from collections import Counter
from pathlib import Path

HERE=Path(__file__).resolve().parent
sys.path.insert(0,str(HERE.parent/"c10000-kronecker-time-price"))
from tiles import SOURCE,primitive_count,pairs


def main():
    rows=json.loads(SOURCE.read_bytes())["scenarios"][0]["small_sign_only_conditional_candidate"]["raw_metadata"]
    out={}
    for b in [2,4,8]:
        counts=Counter()
        for c,m,n,*_ in rows:
            L=2*((25*n+191)//192)+1
            multiplicity=primitive_count(c)
            tilecalls=3*pairs(L,m,65536)["pair_count"]
            groups,left=divmod(multiplicity,b)
            counts["original"]+=tilecalls*multiplicity
            counts["full_batch_calls"]+=tilecalls*groups
            counts["covered_original_calls"]+=tilecalls*groups*b
            counts["leftover_original_calls"]+=tilecalls*left
            counts["all_original_calls_in_conductors_with_too_few_channels"]+=tilecalls*multiplicity*(multiplicity<b)
        assert counts["original"]==1051852215
        out[b]=counts
    (HERE/"fold.json").write_text(json.dumps(out,indent=2)+"\n")


if __name__=="__main__":
    main()
