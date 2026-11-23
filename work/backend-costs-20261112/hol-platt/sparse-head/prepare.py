"""Reuse verified count packets; emit compact sparse heads and check their original raw projection."""
from pathlib import Path
import hashlib,json,shutil

HERE=Path(__file__).resolve().parent
SRC=HERE.parent/"sparse-count"
JOIN=HERE.parent/"grid-sign-join"
OLD=HERE.parent/"full-height-count"
labels=(3,6667,11,9091)


def write(name,data):
    (HERE/name).write_bytes(data.encode())


def main():
    result=[]
    for l in labels:
        masks=[int(line.split()[0]) for line in (SRC/f"raw-{l}.txt").read_text().splitlines()]
        raw=list(map(int,(OLD/f"grid-{l}.txt").read_text().splitlines()))
        compressed=(JOIN/f"tiles-{l}.txt").read_text().splitlines()
        rows=[]
        count=0
        for i,(mask,line) in enumerate(zip(masks,compressed,strict=True)):
            w,e,n,*words=map(int,line.split())
            R=1<<w
            packed=0
            ids=[j for j in range(n) if mask>>j&1]
            assert mask.bit_length()<=n
            for out,j in enumerate(ids):
                digit=words[j//4]>>(w*(j%4)) & (R-1)
                q=digit-R//2
                assert abs(raw[i*64+j]-q*(1<<e))<=1<<e
                packed+=digit<<(w*out)
            rows.append(f"{mask} {w} {e} {packed:x}")
            count+=len(ids)
        write(f"heads-{l}.txt","\n".join(rows)+"\n")
        for tag in ("jobs","main","aux","target"):
            shutil.copyfile(SRC/f"{tag}-{l}.txt",HERE/f"{tag}-{l}.txt")
        result.append([l,count,sum(len(line.split()[-1]) for line in rows)])
    for p in ("pair-even.txt","pair-odd.txt","Holmakefile"):
        shutil.copyfile(SRC/p,HERE/p)
    script=(SRC/"SparseCountScript.sml").read_text().replace("Theory SparseCount","Theory SparseHead")
    a=script.index("Definition load_row_def:")
    b=script.index("(* Each byte",a)
    script=script[:a]+"""Definition load_row_def:
  (load_row 0 pos mask bits stride unit tab = if mask=0 /\\ bits=0 then SOME tab else NONE) /\\
  (load_row (SUC len) pos mask bits stride unit tab =
    if mask=0 then (if bits=0 then SOME tab else NONE) else
    if mask MOD 2=0 then load_row len (SUC pos) (mask DIV 2) bits stride unit tab else
      load_row len (SUC pos) (mask DIV 2) (bits DIV stride) stride unit
        (sptree$insert pos ((&(bits MOD stride)- &(stride DIV 2)):int,unit:num) tab))
End
Definition load_grid_def:
  (load_grid [] base tab = if base>=85121 then SOME tab else NONE) /\\
  (load_grid ((mask,w,e,bits)::rows) base tab =
    if base>=85121 \\/ w=0 \\/ 256<w \\/ 255<e then NONE else
    case load_row (MIN 64 (85121-base)) base mask bits (2**w) (2**e) tab of NONE => NONE
    | SOME t => load_grid rows (base+64) t)
End

"""+script[b:]
    write("SparseHeadScript.sml",script.replace("pair_from_raw","pair_from_heads"))
    obs=(SRC/"observe.sml").read_text()
    i,j=obs.index("fun row "),obs.index("fun two ")
    obs=obs[:i]+'''fun row [m,w,e,bits] = tuple[nat m,nat w,nat e,numSyntax.mk_numeral(Arbnum.fromHexString bits)]
  | row _ = raise Fail "bad head row";
'''+obs[j:]
    obs=obs.replace("structure observe","structure headobserve").replace("SparseCount","SparseHead").replace("raw-","heads-").replace(":num#num list",":num#num#num#num").replace("pair_from_raw","pair_from_heads").replace("SPARSE_","HEAD_")
    write("headobserve.sml",obs)
    for parity in ("Even","Odd"):
        term=(SRC/f"SparsePair{parity}Script.sml").read_text().replace(f"SparsePair{parity}",f"HeadPair{parity}").replace("SparseCount","SparseHead").replace("observe","headobserve")
        write(f"HeadPair{parity}Script.sml",term)
    shell=(SRC/"run.sh").read_text().replace("SparseCount|SparsePairEven|SparsePairOdd","SparseHead|HeadPairEven|HeadPairOdd").replace("SparseCount)","SparseHead)").replace("SparsePair*)","HeadPair*)").replace("observe.sml inputs.json","headobserve.sml inputs.json").replace("SparseCountTheory","SparseHeadTheory")
    write("run.sh",shell)
    (HERE/"inputs.json").write_text(json.dumps(dict(rows=result,source_sha256=hashlib.sha256((SRC/"inputs.json").read_bytes()).hexdigest()),indent=2))


if __name__=="__main__":
    main()
