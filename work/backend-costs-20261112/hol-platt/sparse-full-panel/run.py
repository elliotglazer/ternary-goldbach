import os,sys,subprocess
from pathlib import Path
here=Path(__file__).resolve().parent
base=here.parent
for q,bases in [(7689,(2,14)),(7283,(3,2))]:
    d=here/str(q)
    d.mkdir(exist_ok=True)
    for name in ("spectrum","grid","repair"):
        src=(base/"full-height-count"/(name+".py")).read_text()
        src=src.replace('HERE.parent/','HERE.parents[1]/')
        if name=="spectrum":
            src=src.replace("Q = 10000","Q = "+str(q)).replace("BASE_LABELS = (3, 11)","BASE_LABELS = "+repr(bases))
            src=src.replace("second = (-200*z).exp()","second = (-2*z).exp()").replace("for residue in (1,3,7,9):","for residue in (1,):").replace("m+1,240","m+1,24").replace("20*i0+100","2*i0+1").replace("i0+240,m+1),10","i0+24,m+1),1")
        (d/(name+".py")).write_text(src)
        with (d/(name+".log")).open("w") as out:
            subprocess.run([sys.executable,"-u",str(d/(name+".py"))],stdout=out,stderr=subprocess.STDOUT,check=True)
