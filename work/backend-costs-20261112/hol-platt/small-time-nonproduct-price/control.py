"""Exact end-to-end control of centered splits, diagonal accumulation and slice extraction."""
from random import Random


def run(L,m,T,seed):
    rng=Random(seed)
    K=L+m
    B=1<<32
    a=[rng.randrange(-211,212) for _ in range(L)]
    b=[rng.randrange(-223,224) for _ in range(K)]
    limit=L*211*223
    assert limit<B//2
    def pack(seq):
        return sum(v*B**j for j,v in enumerate(seq))
    aa=[pack(a[i:i+T]) for i in range(0,L,T)]
    bb=[pack(b[i:i+T]) for i in range(0,K,T)]
    top=B**T
    start,end=L-1,L-1+m
    carry=0
    out=[]
    for s in range((end//T)+1):
        low_sum=carry
        carry=0
        for i in range(max(0,s+1-len(bb)),min(s+1,len(aa))):
            j=s-i
            u=i*T+j*T
            v=u+min(T,L-i*T)+min(T,K-j*T)-2
            if v<start or u>end:
                continue
            z=aa[i]*bb[j]
            high=(z+top//2)//top
            low=z-high*top
            if (s+1)*T-1>=start:
                low_sum+=low
            if (s+1)*T<=end:
                carry+=high
        for k in range(T):
            v=(low_sum+B//2)%B-B//2
            low_sum=(low_sum-v)//B
            if start<=s*T+k<=end:
                out.append(v)
    direct=[sum(a[i]*b[q-i] for i in range(L) if 0<=q-i<K) for q in range(start,end+1)]
    assert out==direct


if __name__=="__main__":
    for n in [2,3,4,7,11]:
        for l in [1,3,9,17,37]:
            for m in [0,1,3,13,26]:
                run(l,m,n,1000*n+l+m)
    print("125 centered middle-window controls passed")
