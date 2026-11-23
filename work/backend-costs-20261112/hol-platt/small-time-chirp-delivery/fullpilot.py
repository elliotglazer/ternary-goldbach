from delivery import *
G=1<<316;S=1<<76;P=1<<242;R=1<<243;seedhist=seed(524288,G);z=(G,0);r,E=mid(seedhist[-1]);d,D=mid(seedhist[-2]);initial=(*z,*r)
maxj=85056;B=maxj*(1+2*E)+(2*D+1)*maxj*(maxj-1);h=0
for j in range(maxj):
 if j%64==0:x=y=0
 X=(z[0]+S//2)//S;Y=(z[1]+S//2)//S
 assert 2*abs(z[0]-X*S)+2*B<S and 2*abs(z[1]-Y*S)+2*B<S
 x+=(X+P)<<((j%64)*243);y+=(Y+P)<<((j%64)*243)
 z,r=prod(z,r,G),prod(r,d,G)
 if j%64==63:
    h=(h+x+3*y)%65537
    if j+1 in [8064+64*i for i in range(17)]+[maxj]:
        args=[(j+1)//64,G,S,P,R,B,*d,*initial,*z,*r,h]
        (p/f'full-{j+1}.txt').write_text(' '.join(map(str,args)))
        if 8064<=j+1<9088:
            k=(j+1-8064)//64;first=[int(v,16) for v in (p/f'share-{k}.hex').read_text().splitlines()[0].split()]
            assert first[-4:]==[*z,*r]
