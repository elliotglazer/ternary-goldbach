from pathlib import Path
import json,sys
out=Path(__file__).resolve().parent/sys.argv[1]
base=out.parent.parent
d=base/"sparse-full-panel"/out.name
src=base/"sparse-head"
def wr(name,s): (out/name).write_bytes(s.encode())
labels=json.loads((d/"spectrum.json").read_bytes())["labels"]
ss=(src/"FusedCountScript.sml").read_text()
ours=(out/"SparseHeadScript.sml").read_text().split("Definition observation_def:")[1].split("Definition exact_observation_def:")[0].replace("observation kernels","fused words kernels").replace("if (2*","if optionally words tab (sptree$fromList kernels) fixes jobs /\\ (2*")
ss=ss.split("Definition fused_def:")[0]+"Definition fused_def:\n"+ours+"Definition outcome_def:"+ss.split("Definition outcome_def:")[1]
ss=ss.replace("Definition margins_def:","Definition join_words_def:\n (join_words ([]:num list)=0) /\\ (join_words (w::ws)=w+2**1024*join_words ws)\nEnd\nDefinition margins_def:").replace(" ws bits 0 of NONE"," ws (join_words bits) 0 of NONE")
wr("FusedCountScript.sml",ss)
w=(src/"fusedworker.sml").read_text().replace("JoinTablesTheory","PanelTablesTheory")
a=w.index("val nums=replay.lines")
b=w.index("val named=",a)
w=w[:a]+"""fun line xs=listSyntax.mk_list(map (numSyntax.mk_numeral o Arbnum.fromHexString) xs,TYnum)
           val nums=replay.lines line ("rawpacked-"^lab^".hex")
           val lit=optionSyntax.mk_some(listSyntax.mk_list(nums,TYlist))
           """.replace("TYnum",chr(96)*2+":num"+chr(96)*2).replace("TYlist",chr(96)*2+":num list"+chr(96)*2)+w[b:]
w=w.replace("NONE:num list option","NONE:num list list option")
w=w[:w.index("fun run on=")]+('fun run on=let val st=cpu() in '+''.join(f'pp "{p}" (record on "{l}" HeadPair{p.title()}Theory.raw_{l}_def) (record on "{r}" HeadPair{p.title()}Theory.raw_{r}_def);\n' for p,l,r in [("even",*labels[:2]),("odd",*labels[2:])])+ 'print("FUSED_WORKER "^Real.toString(cpu()-st)^"\\n") end;\nend;\n')
wr("fusedworker.sml",w)
kernels=(out/"kernels.txt").read_text().splitlines()
sizes=[int(kernels[1+2*i].split()[1]) for i in range(int(kernels[0]))]
for l in labels:
    raw=list(map(int,(d/f"grid-{l}.txt").read_text().splitlines()))
    records=[]
    for line in (out/f"jobs-{l}.txt").read_text().splitlines():
        t,k=map(int,line.split())
        r=sizes[k]; start=129+t//4096-r//2
        rr=raw[start:start+r]
        words=[sum((v+2**255)<<(256*i) for i,v in enumerate(rr[j:j+4])) for j in range(0,r,4)]
        assert all(v.bit_length()<=1024 for v in words)
        records.append(" ".join(format(v,"x") for v in words))
    wr(f"rawpacked-{l}.hex","\n".join(records)+"\n")
for mode in ("Baseline","Margins"):
    n="Fused"+mode+"Script.sml"
    wr(n,(src/n).read_text().replace("JoinTables","PanelTables"))
h=(out/"Holmakefile").read_text()
if "../../grid-enclosure" not in h:wr("Holmakefile",h.strip()+" ../../grid-enclosure\n")
sh=(out/"run.sh").read_text()
if "FusedCount|" not in sh:wr("run.sh",sh.replace("PanelWeights[A-Z]|","FusedCount|FusedBaseline|FusedMargins|PanelWeights[A-Z]|"))
