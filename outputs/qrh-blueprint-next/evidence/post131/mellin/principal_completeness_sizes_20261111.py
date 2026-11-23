"""Exact evidence-size arithmetic only: no zeta values or zero enumeration."""
import contextlib,io
with contextlib.redirect_stdout(io.StringIO()):
    from resume_psi_spectral_leaf_20261111 import Q,elo,eup,atan_bounds
a,b=atan_bounds(Q(1,5));c,d=atan_bounds(Q(1,239))
pl=Q('3.1415926535897932384626433832795028841971')
pu=Q('3.1415926535897932384626433832795028841972')
assert pl<16*a-4*d and 16*b-4*c<pu
ll=Q('13.815510557964274104107948728106')
lu=Q('13.815510557964274104107948728107')
cl=Q('1.837877066409345483560659472811')
cu=Q('1.837877066409345483560659472812')
assert eup(ll)<10**6<elo(lu)
assert eup(cl)<2*pl and 2*pu<elo(cu)
T=10**6
Flo=T/(2*pu)*(ll-cu-1)+Q(7,8)
Fhi=T/(2*pl)*(lu-cl-1)+Q(7,8)
err=5*lu+20
# The lower bound uses the separately stated two-sided paper consequence:
# |S| and the absolute Binet error give |N-F|<5logT+20 off zero ordinates;
# local right constancy of the closed count extends both sides to all heights.
# It is NOT inferred from the selected one-sided count theorem (C).
lo=-((-(Flo-err).numerator)//(Flo-err).denominator)
hi=(Fhi+err).numerator//(Fhi+err).denominator
assert (lo,hi)==(1747057,1747234)
assert Q('1747145.50863210896162645643862')<Flo<Fhi<Q('1747145.50863210896162645643864')
assert 398**2*(2*pu)<T<399**2*(2*pl)
assert Q(1,3)+Q(3,16*14)<Q('.347')<pl/2
assert 1-Q('.347')**2/2>Q('.939')
blocks=4*(T-14);samples=64*blocks
assert blocks==3999944 and samples==255996416
print('count_interval_from_analytic_bounds',lo,hi,'(not exact N(T))')
print('compressed_alternating_sample_count_interval',lo+1,hi+1)
print('quarter_unit_positive_edge_blocks',blocks,'point_samples_at64',samples)
print('largest_RS_main_sum_length_at_T',398)
print('maximum_endpoint_records_times398',(hi+1)*398,
      '(ordinary RS terms only, excludes search, corrections, low fallback)')
print('PASS exact scalar evidence arithmetic; no spectral data generated.')
