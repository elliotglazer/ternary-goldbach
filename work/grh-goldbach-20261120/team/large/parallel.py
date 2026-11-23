"""Materialize pinned analytic sources and a dependency-aware GNU make build on Linux."""

import argparse
import hashlib
import json
import shutil
from functools import partial
from pathlib import Path

from prepare import HERE, IMPORT, REPO, lean_code
from mertens_chunks import ramare_modules, separate_literal_theorems, separate_modules, split_mu_phi_modules
from prime_ranges import mu_prime_table, sieve_prime_table, sieve2_prime_table, sieve3_prime_table
from psi_walk_chunks import split_long_psi_chunk
from psi_headers import replace_header, separate_table_chunks
from version_headers import ADAPTERS, with_version_imports


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('directory', type=Path, help='New or previously generated build directory.')
    parser.add_argument('--original-headers', action='store_true', help='Keep the original chain of certificate imports.')
    parser.add_argument('--seed-cache', type=Path, help='Reuse compatible modules from a hash-checked native build.')
    args = parser.parse_args()
    out = args.directory.resolve()
    plan = json.loads((HERE/'sources.json').read_text())
    signature = plan['commit'] + (' original\n' if args.original_headers else ' independent-psi\n')
    marker = out/'.goldbach-large-build'
    if out.exists() and any(out.iterdir()) and (not marker.is_file() or marker.read_text() != signature):
        raise ValueError('Choose an empty directory or an existing build with the same layout.')
    out.mkdir(parents=True, exist_ok=True)
    marker.write_text(signature)

    def put(path, raw):
        path.parent.mkdir(parents=True, exist_ok=True)
        if not path.is_file() or path.read_bytes() != raw:
            path.write_bytes(raw)

    def source(module):
        return Path(module.replace('.', '/')+'.lean')

    def olean(module):
        return module.replace('.', '/')+'.olean'

    def sha(data):
        return hashlib.sha256(data).hexdigest()

    splits = {'TernaryGoldbach.Prelim.SmallMertensLower': separate_modules,
              'TernaryGoldbach.Prelim.SmallMuPhi': split_mu_phi_modules,
              'TernaryGoldbach.Prelim.SmallMuWalk': mu_prime_table,
              'TernaryGoldbach.Prelim.PsiSieve': sieve_prime_table,
              'TernaryGoldbach.Prelim.PsiSieve2': sieve2_prime_table,
              'TernaryGoldbach.Prelim.PsiSieve3': sieve3_prime_table,
              'TernaryGoldbach.Prelim.RamareWalk': ramare_modules}
    log_sq = 'TernaryGoldbach.Prelim.SmallLogSq'
    def split_log_sq(raw):
        common = dict(module=log_sq, namespace='TernaryGoldbach.Prelim.SmallLS')
        parts = separate_literal_theorems(raw, **common, first='ok_0',
            expected=[f'ok_{i}' for i in range(40)], batch=4)
        blocks = separate_literal_theorems(parts.pop(log_sq), **dict(common, module=log_sq+'Ranges'),
            first='blk_0', expected=[f'{k}_{i}' for i in range(225) for k in ('blk','lg')], batch=16)
        parts.update(blocks)
        parts[log_sq] = f'import {log_sq}Ranges\n'.encode()
        return parts
    splits[log_sq] = split_log_sq
    for i in range(1, 7):
        table = f'TernaryGoldbach.Prelim.SmallPsiData{i}'
        splits[table] = partial(separate_table_chunks, module=table)
    for name, namespace, keys in (
            ('SmallG', 'SmallG', [f'{prefix}_{i}' for i in range(32) for prefix in ('dfs', 'log')]),
            ('SmallFsq', 'Small', [f'chk_{i}' for i in range(0,200,4)])):
        table = f'TernaryGoldbach.Prelim.{name}'
        splits[table] = partial(separate_literal_theorems, module=table,
            namespace=f'TernaryGoldbach.Prelim.{namespace}', first=keys[0], expected=keys, batch=2)
    walk_sources = {}
    for mod, split in splits.items():
        upstream = (REPO/source(mod)).read_bytes().replace(b'\r\n', b'\n')
        if sha(upstream) != plan['project_prerequisite_sha256'][mod]:
            raise ValueError(f'Upstream walk differs: {mod}')
        for name, raw in split(with_version_imports(upstream, mod)).items():
            if 'SmallPsiData' in name and 'Chunk' in name:
                walk_sources.update(split_long_psi_chunk(raw,name))
            else:
                walk_sources[name] = raw
    modules = [*ADAPTERS, 'GoldbachPsiAppend', *(m for m in walk_sources if m not in splits), *plan['project_prerequisites_in_build_order'],
               'GoldbachLarge', 'FullGRH', 'GoldbachLargeOfDirichletGRH', 'GoldbachLargeGRH',
               'AuditConditional', 'AuditDirichletGRH', 'AuditClosed',
               'ReplayConditional', 'ReplayClosed']
    known = set(modules)
    deps_by_module = {}
    rules = []
    for mod in modules:
        if mod in walk_sources:
            raw = walk_sources[mod]
        elif mod in plan['project_prerequisite_sha256']:
            raw = (REPO/source(mod)).read_bytes().replace(b'\r\n', b'\n')
            if sha(raw) != plan['project_prerequisite_sha256'][mod]:
                raise ValueError(f'Upstream source differs: {mod}')
            if not args.original_headers:
                raw = replace_header(mod, raw)
                expected = plan['optional_psi_shards']['modified_source_sha256'].get(mod)
                if expected and sha(raw) != expected:
                    raise ValueError(f'Shard header differs: {mod}')
            raw = with_version_imports(raw, mod)
        elif mod in ('AuditConditional', 'ReplayConditional'):
            raw = b'import GoldbachLarge\n#print axioms TernaryGoldbach.ternary_goldbach_large_of_hypotheses\n'
        elif mod == 'AuditDirichletGRH':
            raw = b'import GoldbachLargeOfDirichletGRH\n#print axioms GrhGoldbach.ternary_goldbach_large_of_dirichletGRH\n'
        elif mod in ('AuditClosed','ReplayClosed'):
            raw = b'import GoldbachLargeGRH\n#print axioms GrhGoldbach.ternary_goldbach_large\n'
        else:
            raw = ((HERE.parents[1] if mod == 'FullGRH' else HERE)/source(mod)).read_bytes().replace(b'\r\n', b'\n')
            if mod == 'GoldbachLarge' and sha(raw) != plan['large_module_sha256']:
                raise ValueError('Large-range assembly differs')
        put(out/source(mod), raw)
        deps_by_module[mod] = [d.decode() for d in IMPORT.findall(lean_code(raw)) if d.decode() in known]
        deps = [olean(d) for d in deps_by_module[mod]]
        if mod == 'GoldbachLargeGRH':
            deps.append('$(GRH)/.lake/build/lib/lean/Main.olean')
        # The source is first because the recipe uses $<.
        rules.append(f'{olean(mod)}: {source(mod).as_posix()} ' + ' '.join(deps))
    put(out/'LICENSE', (REPO/'LICENSE').read_bytes())
    put(out/'NOTICE', (REPO/'NOTICE').read_bytes())
    put(out/'source-manifest.json', (HERE/'sources.json').read_bytes())
    config = r'''# Generated from the pinned 647-module large-range analytic closure.
GRH ?= /verification/lean
LEAN ?= /verification/lean-4.33.1-linux/bin/lean
MEMORY ?= 8192
empty :=
space := $(empty) $(empty)
export LEAN_PATH := $(CURDIR):$(GRH)/.lake/build/lib/lean:$(subst $(space),:,$(wildcard $(GRH)/.lake/packages/*/.lake/build/lib/lean))
.DELETE_ON_ERROR:
.PHONY: all dirichlet-grh closed replay-conditional replay-closed preflight
all: AuditConditional.olean
dirichlet-grh: AuditDirichletGRH.olean
closed: AuditClosed.olean
replay-conditional: AuditConditional.olean ReplayConditional.olean
replay-closed: AuditClosed.olean ReplayClosed.olean
preflight:
	@$(LEAN) --version | grep -q 'version 4.33.1,'
	@test "$$(git -C '$(GRH)/.lake/packages/mathlib' rev-parse HEAD)" = '0df444a360eaa60ab8c11dca51a86af692955474'
	@echo '017645ca448f2fd1f6fd5c4c2cb2c6e96e472725be13f6e180ca6e1574360939  $(GRH)/src/Main.lean' | sha256sum -c --status
	@echo '79ef7ca776e42abe1f46caee13ea09bd19f1e2d0b1620d8d5d200258f33b47bf  $(GRH)/src/Statements.lean' | sha256sum -c --status
%.olean: %.lean | preflight
	@ulimit -c 0; if test -w /proc/self/coredump_filter; then echo 0 > /proc/self/coredump_filter; fi; $(LEAN) -j1 -M$(MEMORY) $(if $(filter ReplayClosed.olean ReplayConditional.olean,$(@F)),-t0,) -o $@ $< > $*.log 2>&1 || { cat $*.log; exit 1; }
	@case '$(@F)' in Audit*.olean|Replay*.olean) python3 verify_axioms.py $*.log ;; esac
'''
    # The Mertens walk has a separate memory test. Keep all independent
    # analytic branches buildable while that test runs.
    independent = set(ADAPTERS)
    for mod in plan['project_prerequisites_in_build_order']:
        if mod != 'TernaryGoldbach.Prelim.SmallMertensLower' and all(d in independent for d in deps_by_module[mod]):
            independent.add(mod)
    rules.append('.PHONY: independent-of-mertens')
    rules.append('independent-of-mertens: ' + ' '.join(olean(mod) for mod in sorted(independent)))
    put(out/'Makefile', (config + '\n' + '\n'.join(rules) + '\n').encode())
    check = '''from pathlib import Path
import sys
text = Path(sys.argv[1]).read_text()
axioms = text.split('depends on axioms: [', 1)[1].split(']', 1)[0].split(',')
assert {a.strip() for a in axioms} == {'propext', 'Classical.choice', 'Quot.sound'}, text
print(text)
'''
    put(out/'verify_axioms.py', check.encode())
    if args.seed_cache:
        cache = args.seed_cache.resolve()
        state = json.loads((cache/'receipt.json').read_bytes())
        pins = state['pins']
        if (pins['mathlib'] != '0df444a360eaa60ab8c11dca51a86af692955474'
                or 'version 4.33.1,' not in pins['compiler'] or pins['goldbach_commit'] != plan['commit']
                or pins['goldbach_large'] != plan['large_module_sha256']):
            raise ValueError('Native cache pins differ')
        seeded = set()
        for mod in modules:
            row = state['passed'].get(mod)
            if not row or any(d not in seeded for d in deps_by_module[mod]):
                continue
            if sha((out/source(mod)).read_bytes()) != row.get('compiled_source',row['source']):
                continue
            obj = cache/olean(mod)
            if sha(obj.read_bytes()) != row['olean']:
                raise ValueError(f'Native cache object differs: {mod}')
            destination = out/olean(mod)
            if not destination.exists():
                shutil.copyfile(obj,destination)
            elif sha(destination.read_bytes()) != row['olean']:
                continue
            seeded.add(mod)
        print(f'Reused {len(seeded)} verified native modules.')
    print(f'Materialized {len(modules)} modules under {out}.')


if __name__ == '__main__':
    main()
