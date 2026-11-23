"""Structural/transport audit, not a second logical proof checker."""
from pathlib import Path
from collections import Counter
import gzip
import hashlib
import json
import re
import shutil
import time

home = Path(__file__).resolve().parent
source = home / 'isolated_export.sexp'
start = time.perf_counter()
cpu_start = time.process_time()
token_re = re.compile(rb'"(?:\\.|[^"\\])*"|[()]|[^\s()]+')
depth = 0
max_depth = 0
expect_kind = False
kinds = Counter()
first_kind = None
allowed = {b'Sequent', b'ConstSpec', b'TypeDefn', b'NewType',
           b'NewConst', b'NewAxiom'}
with source.open('rb') as stream:
    prefix = stream.read(100)
    assert prefix.startswith(b'# The following is a theorem of higher-order logic')
    assert b'(Sequent ()' in prefix
    stream.seek(0)
    for line in stream:
        if line.lstrip().startswith(b'#'):
            continue
        for match in token_re.finditer(line):
            token = match.group()
            if token == b'(':
                if depth == 0:
                    expect_kind = True
                depth += 1
                max_depth = max(max_depth, depth)
            elif token == b')':
                assert depth > 0 and not expect_kind
                depth -= 1
            else:
                assert depth > 0
                if token.startswith(b'"'):
                    assert len(token) >= 2 and token.endswith(b'"')
                if expect_kind:
                    assert token in allowed, token
                    kinds[token.decode()] += 1
                    if first_kind is None:
                        first_kind = token.decode()
                    expect_kind = False
assert depth == 0 and not expect_kind
assert first_kind == 'Sequent' and kinds['Sequent'] == 1
validation_wall = time.perf_counter() - start
validation_cpu = time.process_time() - cpu_start

compressed = source.with_suffix('.sexp.gz')
start = time.perf_counter()
cpu_start = time.process_time()
with source.open('rb') as original, compressed.open('wb') as target:
    with gzip.GzipFile(filename='', mode='wb', fileobj=target, mtime=0) as zipped:
        shutil.copyfileobj(original, zipped, length=1024 * 1024)
compression_wall = time.perf_counter() - start
compression_cpu = time.process_time() - cpu_start
with source.open('rb') as stream:
    digest = hashlib.file_digest(stream, 'sha256').hexdigest()
with gzip.open(compressed, 'rb') as stream:
    expanded_digest = hashlib.file_digest(stream, 'sha256').hexdigest()
assert digest == expanded_digest
with compressed.open('rb') as stream:
    compressed_digest = hashlib.file_digest(stream, 'sha256').hexdigest()
result = dict(structural_audit_passed=True, logical_recheck=False,
              empty_hypothesis_list=True, top_level_forms=dict(kinds),
              max_sexp_depth=max_depth, raw_bytes=source.stat().st_size,
              raw_sha256=digest, gzip_bytes=compressed.stat().st_size,
              gzip_sha256=compressed_digest, round_trip_sha256_matches=True,
              validation_cpu_seconds=validation_cpu,
              validation_wall_seconds=validation_wall,
              compression_cpu_seconds=compression_cpu,
              compression_wall_seconds=compression_wall)
(home / 'EXPORT_ARTIFACT.json').write_text(json.dumps(result, indent=2) + '\n')
print(json.dumps(result, indent=2))
