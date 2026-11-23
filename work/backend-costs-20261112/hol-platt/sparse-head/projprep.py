"""Build retained-only raw projection batches and use the existing stock HOL project_ok theorem."""
from pathlib import Path
import json
import prepare

H=prepare.HERE
P=H.parent/"grid-projection"
records=0
samples=0
with (H/"retained.hex").open("w",newline="\n") as f:
    for label in prepare.labels:
        raw=list(map(int,(prepare.OLD/f"grid-{label}.txt").read_text().splitlines()))
        for i,line in enumerate((H/f"heads-{label}.txt").read_text().splitlines()):
            m,w,e,bits=line.split()
            mask,w,e,bits=int(m),int(w),int(e),int(bits,16)
            ids=[j for j in range(64) if mask>>j&1]
            if not ids:
                assert bits==0
                continue
            n=len(ids)
            xx=[raw[i*64+j] for j in ids]
            cap=(1<<w)-1
            hh=[(bits>>(w*j))&cap for j in range(n)]
            assert all(x//(1<<e)==d-(1<<(w-1)) for x,d in zip(xx,hh))
            f.write(f"{label} {i} {mask} {w} {e} {n}\n")
            f.write(" ".join(format(sum((x+(1<<255))<<(256*t) for t,x in enumerate(xx[j:j+4])),"x") for j in range(0,n,4))+"\n")
            f.write(" ".join(str(sum(d<<(w*t) for t,d in enumerate(hh[j:j+4]))) for j in range(0,n,4))+"\n")
            records+=1
            samples+=n
assert samples==71325
template=(P/"projection.sml").read_text().split("fun run full =")[0].replace("structure projection","structure keptprojection")
template+=r'''
fun run () =
 let val t0=cpu() val schema=Vector.tabulate(16,fn i=>stream_template(i+1))
     val start=cpu() val inp=TextIO.openIn "retained.hex"
     val numtime=ref 0.0 and evaltime=ref 0.0
     fun words s=String.tokens Char.isSpace s
     fun next()=words(valOf(TextIO.inputLine inp))
     fun go tiles fields bad =
       case TextIO.inputLine inp of NONE => (tiles,fields,bad) | SOME s =>
       let val t=cpu()
           val [lab,ix,mask,w,e,n]=words s
           val count=valOf(Int.fromString n)
           val a=map (numSyntax.mk_numeral o Arbnum.fromHexString) (next())
           val b=map nat (next())
           val params=map nat [w,e,n]
           val _=require(length a=(count+3) div 4 andalso length b=length a) "word count"
           val check=Vector.sub(schema,length a-1)
           val t1=cpu()
           val th=check(params@a@b)true
           val t2=cpu()
           val wanted=list_mk_comb(``Project$project_ok``,params@[natlist a,natlist b])
           val _=require(aconv wanted(concl th)) "projection conclusion"
           val control=tiles mod 1100=0
           val _=if control then
             let val b0=numSyntax.mk_numeral(Arbnum.+(numSyntax.dest_numeral(hd b),Arbnum.one))
                 val wrong=check(params@a@(b0::tl b))false
             in ignore(save_thm("admit_"^lab^"_"^ix,th)); ignore(save_thm("reject_"^lab^"_"^ix,wrong)) end else ()
           val _=numtime:= !numtime+t1-t
           val _=evaltime:= !evaltime+t2-t1
       in go (tiles+1) (fields+count) (if control then bad+1 else bad) end
     val (tiles,fields,bad)=go 0 0 0
     val _=TextIO.closeIn inp
     val _=require(tiles=RECORDS andalso fields=71325 andalso bad=(tiles+1099) div 1100) "projection total"
     val _=print("RETAINED_PROJECTION "^Int.toString tiles^" "^Int.toString fields^" "^Int.toString bad^" "^
       String.concatWith " " (map Real.toString [start-t0,!numtime,!evaltime,cpu()-t0])^"\n")
 in () end;
end;
'''.replace("RECORDS",str(records))
prepare.write("keptprojection.sml",template)
prepare.write("HeadProjectionScript.sml","Theory HeadProjection\nAncestors Project\nLibs keptprojection\nval _=keptprojection.run();\n")
hol=(H/"Holmakefile").read_text().rstrip()+" ../grid-projection\n"
prepare.write("Holmakefile",hol)
shell=(H/"run.sh").read_text().replace("SparseHead|HeadPairEven|HeadPairOdd","SparseHead|HeadPairEven|HeadPairOdd|HeadProjection")
shell=shell.replace(" SparseHead)"," HeadProjection) sha256sum retained.hex keptprojection.sml ../grid-projection/.hol/objs/ProjectTheory.dat >> \"$label.sha256\";;\n SparseHead)")
prepare.write("run.sh",shell)
print(records,samples)
