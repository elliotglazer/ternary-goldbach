from delivery import *
src=p.parents[2]/'qrh-campaign/agents/prime-estimates/sign_only_minimal_theta_nonprincipal_schedule_20261111.json'
sc=next(sc for sc in json.loads(src.read_bytes())['scenarios'] if sc['extra_nodes']==640)['small_sign_only_conditional_candidate']
c,m,n,_,_=next(row for row in sc['raw_metadata'] if row[0]==10000)
t=dict(sc['conductor_theta'])[c]; L=2*((25*n+191)//192)+1
B0=2*F(80000000,t)**2+1
v=((7*B0+12)*L+n)/F(35*n,2816*64*2**82*3**t)
k=v.numerator.bit_length()-v.denominator.bit_length()
prec=k+int((1<<k)*v.denominator<v.numerator)+1
sites=((m+129+63)//64)*64
G=1<<(prec+76); S=1<<76; P=1<<(prec+2); R=2*P
z=(G,0); hist=seed(n,G); r,E=mid(hist[-1]); d,D=mid(hist[-2]); ini=(*z,*r)
B=sites*(1+2*E)+(2*D+1)*sites*(sites-1)
h=0
for j in range(sites):
    if j%64==0: x=y=0
    a,b=((u+S//2)//S for u in z)
    assert all(2*abs(u-S*i)+2*B<S for u,i in zip(z,(a,b)))
    x+=(a+P)<<((j%64)*(prec+3)); y+=(b+P)<<((j%64)*(prec+3))
    z,r=prod(z,r,G),prod(r,d,G)
    if j%64==63: h=(h+x+3*y)%65537
(p/'guard-real.txt').write_text(' '.join(map(str,[sites//64,G,S,P,R,B,*d,*ini,*z,*r,h])))
print(c,m,n,prec,sites,B)
