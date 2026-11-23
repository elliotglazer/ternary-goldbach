"""Emit one pinned integer-only handoff fixture; root executes, not a proof oracle.
All output files are exclusive. No subprocesses, HOL builds, or benchmarks.
"""
from pathlib import Path
import hashlib
import json
import time

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]
FIXTURE = ROOT / 'work/lean-pilots/raw-head/state_fixture.json'
EXPECTED = '01C3E9F1AF2FD8DF40C9EF770840078E02EC356737727637C58397836C5C6BF9'
BASES = [1, 2, 3, 41, 61, 10004, 262144, 265800]


def nearest(d, r):
    assert d > 0
    return (2*r+d)//(2*d)


def mul(z, w):
    return [nearest(1 << 122, z[0]*w[0]-z[1]*w[1]),
            nearest(1 << 122, z[0]*w[1]+z[1]*w[0])]


def head(u, v):
    return [nearest(1 << 140, 61*(u[0]*v[0]+u[1]*v[1])),
            nearest(1 << 140, 61*(u[0]*v[1]-u[1]*v[0]))]


def sint(n):
    assert type(n) is int
    return json.dumps(str(n).replace('-', '~'))


def pairs(xs):
    return '[' + ','.join('['+','.join(map(sint, z))+']' for z in xs) + ']'


def array(xs):
    return '[' + ',\n'.join(pairs(row) for row in xs) + ']'


def source_data(xs):
    return '[' + ',\n'.join('('+pairs([z])[1:-1]+','+
                           pairs([w])[1:-1]+')' for z, w in xs) + ']'


