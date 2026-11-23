"""Derive four-bit addition lemmas from PA and reuse them in concrete products."""
import argparse
import json
import generate_arithmetic as g

def digit(value, width, base):
    term=base
    for i in reversed(range(width)):
        term=f'(b{(value>>i)&1} {term})'
    return term

def symbolic_succ(value, width):
    if width==0:
        assert value==0
        return 's'
    if value%2==0:
        return 'sucb0'
    return f'(paSuccOdd {symbolic_succ(value//2,width-1)})'

def symbolic_add(x,y,width):
    if width==0:
        return 'h'
    p=symbolic_add(x//2,y//2,width-1)
    bits=f'{x%2}{y%2}'
    if bits=='11':
        return f'(paAdd11 {p} {symbolic_succ(x//2+y//2,width-1)})'
    return f'(paAdd{bits} {p})'

def helpers():
    lines=['import "arithmetic.mm1";','-- Finite rule table: every entry has a PA proof.']
    for x in range(16):
        for y in range(16):
            carry=(x+y)//16
            bind='(a b c d: nat)' if carry else '(a b c: nat)'
            hs='(h: $ a + b = c $)' + (' (s: $ suc c = d $)' if carry else '')
            result=digit((x+y)%16,4,'d' if carry else 'c')
            lines.append(f"theorem paFour{x:x}{y:x} {bind} {hs}: $ {digit(x,4,'a')} + {digit(y,4,'b')} = {result} $ = '{symbolic_add(x,y,4)};")
    (g.BASE/'arithmetic4.mm1').write_text('\n'.join(lines)+'\n',encoding='utf-8',newline='\n')

binary_add=g.add
def fourbit_add(a,b):
    if a<8 or b<8:
        return binary_add(a,b)
    aa,x=divmod(a,16);bb,y=divmod(b,16)
    p=fourbit_add(aa,bb)
    s=' '+g.succ(aa+bb) if x+y>=16 else ''
    return f'(paFour{x:x}{y:x} {p}{s})'

if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('--counts',nargs='+',type=int,default=[0,8,16,32,64])
    args=p.parse_args()
    helpers()
    g.add=fourbit_add
    rows=json.loads(g.FIXTURE.read_text())['rows']
    for n in args.counts:
        assert 0<=n<=len(rows)
        g.generate(f'fourbit{n}',[(abs(r['input'][2]),abs(r['input'][4])) for r in rows[:n]],'arithmetic4.mm1')
