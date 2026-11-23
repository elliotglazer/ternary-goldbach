from delivery import *
import schedule
def geom(n,prec,step=8064):
    G=1<<(prec+76);S=1<<76;P=1<<(prec+2);R=P*2;h=seed(n,G);r,E=mid(h[-1]);d,D=mid(h[-2]);z=(G,0)
    for i in range(step):z,r=prod(z,r,G),prod(r,d,G)
    initial=(*z,*r);err=lambda j: j*(1+2*E)+(2*D+1)*j*(j-1)
    agg=0;actual={}
    for j in range(4096):
        a,b=z
        if j%64==0:x=y=0
        X=(a+S//2)//S;Y=(b+S//2)//S
        assert 2*abs(a-X*S)+2*err(step+4096)<S and 2*abs(b-Y*S)+2*err(step+4096)<S
        x+=(X+P)<<(j%64*(prec+3));y+=(Y+P)<<(j%64*(prec+3))
        z,r=prod(z,r,G),prod(r,d,G)
        if j%64==63:
            agg=(agg+x+3*y)%65537
            if n==524288 and prec==240 and j<1024:actual[j//64]=(x,y)
        if j+1 in (64,1024,4096):
            args=[(j+1)//64,G,S,P,R,err(step+4096),*d,*initial,*z,*r,agg]
            (p/f'case-{n}-{prec}-{j+1}.txt').write_text(' '.join(map(str,args)))
    if actual:
        for label in (3,6667,11,9091):
            lines=(p.parent/'small-time-selected-consumer'/f'b-{label}-4.hex').read_text().splitlines()[1:]
            for j,line in enumerate(lines):
                parts=line.split();assert (int(parts[3],16),int(parts[4],16))==actual[j]
        (p/'row-witnesses.hex').write_text('\n'.join(f'{x:x} {y:x}' for x,y in actual.values()))
prec2=min(k for n,k in schedule.keys if n==262144)
for n,k in [(524288,240),(262144,prec2),(524288,128)]:geom(n,k)
print('independent class',prec2)