def main():
    cpu, wall = time.process_time(), time.perf_counter()
    raw = FIXTURE.read_bytes()
    assert len(raw) <= 256*1024
    assert hashlib.sha256(raw).hexdigest().upper() == EXPECTED
    f = json.loads(raw)
    assert f['schema'] == 'raw-head-matched-state-fixture-v1'
    assert f['base_order'] == BASES
    assert f['grids']['state'] == 120 and f['grids']['step_export'] == 122
    assert f['time_index']['last_inclusive'] == 128
    assert len(f['rows']) == 8
    states, seeds = [], []
    for i, row in enumerate(f['rows']):
        assert row['x'] == BASES[i] and row['base_index'] == i
        z, w, zs = row['initial_grid120'], row['step_grid122'], row['states_grid120']
        assert len(zs) == 129 and zs[0] == z
        assert all(len(x) == 2 and all(type(v) is int for v in x) for x in [z,w]+zs)
        assert all(abs(v) < 1 << 121 for x in zs for v in x)
        for j in range(128):
            assert mul(zs[j], w) == zs[j+1]
        states.append(zs)
        seeds.append((z,w))
    heads = [[head(states[4][j], states[i][j]) for j in range(129)] for i in range(4)]
    assert len(heads) == 4 and sum(map(len,heads)) == 516
    runtime = (HERE/'HandoffRuntime.sml').read_text(encoding='utf-8')
    outputs = {}
    for mode in ['materialized','fused']:
        theory = 'HandoffMaterialized' if mode == 'materialized' else 'HandoffFused'
        lines = ['open HolKernel Parse boolLib bossLib RawStateHandoffTheory cv_transLib;',
                 f'val _ = new_theory "{theory}";', runtime,
                 f'val _ = print "HANDOFF_MODE,{mode},integer_only\\n";',
                 f'val _ = print "HANDOFF_FIXTURE,{EXPECTED}\\n";',
                 'val source_literal = timed "construct_sources" (fn () => sources '+source_data(seeds)+');',
                 'val source_def = define "define_sources" "accepted_integer_sources" source_literal;',
                 'val _ = translated "translate_sources" source_def;',
                 'val source_name = lhs (concl source_def);',
                 'val bases = ``[1;2;3;41;61;10004;262144;265800]:num list``;',
                 'val c = ``61:int``;', 'val depth = ``128:num``;',
                 'val producer = list_mk_comb (``raw_produce``,[depth,source_name]);',
                 'val pipeline = list_mk_comb (``raw_pipeline``,[bases,c,depth,source_name]);',
                 'val final_literal = timed "construct_final_outputs" (fn () => traces '+array(heads)+');',
                 'val expected = optionSyntax.mk_some final_literal;']
        if mode == 'materialized':
            lines += ['val producer_th = evaluate "producer" producer;',
                      'val trace_literal = timed "construct_intermediate_literal" (fn () => traces '+array(states)+');',
                      'val _ = timed "bind_intermediate_literal" (fn () => require',
                      '  (aconv (rhs (concl producer_th)) trace_literal) "producer trace mismatch");',
                      'val trace_def = define "define_intermediate" "materialized_trace" trace_literal;',
                      'val _ = translated "translate_intermediate" trace_def;',
                      'val producer_link = timed "bind_producer_to_named_trace"',
                      '  (fn () => TRANS producer_th (SYM trace_def));',
                      'val consumer = list_mk_comb (``raw_consume``,[c,lhs(concl trace_def)]);',
                      'val consumer_th = evaluate "consumer" consumer;',
                      'val result_th = timed "compose_pipeline" (fn () =>',
                      '  MATCH_MP raw_pipeline_join (LIST_CONJ',
                      '    [REFL bases,REFL c,REFL depth,producer_link,consumer_th]));']
        else:
            lines += ['val result_th = evaluate "fused_pipeline" pipeline;']
        lines += ['val _ = timed "bind_final_outputs" (fn () => require',
                  '  (aconv (concl result_th) (mk_eq(pipeline,expected))) "final array mismatch");',
                  'val public_th = timed "public_literal_binding"',
                  '  (fn () => REWRITE_RULE [source_def] result_th);',
                  'val public_pipeline = list_mk_comb (``raw_pipeline``,[bases,c,depth,source_literal]);',
                  'val _ = require (aconv (concl public_th) (mk_eq(public_pipeline,expected)))',
                  '  "public theorem not the exact common proposition";',
                  'val _ = audit "final_integer_pipeline" public_th;',
                  'val _ = timed "save_final" (fn () => save_thm("final_integer_pipeline",public_th));',
                  'val _ = print "HANDOFF_PRIMARY_COMPLETE,516,8,129\\n";']
        # Controls are AFTER primary acceptance and separately labelled; they
        # cannot warm the fused path with a translated intermediate beforehand.
        bad_heads = [[z[:] for z in row] for row in heads]
        bad_heads[0][-1][0] += 1
        bad_trace = [[z[:] for z in row] for row in states]
        bad_trace[0][64][0] += 1
        dropped = [row[:] for row in states]
        dropped[0] = dropped[0][:-1]
        repeated = [row[:] for row in states]
        repeated[0] = repeated[0] + [repeated[0][-1]]
        swapped = states[:]
        swapped[1],swapped[2] = swapped[2],swapped[1]
        changed_seeds = [(z[:],w[:]) for z,w in seeds]
        changed_seeds[0][0][0] = 0
        changed_steps = [(z[:],w[:]) for z,w in seeds]
        changed_steps[0][1][0] = 0
        for label, ss in [('seed',changed_seeds),('step',changed_steps)]:
            lines += [f'val control_{label}_literal = timed "control_construct_{label}"',
                      f'  (fn () => sources {source_data(ss)});',
                      f'val control_{label}_def = define "control_define_{label}"',
                      f'  "control_{label}" control_{label}_literal;',
                      f'val _ = translated "control_translate_{label}" control_{label}_def;',
                      f'val _ = false_claim "{label}" (mk_eq(list_mk_comb (``raw_pipeline``,',
                      f'  [bases,c,depth,lhs(concl control_{label}_def)]),expected));']
        for label, ts in [('interior',bad_trace),('row_index',swapped)]:
            lines += [f'val _ = false_claim "{label}" (mk_eq(producer,traces {array(ts)}));']
        for label, ts in [('dropped_row',dropped),('repeated_row',repeated)]:
            lines += [f'val _ = false_claim "{label}"',
                      f'  (mk_comb(``raw_shape``,traces {array(ts)}));']
        lines += ['val _ = false_claim "final_entry" (mk_eq(pipeline,',
                  '  optionSyntax.mk_some (traces '+array(bad_heads)+')));',
                  'val _ = false_claim "base_label" (mk_eq(list_mk_comb (``raw_pipeline``,',
                  '  [``[2;2;3;41;61;10004;262144;265800]:num list``,c,depth,source_name]),expected));',
                  'val _ = false_claim "denominator" (mk_eq(list_mk_comb (``raw_pipeline``,',
                  '  [bases,``62:int``,depth,source_name]),expected));',
                  'val _ = true_claim "negative_ties"',
                  '  ``round_scaled 2 (~5) = ~2 /\\ round_scaled 2 5 = 3``;',
                  'val _ = timed "theory_export" export_theory;',
                  'val _ = print "HANDOFF_DONE\\n";']
        outputs[f'handoff_{mode}.sml'] = '\n'.join(lines)+'\n'
    outputs['handoff_compare.sml'] = '''open HolKernel Parse boolLib bossLib;
open HandoffMaterializedTheory HandoffFusedTheory;
val left = DB.fetch "HandoffMaterialized" "final_integer_pipeline";
val right = DB.fetch "HandoffFused" "final_integer_pipeline";
val _ = if null (hyp left) andalso null (hyp right) andalso
  aconv (concl left) (concl right) then
  print "HANDOFF_MATCHED_EXACT_FINAL_THEOREM,516\\n"
  else raise Fail "mismatched handoff final theorem";
'''
    assert all(len(v.encode()) <= 2*1024*1024 for v in outputs.values())
    assert all(not (HERE/n).exists() for n in outputs)
    for name, text in outputs.items():
        with (HERE/name).open('x',encoding='utf-8',newline='\n') as out:
            out.write(text)
    receipt = dict(schema='raw-state-handoff-source-binding-v1',
        scope='Integer-only proposals; no HOL analytic source theorem',
        fixture_sha256=EXPECTED,base_order=BASES,states=1032,final_pairs=516,
        common_shape_guard='all8 rows129, every coordinate abs<2^121',
        proposal_cpu_seconds=time.process_time()-cpu,
        proposal_elapsed_seconds=time.perf_counter()-wall,
        generator_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest().upper(),
        artifacts={name:dict(bytes=len(text.encode()),
                    sha256=hashlib.sha256(text.encode()).hexdigest().upper())
                   for name,text in outputs.items()})
    with (HERE/'fixture_binding.json').open('x',encoding='utf-8') as out:
        json.dump(receipt,out,indent=2)
        out.write('\n')
    print(json.dumps(receipt,indent=2))


if __name__ == '__main__':
    main()
