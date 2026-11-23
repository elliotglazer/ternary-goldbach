"""Prepare two distinct eight-height source panels per band sharing exact residue geometry."""
from pathlib import Path
import hashlib
import json

HERE=Path(__file__).resolve().parent


def read_panels(suffix):
    path=HERE/('resident'+suffix+'.txt')
    fixture=json.loads((HERE/('fixtures'+suffix+'.json')).read_bytes())
    assert fixture['input_sha256']==hashlib.sha256(path.read_bytes()).hexdigest()
    lines=iter(path.read_text().splitlines())
    result=[]
    for case in fixture['cases']:
        tag,depth,bias,n=next(lines).split()
        coeffs=next(lines)
        geo=[next(lines) for _ in range(int(n))]
        checks=[next(lines) for _ in range(4)]
        assert tag==case['tag'] and int(n)==len(case['conductors'])
        count,outputs,digest=checks[-1].split()
        assert n==count and int(outputs)==case['outputs']
        result.append((geo,[tag,depth,bias,n,coeffs,outputs,digest]))
    assert next(lines,None) is None
    return result


def main():
    old=read_panels('-first')+read_panels('')
    new=read_panels('-next-first')+read_panels('-next')
    with (HERE/'geometry.txt').open('w',encoding='ascii',newline='\n') as out:
        for (g,a),(h,b) in zip(old,new,strict=True):
            assert g==h and a[3:4]==b[3:4] and a[4]!=b[4] and a[5]==b[5]
            print(a[3],*g,sep='\n',file=out)
            for tag,depth,bias,n,coeffs,outputs,digest in (a,b):
                print(tag,depth,bias,n,outputs,digest,file=out)
                print(coeffs,file=out)
    src=(HERE/'BandSlabScript.sml').read_text().replace('Theory BandSlab\n','Theory GeoSlab\n')
    src=src[:src.index('fun one()=')]
    src=src.replace('TextIO.openIn "resident.txt"','TextIO.openIn "geometry.txt"')
    src=src.replace('fun encode tm =','fun encodeBase tm =')
    marker='fun stage label tm ='
    helpers="""val geom=ref ([]:term list);
val encs=ref ([]:(term * thm) list);
val reuse=ref false;
val hits=ref 0;
fun encode tm =
  if !reuse andalso List.exists (fn v=>aconv (rand tm) v) (!geom) then
    case List.find (fn (a,_)=>aconv a tm) (!encs) of
      SOME (_,th)=>(hits:=(!hits)+1;th)
    | NONE=>let val th=encodeBase tm in encs:=(tm,th)::(!encs);th end
  else encodeBase tm;
"""
    assert src.count(marker)==1
    src=src.replace(marker,helpers+marker)
    src+="""
fun group()=let val t=cpu()
  val [ng]=tokens()
  val groups=List.tabulate(valOf(Int.fromString ng),fn _=>tokens())
  val vs=nl nn (map hd groups)
  val rss=listSyntax.mk_list(map (fn s=>nl zig (tl s)) groups,``:num list``)
  val _=geom:=[vs,rss] val _=encs:=[]
  val _=print("GEOMLOAD "^ng^" "^Real.toString(cpu()-t)^"\\n")
  fun height order=let val a=cpu()
    val [tag,k,b,n,count,expected]=tokens()
    val cs=nl zig (tokens())
    val tm=list_mk_comb(``resident``,[nn n,nn k,nn b,cs,vs,rss,nn expected])
    val _=print("COEFFLOAD "^tag^" "^Real.toString(cpu()-a)^"\\n")
    fun trial i on=let val _=reuse:=on val _=hits:=0
      val name=tag^"_"^(if on then "reuse" else "plain")^Int.toString i
      val eval=stage name tm
      val _=eval i
      val _=if not on orelse (!hits=2 orelse (order=1 andalso i=1 andalso !hits=0)) then ()
            else raise Fail "geometry cache did not hit both checked conversions"
      in print("HITS "^name^" "^Int.toString(!hits)^"\\n") end
    in List.app(fn i=>List.app(trial i)(if i mod 2=0 then [true,false] else [false,true]))[1,2,3] end
  in height 1; height 2 end;
val _=List.app(fn _=>group())[1,2,3,4,5];
val _=print "GEOMETRY_DONE\\n";
"""
    (HERE/'GeoSlabScript.sml').write_text(src)
    run=(HERE/'run.sh').read_text().replace('BandSlabScript.sml resident.txt','GeoSlabScript.sml geometry.txt')
    run=run.replace('BandSlabTheory.uo','GeoSlabTheory.uo').replace('WEIGHTED_SLAB_DONE','GEOMETRY_DONE')
    (HERE/'run-geometry.sh').write_text(run,newline='\n')


if __name__=='__main__':
    main()
