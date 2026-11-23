from delivery import *
from pathlib import Path
p=Path(__file__).resolve().parent;src=p.parent/'small-time-selected-consumer'
n=524288;prec=240;G=1<<(prec+76);scale=1<<76;P=1<<242;R=1<<243
seeds=seed(n,G);r,E=mid(seeds[-1]);d,D=mid(seeds[-2]);z=(G,0);step=8064
for i in range(step):z,r=prod(z,r,G),prod(r,d,G)
def hx(x):return ('-' if x<0 else '')+format(abs(int(x)),'x')
for k in range(16):
    lines=[];radii=(step+1024)*(1+2*E)+(2*D+1)*(step+1024)*(step+1023)
    lines.append(' '.join(map(hx,(G,scale,P,R,radii,*d,*z,*r))))
    for label in (3,6667,11,9091):
        inp=(src/f'b-{label}-4.hex').read_text().splitlines()
        abc=[int(a,16) for a in inp[0].split()[:3]]
        bias=(1<<543)*((1<<(544*1024))-1)//((1<<544)-1);field=(1<<(544*64))-1
        a,b,c=abc
        re=((a-b+bias)>>(k*544*64))&field;im=((c-a-b+bias)>>(k*544*64))&field
        w,e,m,x,y,h,count=[int(t,16) for t in inp[k+1].split()]
        if len(lines)==1:lines.append(' '.join(map(hx,(x,y))))
        lines.append(' '.join(map(hx,(w,e,m,re,im,h,count))))
    for j in range(64):z,r=prod(z,r,G),prod(r,d,G)
    (p/f'share-{k}.hex').write_text('\n'.join(lines))
