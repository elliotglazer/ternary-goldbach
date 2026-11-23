from pathlib import Path
d=Path(__file__).resolve().parent
for p in [24,28,81]:
 rows=[list(map(int,l.split())) for l in (d/f"data{p}.txt").read_text().splitlines()]
 (d/f"sum{p}.txt").write_text(str(sum(r+3*i+s+3*j for _,_,r,i,s,j in rows))+"\n")
