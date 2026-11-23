"""Read-only Windows memory snapshot and artifact-size metadata; no Lean launch."""
import ctypes as c
from ctypes import wintypes as w
from datetime import datetime, timezone
from pathlib import Path
import hashlib
import json
import re

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]
SOURCE = ROOT/'work/openai-math/lean/OAI/NumberTheory/DirichletL/Arithmetic/EisensteinCoordinates.lean'
LIB = Path('C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib/.lake/build/lib/lean')

class Memory(c.Structure):
    _fields_ = [('length', w.DWORD), ('memory_load_percent', w.DWORD)] + [
        (s, c.c_ulonglong) for s in ('total_phys', 'avail_phys', 'total_pagefile',
                                    'avail_pagefile', 'total_virtual', 'avail_virtual', 'avail_extended_virtual')]

def snapshot():
    m = Memory()
    m.length = c.sizeof(m)
    k = c.WinDLL('kernel32', use_last_error=True)
    k.GlobalMemoryStatusEx.argtypes = [c.POINTER(Memory)]
    k.GlobalMemoryStatusEx.restype = w.BOOL
    if not k.GlobalMemoryStatusEx(c.byref(m)):
        raise c.WinError(c.get_last_error())
    return dict(utc=datetime.now(timezone.utc).isoformat(), **{s: int(getattr(m, s)) for s, _ in m._fields_})

def totals(modules):
    answer = {s: {'count': 0, 'bytes': 0, 'missing': 0} for s in ('.olean', '.olean.server', '.olean.private', '.ir', '.ir.sig')}
    for module in modules:
        base = LIB.joinpath(*module.split('.'))
        for suffix, item in answer.items():
            path = Path(str(base)+suffix)
            if path.is_file():
                item['count'] += 1
                item['bytes'] += path.stat().st_size
            else:
                item['missing'] += 1
    return answer

data = SOURCE.read_bytes()
original = re.findall(r'^import (\S+)', data.decode(), re.M)
narrow = ['Mathlib.NumberTheory.NumberField.Cyclotomic.PID', 'Mathlib.NumberTheory.LSeries.Nonvanishing', 'Mathlib.Analysis.Complex.HalfPlane']
result = {'kind': 'read_only_post_stop_memory_context', 'before': snapshot(),
          'source_sha256': hashlib.sha256(data).hexdigest(),
          'direct_import_artifact_sizes_only_not_transitive': {'original': totals(original), 'narrow': totals(narrow)},
          'no_lean_launch': True, 'no_dependency_content_read': True}
result['after'] = snapshot()
with (HERE/'memory_context.json').open('x', encoding='utf-8') as f:
    json.dump(result, f, indent=2)
    f.write('\n')
print(json.dumps(result, indent=2))
