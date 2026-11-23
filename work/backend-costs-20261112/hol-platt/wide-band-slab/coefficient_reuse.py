"""Prove separate outputs for disjoint conductor groups from one retained coefficient term."""
from pathlib import Path
import sys
from itertools import accumulate

from geometry_reuse import HERE,read_panels


def digest_group(geo,coeffs,bias,seed):
    q=1<<112
    mask=(1<<120)-1
    h=seed
    for row in geo:
        den,*rs=map(int,row.split())
        for r in rs:
            w=q
            z=bias
            for v in coeffs:
                z+=v*w
                w=(2*w*r+den)//(2*den)
            assert z>=0
            packed=sum(((z>>(232*i+112))&mask)<<(120*i) for i in range(16))
            h=(17*h+packed)%((1<<61)-1)
    return h


def checks(suffix):
    rows=iter((HERE/('resident'+suffix+'.txt')).read_text().splitlines())
    out={}
    for geo,info in read_panels(suffix):
        next(rows)
        next(rows)
        assert [next(rows) for _ in geo]==geo
        expected={int(n):(int(count),int(ans)) for n,count,ans in
                  (next(rows).split() for _ in range(4))}
        out[info[0]]=expected
    return out


def main():
    sys.set_int_max_str_digits(0)
    old=read_panels('-first')+read_panels('')
    new=read_panels('-next-first')+read_panels('-next')
    bytag={k:v for s in ('-first','','-next-first','-next') for k,v in checks(s).items()}
    mod=(1<<61)-1
    with (HERE/'coefficients.txt').open('w',encoding='ascii',newline='\n') as out:
        for (geo,a),(other,b) in zip(old,new,strict=True):
            assert geo==other
            counts=list(accumulate(len(s.split())-1 for s in geo))
            cut=min((n for n in range(1,len(geo)) if 0<counts[n-1]<counts[-1]),
                    key=lambda n:abs(2*counts[n-1]-counts[-1]))
            print(cut,len(geo)-cut,file=out)
            print(*geo,sep='\n',file=out)
            for tag,depth,bias,n,coeffs,outputs,digest in [a,b]:
                panel=bytag[tag]
                size=int(n); seed=panel[0][1]
                packed_coeffs=list(map(int,coeffs.split()))
                left=8*counts[cut-1]
                lh=digest_group(geo[:cut],packed_coeffs,int(bias),seed)
                right=panel[size][0]-left
                assert left>0 and right>0 and right%8==0
                # Digest each packed residue once, with all eight heights in one packed value.
                rh=(int(digest)+(seed-lh)*pow(17,right//8,mod))%mod
                assert (rh+(lh-seed)*pow(17,right//8,mod))%mod==int(digest)
                assert rh==digest_group(geo[cut:],packed_coeffs,int(bias),seed)
                print(tag,depth,bias,lh,rh,file=out)
                print(coeffs,file=out)
    src=(HERE/'GeoSlabScript.sml').read_text()
    src=src[:src.index('fun group()=')].replace('Theory GeoSlab','Theory CoeffSlab').replace('geometry.txt','coefficients.txt')
    src+="""
fun group()=let val [ga,gb]=tokens()
  fun readGeo n=let val rs=List.tabulate(valOf(Int.fromString n),fn _=>tokens())
                in (nl nn (map hd rs),listSyntax.mk_list(map (fn s=>nl zig (tl s)) rs,``:num list``)) end
  val (va,ra)=readGeo ga val (vb,rb)=readGeo gb
  val _=encs:=[]
  fun height h=let val [tag,k,b,la,lb]=tokens()
    val line=tokens() val t=cpu()
    val cs=nl zig line val bias=nn b
    val _=print("LITERAL "^tag^" "^Real.toString(cpu()-t)^"\\n")
    val _=geom:=[va,ra,vb,rb,cs]
    fun check i id n vs rs ans=let val name=tag^id^Int.toString i
      val tm=list_mk_comb(``resident``,[nn n,nn k,bias,cs,vs,rs,nn ans])
      val _=reuse:=true val _=hits:=0
      val eval=stage name tm val _=eval i
      val expected=if i>1 then 3 else if id="B" then (if h=1 then 1 else 3) else (if h=1 then 0 else 2)
      val _=if !hits=expected then () else raise Fail("bad cache hits "^name^": "^Int.toString(!hits))
      in print("HITS "^name^" "^Int.toString(!hits)^"\\n") end
    in List.app(fn i=>(check i "A" ga va ra la; check i "B" gb vb rb lb))[1,2,3] end
  in height 1; height 2 end;
val _=List.app(fn _=>group())[1,2,3,4,5];
val _=print "COEFFICIENT_REUSE_DONE\\n";
"""
    (HERE/'CoeffSlabScript.sml').write_text(src)
    run=(HERE/'run-geometry.sh').read_text().replace('GeoSlabScript.sml geometry.txt','CoeffSlabScript.sml coefficients.txt')
    run=run.replace('GeoSlabTheory.uo','CoeffSlabTheory.uo').replace('GEOMETRY_DONE','COEFFICIENT_REUSE_DONE')
    (HERE/'run-coefficients.sh').write_text(run,newline='\n')


if __name__=='__main__':
    main()
