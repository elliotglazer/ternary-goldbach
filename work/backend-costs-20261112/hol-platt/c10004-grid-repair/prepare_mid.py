from pathlib import Path
here=Path(__file__).resolve().parent
s=(here/'high.py').read_text().replace('Q, FIRST = 10004, 84184','Q, FIRST = 10004, 168369').replace('dt = arb(5)/64','dt = arb(5)/128').replace('acb(0,phase).exp()', 'acb(0,2*phase).exp()').replace('range(FIRST,FIRST+16)','range(FIRST,FIRST+30,2)').replace('if h>=84198:', 'if False:').replace('f"j{h}-source.tsv"','f"mid{h}-source.tsv"').replace('"adaptive.json"','"mid-adaptive.json"')
(here/'mid_source.py').write_text(s)
