from delivery import *
def make():
    script=["Theory ActualDyadicSeeds","Ancestors DyadicSeed transc real arithmetic","Libs realLib RealField","val _=realLib.prefer_real();"]
    for n,prec in ((524288,240),(262144,238),(524288,128)):
        g=1<<(prec+76);hs=seed(n,g);base=f'seed_{n}_{prec}_'
        def val(t):return '0' if t==0 else '1' if t==g else f'({t}/{g})'
        def nat(j):return '(SUC '*j+'0'+')'*j
        for i,(a,b,c,d) in enumerate(hs):
            k=nat(i);a,b,c,d=map(val,(a,b,c,d))
            stmt=f'{a}<=cos(ang {k}) /\\ cos(ang {k})<={b} /\\ {c}<=sin(ang {k}) /\\ sin(ang {k})<={d}'
            script.append(f'Theorem {base}{i}:\n {stmt}\nProof')
            if i==0:script.append(' simp[ang_def,COS_PI2,SIN_PI2]')
            else:
                terms=[nat(i-1),*map(val,hs[i-1]),a,b,c,d]
                script.append(' irule (Q.SPECL ['+','.join(chr(96)+t+chr(96) for t in terms)+'] next_box) >>')
                script.append(f' mp_tac {base}{i-1} >> strip_tac >> asm_rewrite_tac[] >> CONV_TAC RealField.REAL_RAT_REDUCE_CONV')
            script.append('QED')
    (p/'ActualDyadicSeedsScript.sml').write_text('\n'.join(script)+'\n')
make()
