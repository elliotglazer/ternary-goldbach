from pathlib import Path
d=Path(__file__).resolve().parent
p=d/'AbsorbedScript.sml'; s=p.read_text()
a=s.index('Definition cache_def:');b=s.index('Definition collect_def:')
s=s[:a]+"""Definition cache_one_def:
 cache_one sc (p,q,f,g,e,rawerr) (u,v) =
  let z=FastAxis$rotate2 sc (FastAxis$kdiv sc 2) (p,q) (u,v);
      a=FST z; b=SND z;
      ep=FastAxis$kdiv (ABS p+ABS q+ABS u+ABS v+2+sc-1) sc + 1;
      ch=if ABS a<=ep \\/ ABS b<=ep then 0 else Fused$choose (a,b) (f,g)
  in (ch,rawerr,(p,q,f,g,e))
End
Definition cache_def:
 (cache sc [] ws = []) /\\
 (cache sc (z::zs) ws = case ws of []=>[] | w::ww => cache_one sc z w::cache sc zs ww)
End
"""+s[b:]
p.write_bytes(s.encode())
