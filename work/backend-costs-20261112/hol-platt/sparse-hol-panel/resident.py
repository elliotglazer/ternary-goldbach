from pathlib import Path
import sys
out=Path(__file__).resolve().parent/sys.argv[1]
for p in out.glob("PanelWeights*Script.sml"):
    s=p.read_text()
    s=s.replace("Libs meter cv_transLib intLib","Libs replay meter cv_transLib intLib")
    a=s.index("val term=list_mk_comb",s.index("val kd=new_definition"))
    b=s.index('val _=note("BASIS',a)
    s=s[:a]+"""fun enc x=EVAL(mk_comb(replay.enc_for(type_of x),x))
     val _=note("ENCODING "^k)
     val we=replay.literal kd
     val _=note("CHECK "^k)
     val cert=replay.joined (KernelWeightsTheory.kernel_ok_def |> concl |> strip_forall |> #2 |> lhs |> strip_comb |> #1)
                [enc(nat r),enc(nat o1),enc(integer d),we]
     """+s[b:]
    p.write_bytes(s.encode())
