"""Exclusive source preparation only. Does not compile, evaluate or benchmark SML."""
from pathlib import Path
import hashlib
import json
import re
import os

HERE = Path(__file__).resolve().parent
SETUP = HERE.parents[1] / 'hol4-setup'
HOL = SETUP / 'HOL-1de64f8521b4758508bd875fbaf11d1768261b92'
PINS = {
    HOL / 'src/thm/Compute.sml': '7dab9dd6e848fdfe2eb7869865031cfdadba44a2fb3d7e74d98cea77f712e059',
    HOL / 'src/num/theories/cv_compute/cv_computeLib.sml': 'b66d57885cb0d2dcf49f5d5fec665cb5fdca4edb9f726a2ced0ad579cdd08b6c',
    SETUP / 'dependent.sml': 'ecb62c8c7b1f1aaaa8df9617daf4145d7fcadbeedd9cf8579d3f57962c5e1ab1',
}
def sha(p): return hashlib.sha256(p.read_bytes()).hexdigest()
def read(p):
    assert sha(p) == PINS[p], p
    return p.read_text(encoding='utf-8')
def once(s, old, new):
    assert s.count(old) == 1, old
    return s.replace(old, new)
def main():
    compute, config, fixture = map(read, PINS)
    start = compute.index('fun term_compute ')
    end = compute.index('\nend (* struct *)', start)
    frontend = compute[start:end]
    parser = once(frontend, 'fun term_compute ', 'fun prepare_program ')
    parser = once(parser, '''      in
        fn tm =>
          let
            val cexp = dest_cexp ct [] eqs tm
            val cval = exec code [] cexp
          in
            cv_to_term cval
          end
      end''', '''      in
        {code = code, parse = fn tm => dest_cexp ct [] eqs tm,
         to_term = cv_to_term}
      end''')
    stock = once(compute[:end], 'structure Compute :> Compute =',
                 'structure TypedStockCompute =') + '\n' + parser + compute[end:]
    cfg = once(config[:config.index('val cached = Thm.compute')],
               'structure cv_computeLib :> cv_computeLib =', 'structure TypedCvConfig =')
    cfg += '''val _ = if List.all (fn (_,th) => null (hyp th)) char_eqns then ()
          else raise Fail "open characteristic theorem";
val config = {cval_terms=cval_terms, cval_type=cvSyntax.cv, num_type=numSyntax.num,
              char_eqns=List.map (fn (name,th) => (name,concl th)) char_eqns};
end;
'''
    prefix = fixture[:fixture.index('val fixture_1 =')]
    # Only the local theory identity changes; literals and definitions do not.
    prefix = prefix.replace('DependentBlockResults', 'TypedDependentResults')
    lines = ['open TypedWorkload;', prefix, 'val _ = TypedWorkload.selftests ();']
    for depth in (1,8,32,128):
        ds = re.findall(rf'^val fixture_{depth} = .*;$', fixture, re.M)
        assert len(ds) == 1
        lines += [ds[0], f'val _ = TypedWorkload.run "depth{depth}" fixture_{depth} true;',
                  f'val checked_{depth} = timed "stock_full_depth{depth}" (fn () => check_true fixture_{depth});',
                  f'val _ = audit "stock_full_depth{depth}" checked_{depth};',
                  f'val _ = ignore (save_thm ("stock_full_depth{depth}",checked_{depth}));']
    tail = fixture[fixture.index('val changed_xs ='):]
    pattern = r'^val _ = timed "control_([^"]+)" \(fn \(\) => check_false "[^"]+" \((acceptance .*)\)\);$'
    ms = list(re.finditer(pattern, tail, re.M))
    assert [m[1] for m in ms] == ['checksum','bound','depth','input','coefficient']
    tail = re.sub(pattern, lambda m: f'val _ = TypedWorkload.run "control_{m[1]}" ({m[2]}) false;\n'+m[0], tail, flags=re.M)
    tail = once(tail, 'HOL4_DEPENDENT_BLOCK_BENCHMARK_DONE', 'HOL4_TYPED_DEPENDENT_BENCHMARK_DONE')
    lines.append(tail)
    outputs = {'TypedStockCompute.sml':stock, 'TypedCvConfig.sml':cfg,
               'typed_dependent.sml':'\n'.join(lines)}
    for f in [*outputs,'source_binding.json','source_expected.sha256']:
        assert not (HERE/f).exists(), f
    for f,s in outputs.items():
        with (HERE/f).open('x',encoding='utf-8',newline='\n') as out: out.write(s)
    support = ['TypedBlock.sml','TypedWorkload.sml','prepare_harness.py',
               'verify_sources.py','validate_log.py','validate_log.awk','run_typed.sh','Holmakefile']
    manifest = {'status':'source-only; no SML compile or execution',
                'inputs':{str(p):v for p,v in PINS.items()},
                'outputs':{f:sha(HERE/f) for f in outputs},
                'support':{f:sha(HERE/f) for f in support},
                'theory':'TypedDependentResults','depths':[1,8,32,128],
                'controls':['checksum','bound','depth','input','coefficient']}
    expectations = {**{os.path.relpath(p,HERE).replace('\\','/'):v for p,v in PINS.items()},
                    **manifest['outputs'],**manifest['support']}
    with (HERE/'source_expected.sha256').open('x',encoding='utf-8',newline='\n') as out:
        for f,v in expectations.items(): out.write(v+'  '+f+'\n')
    manifest['source_expectation_sha256'] = sha(HERE/'source_expected.sha256')
    with (HERE/'source_binding.json').open('x',encoding='utf-8') as out:
        json.dump(manifest,out,indent=2);out.write('\n')
    print(json.dumps(manifest,indent=2))
if __name__ == '__main__': main()
