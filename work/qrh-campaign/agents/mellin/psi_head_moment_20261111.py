"""Exact scalar consequence of the candidate head data; no spectral assumption certified."""
import contextlib,io,json
from pathlib import Path
with contextlib.redirect_stdout(io.StringIO()):
    from resume_psi_spectral_leaf_20261111 import Q,eup,pl,logs,cl,cu
d=json.loads(Path(__file__).with_name('psi_head_counts_20261111_h1500.json').read_text())
assert d['status']=='PASS_EXTERNAL_HEAD_COUNTS' and d['height']=='1500'
head=Q(d['Q_upper']);assert head<Q('1.668')
al,au=map(Q,logs[1500]);tl,tu=map(Q,logs[10**6])
main=((tu-cl)**2-(al-cu)**2)/(4*pl)+(au-cl-1)/(2*pl)+Q(7,8*1500)
tail=main+(5*(au+1)+20)/1500
value=(Q('1.668')+tail)*(1+eup(Q(35,400)))
assert value<Q('23.953')<24
scale=10**12
print('W35_upper',Q((value.numerator*scale+value.denominator-1)//value.denominator,scale))
print('PASS scalar implication only: requires accepted head certificate, analytic count theorem, and unproved finite strip(.4975,.5025) through1e6.')
