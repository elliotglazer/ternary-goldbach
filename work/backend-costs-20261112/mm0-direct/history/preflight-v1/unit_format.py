"""Tiny format tests only. No fixture, PA library or proof is evaluated."""
from mmb import cmd,read_cmd,statement,Terms,unify

nchecks=0
for op in (0,2,4,5,6,0x10,0x12,0x14,0x30,0x32):
    for n in (0,1,255,256,65535,65536,2**32-1):
        data=cmd(op,n)
        assert read_cmd(data,0)==(op,n,len(data));nchecks+=1
for n in (0,1,253,254,255,256,65530,65531,65535,65536):
    data=statement(6,b'X'*n)
    op,total,offset=read_cmd(data,0)
    assert op==6 and total==len(data) and data[offset:]==b'X'*n;nchecks+=1
t=Terms();a=t.make(5);b=t.make(8,(a,a))
assert t.make(8,(a,a))==b
assert unify(t,b)==cmd(0x30,8)+cmd(0x30,5)*2
nchecks+=2
print(f'TINY_FORMAT_ONLY_PASS,{nchecks},NO_PA_ACCEPTANCE')
