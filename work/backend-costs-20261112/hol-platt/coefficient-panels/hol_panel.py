"""Create stock-HOL inputs for a Kronecker-substitution Taylor shift on 16 cells."""
import hashlib
import json
from pathlib import Path
import sys
from panel import HERE, ORDER, OUTPUT_BITS, SEED_BITS, seed, expand
from flint import ctx

B = 1<<640
O = 1<<128
C = 1<<352
M = B**ORDER


def pack(xs,base):
    return sum(x*base**i for i,x in enumerate(xs))


def field(vals):
    return " ".join(map(str,vals))


def fixture(band,rec):
    f,D=band["f"],band["degree"]
    assert 352+D+(D+1)*3+2 < 639
    coeff=seed(f,rec["first_cell"]+8,rec["j"],D,SEED_BITS)
    assert max(abs(v) for xy in coeff for v in xy)<C
    den=1<<(SEED_BITS+D-OUTPUT_BITS)
    adj=pack([B//2+den//2]*ORDER,B)
    xs=[[v[part]+C for v in reversed(coeff)] for part in (0,1)]
    expected=[[],[]]
    for d in range(-8,8):
        ys=expand(coeff,d)
        for part in (0,1):
            acc=0
            for k,x in enumerate(xs[part]):
                acc=(acc*(2*B+d)+((x-C)<<k))%M
            out=(acc+adj)%M
            values=[pair[part] for pair in ys]
            assert all(abs(v)<O//2 for v in values)
            assert [((out//B**k)%B)//den-B//(2*den) for k in range(ORDER)]==values
            expected[part].append(pack([v+O//2 for v in values],O))
    return [field([band["band"],D,den,adj,B//(2*den)]),field(xs[0]),field(xs[1]),
            field(2*B+d for d in range(-8,8)),field(expected[0]),field(expected[1])]


def main():
    sys.set_int_max_str_digits(0)
    ctx.prec,ctx.threads=440,1
    blocks=[]
    bands=json.loads((HERE/"panels.json").read_bytes())["bands"]
    if "--fresh" in sys.argv:
        fresh(bands)
        return
    for band in bands:
        blocks.extend(fixture(band,band["panels"][1]))
    (HERE/"kernel-input.txt").write_text("\n".join(blocks)+"\n",newline="\n")
    code=f"""Theory CoeffTranslate
Ancestors list arithmetic cv_std
Libs cv_transLib

Definition poly_def:
  (poly (r:num) scale a ([]:num list) = a) /\\
  (poly r scale a (c::cs) = poly r (2*scale)
     ((a*r+c*scale+{M}-{C}*scale) MOD {M}) cs)
End
Definition digits_def:
  (digits 0 (den:num) adjust x y = (y=0)) /\\
  (digits (SUC n) den adjust x y =
     (((x MOD {B}) DIV den + {O//2} = y MOD {O} + adjust) /\\
       digits n den adjust (x DIV {B}) (y DIV {O})))
End
Definition coord_def:
  coord r den adjust bias xs y =
    digits 20 den adjust ((poly r 1 0 xs + bias) MOD {M}) y
End
Definition allcells_def:
  (allcells den adjust bias xs ys [] es fs = (es=[] /\\ fs=[])) /\\
  (allcells den adjust bias xs ys (r::rs) [] fs = F) /\\
  (allcells den adjust bias xs ys (r::rs) (e::es) [] = F) /\\
  (allcells den adjust bias xs ys (r::rs) (e::es) (f::fs) =
      (coord r den adjust bias xs e /\\ coord r den adjust bias ys f /\\
       allcells den adjust bias xs ys rs es fs))
End
Definition repeat_def:
  (repeat 0 den adjust bias xs ys rs es fs = T) /\\
  (repeat (SUC n) den adjust bias xs ys rs es fs =
      (allcells den adjust bias xs ys rs es fs /\\ repeat n den adjust bias xs ys rs es fs))
End
val _=cv_auto_trans repeat_def;
"""
    harness=(HERE.parent/"wide-band-slab/BandSlabScript.sml").read_text()
    helper=harness[harness.index("val clock="):harness.index("fun one()=")].replace("resident.txt","kernel-input.txt")
    code+=helper+"""
fun bench i=let val [id,depth,den,bias,adj]=tokens()
   val xs=nl nn (tokens()) val ys=nl nn (tokens()) val rs=nl nn (tokens())
   val es=nl nn (tokens()) val fs=nl nn (tokens())
   fun make n=stage (id^"_"^n) (list_mk_comb(``CoeffTranslate$repeat``,
     [nn n,nn den,nn adj,nn bias,xs,ys,rs,es,fs]))
   val runs=map make ["0","1","3"]
 in List.app(fn j=>List.app(fn f=>f j)(if j mod 2=0 then rev runs else runs))[0,1,2,3,4] end;
val _=List.app bench [1,2,3,4,5];
val _=TextIO.closeIn io;
val _=print "COEFFICIENT_TRANSLATION_DONE\\n";
"""
    (HERE/"CoeffTranslateScript.sml").write_text(code,newline="\n")
    (HERE/"Holmakefile").write_bytes((HERE.parent/"wide-band-slab/Holmakefile").read_bytes())
    run=(HERE.parent/"wide-band-slab/run-first.sh").read_text().replace("FirstBandSlab","CoeffTranslate").replace(
        "resident-first.txt","kernel-input.txt panels.json").replace("WEIGHTED_SLAB_DONE","COEFFICIENT_TRANSLATION_DONE")
    (HERE/"run.sh").write_text(run,newline="\n")


def fresh(bands):
    allrows=[s for band in bands for panel in band["panels"] for s in fixture(band,panel)]
    (HERE/"fresh-input.txt").write_text("\n".join(allrows)+"\n",newline="\n")
    base=(HERE/"CoeffTranslateScript.sml").read_text()
    helper=base[base.index("val clock="):base.index("fun bench i=")].replace("kernel-input.txt","fresh-input.txt")
    code="""Theory FreshTranslate
Ancestors CoeffTranslate
Libs cv_transLib
Definition reject_def:
   reject den adjust bias xs ys rs es fs = ~allcells den adjust bias xs ys rs es fs
End
val _=cv_auto_trans reject_def;
"""+helper+"""
fun test i=let val begin=cpu() val [id,depth,den,bias,adj]=tokens()
    val xs=nl nn (tokens()) val ys=nl nn (tokens()) val rs=nl nn (tokens())
    val es=nl nn (tokens()) val fs=nl nn (tokens())
    val args=[nn den,nn adj,nn bias,xs,ys,rs,es,fs]
    val label=id^"_"^Int.toString i
    val _=stage label (list_mk_comb(``CoeffTranslate$allcells``,args)) 0
    val _=print("FRESH "^id^" "^Int.toString i^" "^Real.toString(cpu()-begin)^"\\n")
    val _=if i<>0 then () else let val (zs,ty)=listSyntax.dest_list es
        val damaged=listSyntax.mk_list(numSyntax.mk_numeral(Arbnum.+(numSyntax.dest_numeral(hd zs),Arbnum.one))::tl zs,ty)
      in stage "bad" (list_mk_comb(``FreshTranslate$reject``,[nn den,nn adj,nn bias,xs,ys,rs,damaged,fs])) 0 end
  in () end;
val _=List.app test (List.tabulate(15,fn i=>i));
val _=TextIO.closeIn io;
val _=print "COEFFICIENT_TRANSLATION_DONE\\n";
"""
    (HERE/"FreshTranslateScript.sml").write_text(code,newline="\n")
    runner=(HERE/"run.sh").read_text().replace("CoeffTranslate","FreshTranslate").replace("kernel-input.txt","fresh-input.txt")
    (HERE/"run-fresh.sh").write_text(runner,newline="\n")


if __name__=="__main__":
    main()
