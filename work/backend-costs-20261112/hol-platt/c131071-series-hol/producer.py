import json,sys,time,statistics
from pathlib import Path
sys.set_int_max_str_digits(0)
p=Path(__file__).resolve().parent
lines=iter((p/"terms.txt").read_text().splitlines())
for case in json.loads((p/"cases.json").read_text()):
    next(lines)
    coords=[]
    for _ in range(2):
        cs=list(map(int,next(lines).split())); target=int(next(lines));out=list(map(int,next(lines).split()))
        coords.append((cs,target,out))
    b,w,n,r,v=(case[k] for k in ["B","w","n","r","v"])
    half=b//2
    bias=(b**n-1)//(b-1)*half
    def candidate():
        values=[]
        for cs,target,out in coords:
            ys=[]
            for i in range(n):
                z=0
                t=r+1024*i
                for a in reversed(cs):z=z*t+a
                ys.append(z)
            values.append(ys)
        return values
    vals=candidate()
    def pack(values):
        return [int.from_bytes(b"".join((y+half).to_bytes(w//8,"little") for y in ys),"little")-bias for ys in values]
    assert pack(vals)==[t for _,t,_ in coords]
    def timer(f):
        a=[]
        for j in range(7):
            t=time.perf_counter_ns()
            for _ in range(25):f()
            a.append((time.perf_counter_ns()-t)/25000)
        return statistics.median(a)
    print(case["name"],"native_us_per_cell candidate",timer(candidate),"pack",timer(lambda:pack(vals)),"joint",timer(lambda:pack(candidate())))
