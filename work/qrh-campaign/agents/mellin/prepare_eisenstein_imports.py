from pathlib import Path
import hashlib
import json
import re

workspace = Path(__file__).resolve().parents[4]
source = workspace / 'work/openai-math/lean/OAI/NumberTheory/DirichletL/Arithmetic/EisensteinCoordinates.lean'
mathlib = Path('C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib')
roots = [
'Mathlib.NumberTheory.NumberField.Cyclotomic.PID',
'Mathlib.NumberTheory.LSeries.Nonvanishing',
'Mathlib.NumberTheory.ArithmeticFunction.Moebius',
'Mathlib.NumberTheory.GaussSum',
'Mathlib.Analysis.Analytic.Uniqueness',
'Mathlib.Analysis.Analytic.Constructions',
'Mathlib.Analysis.Complex.Convex',
'Mathlib.Analysis.Complex.HalfPlane',
'Mathlib.Analysis.Real.Sqrt',
'Mathlib.Algebra.Order.BigOperators.Group.Finset',
'Mathlib.Tactic.FieldSimp',
'Mathlib.Tactic.Linarith',
'Mathlib.Tactic.NormNum',
'Mathlib.Tactic.Positivity',
'Mathlib.Tactic.Ring',
'Mathlib.Tactic.Group',
'Mathlib.Tactic.GCongr',
]
def strip_comments(text):
    output = []
    index = 0
    depth = 0
    while index < len(text):
        pair = text[index:index + 2]
        if pair == '/-':
            depth += 1
            index += 2
        elif depth and pair == '-/':
            depth -= 1
            index += 2
        elif depth:
            if text[index] == '\n':
                output.append('\n')
            index += 1
        elif pair == '--':
            end = text.find('\n', index)
            index = len(text) if end < 0 else end
        else:
            output.append(text[index])
            index += 1
    return ''.join(output)

cache = {}
def dependencies(module, public_only):
    key = module, public_only
    if key in cache:
        return cache[key]
    path = mathlib.joinpath(*module.split('.')).with_suffix('.lean')
    if not path.exists():
        cache[key] = []
        return []
    text = strip_comments(path.read_text(encoding='utf-8-sig'))
    is_module = re.search(r'^module\s*$', text, re.M) is not None
    imports = []
    for line in text.splitlines():
        match = re.match(r'^(public\s+)?(?:meta\s+)?import\s+([A-Za-z0-9_.]+)', line)
        if match and (not public_only or not is_module or match[1]):
            imports.append(match[2])
    cache[key] = imports
    return imports

def closure(roots, public_only):
    seen = set()
    pending = list(roots)
    while pending:
        module = pending.pop()
        if module in seen:
            continue
        seen.add(module)
        pending.extend(dependencies(module, public_only))
    return seen

public_closures = {root: closure([root], True) for root in roots}
redundancy = {root: [other for other in roots if other != root and root in public_closures[other]] for root in roots}
minimal_roots = [root for root in roots if not redundancy[root]]
original_bytes = source.read_bytes()
body_offset = original_bytes.index(b'namespace OAI')
body = original_bytes[body_offset:]
original_imports = re.findall(rb'^import ([A-Za-z0-9_.]+)', original_bytes[:body_offset], re.M)
original_imports = [module.decode() for module in original_imports]
output = Path(__file__).resolve().parent
candidate = output / 'EisensteinCoordinates.lean'
candidate.write_bytes(('\n'.join('import ' + root for root in minimal_roots) + '\n\n').encode() + body)
assert candidate.read_bytes().split(b'namespace OAI', 1)[1] == original_bytes.split(b'namespace OAI', 1)[1]
manifest = {
    'source': str(source),
    'original_import_count': len(original_imports),
    'proposed_import_count': len(minimal_roots),
    'candidate_imports': minimal_roots,
    'provider_roots': roots,
    'public_import_redundancy': redundancy,
    'original_all_mathlib_closure_count': len(closure(original_imports, False)),
    'candidate_all_mathlib_closure_count': len(closure(minimal_roots, False)),
    'source_sha256': hashlib.sha256(original_bytes).hexdigest(),
    'candidate_sha256': hashlib.sha256(candidate.read_bytes()).hexdigest(),
    'body_sha256': hashlib.sha256(body).hexdigest(),
    'declaration_body_bytes_equal': True,
    'compiled': False,
    'performance_measured': False,
}
(output / 'import-manifest.json').write_text(json.dumps(manifest, indent=2) + '\n', encoding='utf-8')
print(json.dumps(manifest, indent=2))

