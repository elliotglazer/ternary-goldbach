"""Read-only source binding check; no SML execution."""
from pathlib import Path
import hashlib,json,re
P=Path(__file__).resolve().parent
def sha(p): return hashlib.sha256(p.read_bytes()).hexdigest()
def txt(p): return p.read_text(encoding='utf-8')
def main():
    m=json.loads((P/'source_binding.json').read_text())
    # Cross-platform input paths are matched by known suffix, not trusted as commands.
    setup=P.parents[1]/'hol4-setup'
    paths={p.name:p for p in [setup/'dependent.sml',
      setup/'HOL-1de64f8521b4758508bd875fbaf11d1768261b92/src/thm/Compute.sml',
      setup/'HOL-1de64f8521b4758508bd875fbaf11d1768261b92/src/num/theories/cv_compute/cv_computeLib.sml']}
    for f,v in m['inputs'].items(): assert sha(paths[f.replace('\\','/').split('/')[-1]])==v
    for group in ['outputs','support']:
        for f,v in m[group].items(): assert sha(P/f)==v,f
    assert sha(P/'source_expected.sha256')==m['source_expectation_sha256']
    old=txt(paths['dependent.sml']);new=txt(P/'typed_dependent.sml')
    assert new.startswith('open TypedWorkload;\n'+old[:old.index('val fixture_1 =')].replace('DependentBlockResults','TypedDependentResults'))
    for n in [1,8,32,128]:
        ds=re.findall(rf'^val fixture_{n} = .*;$',old,re.M)
        assert len(ds)==1 and new.count(ds[0])==1
    suffix=new[new.index('val changed_xs ='):]
    suffix=re.sub(r'^val _ = TypedWorkload.run "control_[^"]+" \(acceptance .*\) false;\n','',suffix,flags=re.M)
    assert suffix.replace('HOL4_TYPED_DEPENDENT_BENCHMARK_DONE','HOL4_DEPENDENT_BLOCK_BENCHMARK_DONE')==old[old.index('val changed_xs ='):]
    c=txt(paths['Compute.sml']);b=txt(P/'TypedStockCompute.sml')
    assert b.startswith(c[:c.index('\nend (* struct *)')].replace('structure Compute :> Compute =','structure TypedStockCompute ='))
    assert 'make_thm' not in b and 'Thm.compute' not in b
    print('TYPED_SOURCE_BINDING_PASS')
if __name__=='__main__':main()
