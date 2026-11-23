from pathlib import Path
import sys,types
d=Path(__file__).resolve().parent
p=d.parent
sys.path.insert(0,str(p))
import standalone as st
base=st.sources
for mode in ('lcm','control'):
    if mode=='lcm':
        def sources(power,cert):
            files=base(power,cert)
            return [*files[:-1],d/'LcmBridge.lean',files[-1]]
        st.sources=sources
    else:
        st.sources=base
    args=types.SimpleNamespace(out=d/mode,certificate_dir=d if mode=='lcm' else p/'compact-prefix',
          lean=Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean.exe',
          packages=Path.home()/'Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages',
          recheck_only=False,emit_only=False,memory=3500)
    st.run(9,args)
