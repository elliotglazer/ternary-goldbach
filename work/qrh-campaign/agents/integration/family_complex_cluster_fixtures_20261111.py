"""Tiny exact point-multiset fixtures, not analytic or actual L-function data.

These test bookkeeping only. The points are stipulated, not discovered and not
certified by winding. No assertion about any Dirichlet character follows.
"""
from fractions import Fraction as F
from pathlib import Path
import hashlib
import json

T,H=F(100),F(110)
b=F(111,200)
def point(x,y,m): return (F(x),F(y),m)
def conjugate(points): return [(x,-y,m) for x,y,m in points]
def count(points,predicate): return sum(m for x,y,m in points if predicate(x,y))
def box(points,left,right,bottom,top):
    l,r,d,u=map(F,(left,right,bottom,top))
    return count(points,lambda x,y:l<x<r and d<y<u)
def actual_added_weight(points):
    return sum((m*(H-abs(y)) for x,y,m in points if T<abs(y)<=H),F(0))

nonreal=[point('.46',40,2),point('.54',40,2),
         point('.47',-60,1),point('.53',-60,1),
         point('.48',0,2),point('.52',0,2),
         point('.5','.5',3),point('.5','-.5',3),
         point('.4',102,2),point('.6',102,2),
         point('.45',104,1),point('.55',104,1),point('.5',-103,3)]
inverse=conjugate(nonreal)
main_plus=box(nonreal,'.4','.55',39,41)
main_inverse=box(inverse,'.4','.55',59,61)
central=box(nonreal,'.4','.55',-1,1)
K=main_plus+main_inverse+central
C=count(nonreal,lambda x,y:abs(y)<=T)
assert (main_plus,main_inverse,central,K,C)==(4,2,10,16,16)
assert count(nonreal,lambda x,y:abs(y)<=T and x>b)==0
aux_plus=box(nonreal,'.3','.7',101,105)
aux_inverse=box(inverse,'.3','.7',102,104)
W=aux_plus*(H-105)+aux_inverse*(H-104)
L=actual_added_weight(nonreal)
assert (aux_plus,aux_inverse,W,L)==(6,3,48,65)
assert W<=L
assert 2*C>C  # invalid: adding both full-plane counts double counts the target.

positive_real=[point('.46',40,2),point('.54',40,2),point('.5',102,4)]
real=positive_real+conjugate(positive_real)+[
    point('.5',0,2),point('.5','.5',2),point('.5','-.5',2)]
real_plus=box(real,'.4','.55',39,41)
real_central=box(real,'.4','.55',-1,1)
real_K=2*real_plus+real_central
real_C=count(real,lambda x,y:abs(y)<=T)
real_aux=box(real,'.4','.55',101,103)
real_W=2*real_aux*(H-103)
real_L=actual_added_weight(real)
assert (real_plus,real_central,real_K,real_C)==(4,6,14,14)
assert (real_aux,real_W,real_L)==(4,56,64)
assert real_W<=real_L
assert 2*(real_plus+real_central)>real_C  # invalid: double the central cluster.

receipt={
    'status':'PASS_SYNTHETIC_MULTIPLICITY_BOOKKEEPING_ONLY',
    'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
    'T':str(T),'H':str(H),
    'nonreal':{'positive_main':main_plus,'inverse_positive_main':main_inverse,
               'direct_central':central,'K':K,'C':C,
               'auxiliary_counts':[aux_plus,aux_inverse], 'W':str(W),
               'actual_integrated_added_count':str(L)},
    'real':{'positive_main':real_plus,'direct_central':real_central,
            'K':real_K,'C':real_C,'positive_auxiliary_count':real_aux,
            'W':str(real_W),'actual_integrated_added_count':str(real_L)},
    'scope':'Stipulated finite multisets only. No winding certificates, actual L-functions, Turing bounds, or saturation data.',
}
Path(__file__).with_suffix('.json').write_text(json.dumps(receipt,indent=2)+'\n')
print(json.dumps(receipt,indent=2))
