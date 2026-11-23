from pathlib import Path
import shutil
here=Path(__file__).resolve().parent
out=here/"10000"
out.mkdir(exist_ok=True)
src=here.parent/"sparse-head"
def wr(name,s):(out/name).write_bytes(s.encode())
s=(src/"FusedCountScript.sml").read_text().replace("Theory FusedCount","Theory GroupedCount")
s=s.replace("Definition margins_def:","Definition join_words_def:\n (join_words ([]:num list)=0) /\\ (join_words (w::ws)=w+2**1024*join_words ws)\nEnd\nDefinition margins_def:").replace(" ws bits 0 of NONE"," ws (join_words bits) 0 of NONE")
wr("GroupedCountScript.sml",s)
s=(here/"7689/fusedworker.sml").read_text().replace("FusedCountTheory","GroupedCountTheory").replace("PanelTablesTheory","JoinTablesTheory")
a=s.index("fun run on=")
s=s[:a]+(src/"fusedworker.sml").read_text().split("fun run on=")[1].join(["fun run on=",""])
wr("groupedworker.sml",s.replace("structure fusedworker","structure groupedworker"))
for mode in ("Baseline","Margins"):
    s=(src/f"Fused{mode}Script.sml").read_text().replace("Fused","Grouped").replace("fusedworker","groupedworker")
    wr(f"Grouped{mode}Script.sml",s)
for l in (3,6667,11,9091):
    s=[]
    for line in (src/f"rawpacked-{l}.hex").read_text().splitlines():
        v=int(line,16)
        fields=[(v>>j)%2**1024 for j in range(0,v.bit_length(),1024)]
        assert sum(x<<(j*1024) for j,x in enumerate(fields))==v
        s.append(" ".join(format(x,"x") for x in fields))
    wr(f"rawpacked-{l}.hex","\n".join(s)+"\n")
    shutil.copyfile(src/f"target-{l}.txt",out/f"target-{l}.txt")
for p in ("even","odd"):shutil.copyfile(src/f"pair-{p}.txt",out/f"pair-{p}.txt")
wr("Holmakefile",(here/"7689/Holmakefile").read_text().strip()+" ../../sparse-head\n")
wr("run.sh",(here/"7689/run.sh").read_text().replace("FusedCount|","GroupedCount|GroupedBaseline|GroupedMargins|FusedCount|"))
