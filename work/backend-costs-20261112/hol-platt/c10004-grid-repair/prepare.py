from pathlib import Path
p=Path(__file__).resolve().parent
s=(p.parent/'c10004-batched-high/batch.py').read_text().replace('Q, FIRST = 10004, 84198','Q, FIRST = 10004, 84184').replace('for h in [FIRST,FIRST+1]:','for h in range(FIRST,FIRST+16):').replace('head = sum((t*step for t,step in terms),acb(0))','terms[:] = [(t*step,step) for t,step in terms]\n                head = sum((t for t,_ in terms),acb(0))')
a=s.index('        path = HERE.parent/')
b=s.index('        result["nodes"]',a)
s=s[:a]+'''        path = HERE/f"j{h}-source.tsv"
        path.write_bytes("".join(lines).encode("ascii"))
        reference=path.read_bytes()
        if h>=84198:
            assert reference==(HERE.parent/"c10004-high-reference"/f"j{h}-source.tsv").read_bytes()
'''+s[b:]
(p/'high.py').write_text(s)
