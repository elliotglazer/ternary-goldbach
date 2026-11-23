from pathlib import Path
from statistics import median
import json
root=Path(__file__).resolve().parent
rows=[]
for dirname,logname,h,degree in [("throughput","slab01","1–64",9),("throughput-edge","edge01","6337–6400",19)]:
    logfile=root/dirname/(logname+".log")
    lines=logfile.read_text().splitlines()
    assert (root/dirname/(logname+".status")).read_text().strip()=="0"
    term=float(next(line.split()[1] for line in lines if line.startswith("ADMIT_TERM ")))
    for mode in ["delayed","mixed"]:
        admission=float(next(line.split()[2] for line in lines if line.startswith("ADMIT_CV "+mode)))
        x=[[float(z) for z in l.split()[3:6]] for l in lines if l.startswith("SLAB "+mode+" ")]
        assert len(x)==5
        kern,dis,struct=map(median,zip(*x))
        rows.append(dict(heights=h,degree=degree,mode=mode,term_both_s=term,input_admission_s=admission,kernel_us_per_complex=kern*1e6/448,decode_and_discharge_ms=dis*1e3,structural_check_ms=struct*1e3,whole_warm_us_per_complex=median(map(sum,x))*1e6/448,kernel_min_us=min(z[0] for z in x)*1e6/448,kernel_max_us=max(z[0] for z in x)*1e6/448))
(root/"throughput.json").write_text(json.dumps(rows,indent=2)+"\n")
for r in rows:
    print(r["heights"],r["mode"],*(round(r[k],3) for k in ["kernel_us_per_complex","decode_and_discharge_ms","structural_check_ms","whole_warm_us_per_complex","input_admission_s"]))
