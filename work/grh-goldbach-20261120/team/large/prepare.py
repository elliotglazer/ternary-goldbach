"""Extract the unchanged large proof and inventory its pinned project imports."""

import argparse
from collections import Counter
import hashlib
import json
from pathlib import Path
import re
import subprocess
from psi_headers import ALL_DATA, PREFIX, replace_header


PIN = '23b2d68ca344203d4384e0aff7affa4ec034bef9'
HERE = Path(__file__).resolve().parent
REPO = HERE.parents[2] / 'ternary-goldbach'
MAIN = 'TernaryGoldbach.Helfgott.Main'
ROOT = 'TernaryGoldbach.MainTheorems'
IMPORT = re.compile(rb'^\s*(?:public\s+)?import[ \t]+(\w+(?:\.\w+)*)', re.M)


def project_source(mod):
    return mod.replace('.', '/') + '.lean'


def lean_code(raw):
    """Remove nested block comments, line comments and quoted strings."""
    token = re.compile(rb'/-|-/|--[^\n]*|"(?:\\.|[^"\\])*"')
    block_token = re.compile(rb'/-|-/')
    depth, i = 0, 0
    code = bytearray()
    while i < len(raw):
        found = (block_token if depth else token).search(raw, i)
        tail = found.start() if found else len(raw)
        if not depth:
            code.extend(raw[i:tail])
        else:
            code.extend(b'\n' * raw[i:tail].count(b'\n'))
        if not found:
            break
        mark = found.group()
        if mark == b'/-':
            depth += 1
        elif mark == b'-/' and depth:
            depth -= 1
        code.extend(b' ' + b'\n' * mark.count(b'\n'))
        i = found.end()
    if depth:
        raise ValueError('unterminated comment')
    return bytes(code)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--check', action='store_true')
    opts = parser.parse_args()
    git = ['git', '-C', str(REPO)]
    rows = subprocess.check_output([*git, 'ls-tree', '-r', PIN]).splitlines()
    project = {}
    for row in rows:
        info, path = row.split(b'\t', 1)
        if path.endswith(b'.lean'):
            project[path.decode()[:-5].replace('/', '.')] = info.split()[2].decode()

    with subprocess.Popen([*git, 'cat-file', '--batch'], stdin=subprocess.PIPE,
                          stdout=subprocess.PIPE) as blobs:
        def read(mod):
            blobs.stdin.write((project[mod] + '\n').encode())
            blobs.stdin.flush()
            _, kind, length = blobs.stdout.readline().split()
            assert kind == b'blob'
            data = blobs.stdout.read(int(length))
            assert len(data) == int(length) and blobs.stdout.read(1) == b'\n'
            return data

        src = read(MAIN)
        root = read(ROOT)
        inputs = read('TernaryGoldbach.Helfgott.Inputs')
        def between(raw, start, end):
            assert raw.count(start) == 1 and raw.count(end) == 1
            i = raw.index(start)
            return raw[i:raw.index(end, i)]

        proof = between(src, b'open Complex MeasureTheory ArithmeticFunction',
                        b'omit [Fact TernaryGoldbach.PlattGRH] in\n/-- The small cases:')
        theorem = between(root, b'/-- **Helfgott\'s theorem for large',
                          b'/-- **The ternary Goldbach conjecture**')
        cut = b'import TernaryGoldbach.Helfgott.SmallCases\n'
        assert src.count(cut) == 1
        imports = src[:src.index(cut)]
        section = between(src, b'variable [Fact TernaryGoldbach.PlattGRH]', b'/-!')
        header = (b'/-\nCopyright 2026 Charlie Reams. Apache-2.0.\n'
                  b'Extracted from calr3/ternary-goldbach at ' + PIN.encode() + b'.\n'
                  b'Only the large-range declarations are included. See prepare.py.\n-/\n')
        large = (header + imports + b'\n' + section + proof + b'end TernaryGoldbach.Helfgott\n\n'
                 + b'namespace TernaryGoldbach\n\n' + theorem + b'end TernaryGoldbach\n')
        elementary_imports = inputs[:inputs.index(b'import TernaryGoldbach.MinorArcs.')]
        circle = between(inputs, b'/-- **Circle method identity**', b'/-- `x = xOf N')
        nonprime = between(inputs, b'/-- **Non-prime and even terms**', b'/-! ## Computational inputs')
        elementary = (header + elementary_imports + b'\nopen Complex MeasureTheory ArithmeticFunction\n\n'
                      + b'namespace TernaryGoldbach.Helfgott\n\n' + circle + nonprime + b'end TernaryGoldbach.Helfgott\n')

        imports_by_mod, matches, source_hash = {}, {}, {}
        trust_terms = re.compile(rb'\b(?:sorry|admit|axiom|native_decide)\b')
        def closure(roots):
            done = set()
            ordered = []
            def visit(mod):
                if mod in done or mod not in project:
                    return
                done.add(mod)
                if mod not in imports_by_mod:
                    raw = read(mod)
                    source_hash[mod] = hashlib.sha256(raw).hexdigest()
                    code = lean_code(raw)
                    imports_by_mod[mod] = [m.decode() for m in IMPORT.findall(code)]
                    hits = sorted({m.decode() for m in trust_terms.findall(code)})
                    if hits:
                        matches[mod] = hits
                for dep in imports_by_mod[mod]:
                    visit(dep)
                ordered.append(mod)
            for mod in roots:
                visit(mod)
            return ordered

        full = closure([ROOT])
        only = closure([m.decode() for m in IMPORT.findall(imports)])
        elementary_only = closure([m.decode() for m in IMPORT.findall(elementary_imports)])
        shard_imports = imports_by_mod.copy()
        rewritten = {}
        for mod in [*ALL_DATA, PREFIX + 'Main']:
            raw = read(mod)
            shard = replace_header(mod, raw)
            assert raw.partition(b'\n\n')[2] == shard.partition(b'\n\n')[2]
            shard_imports[mod] = [m.decode() for m in IMPORT.findall(lean_code(shard))]
            if raw != shard:
                rewritten[mod] = hashlib.sha256(shard).hexdigest()
        blobs.stdin.close()
    removed = sorted(set(full).difference(only))
    assert MAIN in removed and ROOT in removed
    assert not any('.Ladder.' in mod or mod.endswith('.SmallCases') for mod in only)
    sha = lambda raw: hashlib.sha256(raw).hexdigest()
    level, previous = {}, {}
    for mod in only:
        previous[mod] = max((d for d in imports_by_mod[mod] if d in level), key=level.get, default=None)
        level[mod] = 1 + level.get(previous[mod],0)
    layers = Counter(level.values())
    chain = []
    current = max(only, key=level.get)
    while current is not None:
        chain.append(current)
        current = previous[current]
    sharded_depth = {}
    def depth(mod):
        if mod not in sharded_depth:
            sharded_depth[mod] = 1 + max((depth(dep) for dep in shard_imports[mod] if dep in level), default=0)
        return sharded_depth[mod]
    for mod in only:
        depth(mod)
    shard_chain = []
    current = max(only,key=sharded_depth.get)
    while current:
        shard_chain.append(current)
        current = max((m for m in shard_imports[current] if m in level),key=sharded_depth.get,default=None)
    meta = {
        'commit': PIN,
        'source_git_blobs': {project_source(k):project[k] for k in [MAIN, ROOT, 'TernaryGoldbach.Statement']},
        'upstream_source_sha256': {project_source(MAIN):sha(src), project_source(ROOT):sha(root)},
        'helfgott_declaration_block_sha256': sha(proof),
        'public_theorem_block_sha256': sha(theorem), 'large_module_sha256': sha(large),
        'elementary_module_sha256':sha(elementary), 'circle_input_block_sha256':sha(circle),
        'nonprime_input_block_sha256':sha(nonprime), 'elementary_project_prerequisites':elementary_only,
        'original_project_modules': len(full), 'new_project_prerequisite_modules': len(only),
        'removed_project_modules': len(removed), 'removed_ladder_data_modules': sum('.Ladder.Data.' in m for m in removed),
        'source_token_matches_in_project_prerequisites': {k: v for k, v in matches.items() if k in only},
        'project_import_levels':len(layers), 'first_level_modules':layers[1],
        'widest_level_modules':max(layers.values()),
        'one_longest_import_chain': list(reversed(chain)),
        'optional_psi_shards': {'checked_generated_data_modules':len(ALL_DATA), 'changed_headers':len(rewritten),
                                'project_import_levels':max(sharded_depth.values()),
                                'one_longest_import_chain':list(reversed(shard_chain)), 'modified_source_sha256':rewritten},
        'project_prerequisites_in_build_order': only, 'removed': removed,
        'project_prerequisite_sha256': {m:source_hash[m] for m in only},
    }
    for path, data in [(HERE / 'GoldbachLarge.lean', large), (HERE/'GoldbachElementary.lean',elementary),
                       (HERE / 'sources.json', (json.dumps(meta, indent=2) + '\n').encode())]:
        if opts.check:
            assert path.read_bytes() == data, f'changed: {path}'
        else:
            path.write_bytes(data)
    print({k:v for k,v in meta.items() if k not in ('project_prerequisites_in_build_order','project_prerequisite_sha256','one_longest_import_chain','optional_psi_shards','removed')})
    print({k:v for k,v in meta['optional_psi_shards'].items() if k not in ('modified_source_sha256','one_longest_import_chain')})


if __name__ == '__main__':
    main()
