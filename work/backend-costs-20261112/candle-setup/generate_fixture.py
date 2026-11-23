from pathlib import Path
import json,hashlib,copy
H=Path(__file__).resolve().parent
source=H.parents[1]/'lean-pilots/batched-transform/P343N64.json'
rows=json.loads(source.read_text())['rows']
def z(v):return f'(pairc (numc {max(v,0)}) (numc {max(-v,0)}))'
def ls(xs):
    t='(numc 0)'
    for x in reversed(xs):t=f'(pairc {x} {t})'
    return t
xs=ls([ls([z(v) for v in r['input']]) for r in rows])
ys=ls([ls([z(v) for v in r['output']]) for r in rows])
s=z(2**343);b=z(1024*2**343)
text=f'let fixture = `Zstage {xs} {ys} {s} {b}`;;\n'
text+='''bench_mark "first_start";;
let fixture_thm = compute zdefs fixture;;
bench_mark "first_end";;
let _ = if rand (concl fixture_thm) = `numc 1` then print_string "FIXTURE_ACCEPTED\\n" else failwith "wrong result";;
bench_mark "repeat100_start";;
repeat_compute 100 fixture;;
bench_mark "repeat100_end";;
check_axioms ();;
print_string "FIXTURE_DONE\\n";;
'''
(H/'fixture.ml').write_text(text)
(H/'fixture_source.json').write_text(json.dumps(dict(path=str(source),sha256=hashlib.sha256(source.read_bytes()).hexdigest()),indent=2))
controls=[]
wrong=copy.deepcopy(rows);wrong[0]['output'][0]+=1;wrong[0]['output'][2]-=1
controls.append(('rounding',rows,wrong))
controls.append(('missing',rows,rows[1:]))
controls.append(('reordered',rows,[rows[1],rows[0]]+rows[2:]))
bad=copy.deepcopy(rows);bad[0]['input'][4]=0
controls.append(('coefficient',bad,rows))
lines=[]
for name,xx,yy in controls:
    xterm=ls([ls([z(v) for v in r['input']]) for r in xx])
    yterm=ls([ls([z(v) for v in r['output']]) for r in yy])
    tm=f'Zstage {xterm} {yterm} {s} {b}'
    lines.append(f'let _ = let th = compute zdefs `{tm}` in\n'
                 f' if rand (concl th) = `numc 0` then print_string "REJECTED_{name}\\n"\n'
                 ' else failwith "corruption accepted";;')
lines+=['check_axioms ();;', 'print_string "CONTROLS_DONE\\n";;']
(H/'controls.ml').write_text('\n'.join(lines)+'\n')
