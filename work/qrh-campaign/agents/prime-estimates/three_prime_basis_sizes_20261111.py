"""Only cardinality and representation arithmetic; no prime or sumset evaluation."""
from pathlib import Path
import json

N0=989*10**24
T=N0-1
M=N0//2-4  # Odd targets 9,...,T; 7 has 2+2+3.

def first_ge(predicate):
    hi=1
    while not predicate(hi): hi*=2
    lo=0
    while lo+1<hi:
        mid=(lo+hi)//2
        if predicate(mid): hi=mid
        else: lo=mid
    return hi

balanced=first_ge(lambda n:n**3>=M)
entries=first_ge(lambda s:(s//3)*((s+1)//3)*((s+2)//3)>=M)
unique=first_ge(lambda n:n*(n+1)*(n+2)//6>=M)
ntt_log=(M-1).bit_length()
out=dict(N0=N0,T=T,odd_targets_9_through_T=M,
         balanced_labeled_set_size=balanced,
         minimum_total_labeled_entries=entries,
         minimum_union_size_from_unordered_triples=unique,
         explicit_coverage_mask_bytes=(M+7)//8,
         optimistic_dense_transform_length=2**ntt_log,
         optimistic_dense_transform_log2=ntt_log,
         one_prime_transform_modulus_minimum_bitwidth=ntt_log+1,
         one_array_fixed_90bit_bytes=(90*(2**ntt_log)+7)//8,
         scope='Counting bounds and layout scenarios, not existence or computational lower bounds')
assert (balanced-1)**3<M<=balanced**3
assert (unique-1)*unique*(unique+1)//6<M<=unique*(unique+1)*(unique+2)//6
assert ((entries-1)//3)*(entries//3)*((entries+1)//3)<M
if __name__=='__main__':
    Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
    print(json.dumps(out,indent=2))
