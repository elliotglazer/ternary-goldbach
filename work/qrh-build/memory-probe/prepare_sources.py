"""Stage three diagnostic sources only. Never invokes Lean or Lake.

All writes are exclusive. Re-running against existing output fails rather than
overwriting it. Import-only sources are controls, not substitute proofs.
"""
from pathlib import Path
import hashlib
import json

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]
REL = Path('OAI/NumberTheory/DirichletL/Arithmetic/EisensteinCoordinates.lean')
SOURCE = ROOT / 'work/openai-math/lean' / REL
OLD = ROOT / 'work/qrh-campaign/agents/mellin'

def sha(data):
    return hashlib.sha256(data).hexdigest()

def write_new(path, data):
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open('xb') as stream:
        stream.write(data)

def main():
    original = SOURCE.read_bytes()
    candidate = (OLD / 'EisensteinCoordinates.lean').read_bytes()
    assert sha(original) == 'a97237026d0add0b1e1f6a3a025a253a9e6dd17c0e06929f779772727f02260b'
    assert sha(candidate) == '7a9e677b2abd33b80be2278b202895e94a11c71a49b81da72314fd8e1d05091b'
    original_header, original_body = original.split(b'namespace OAI', 1)
    candidate_header, candidate_body = candidate.split(b'namespace OAI', 1)
    assert original_body == candidate_body
    body = b'namespace OAI' + original_body
    marker = b'-- Diagnostic marker: reaching this command means the import header completed.\n#check True\n'
    variants = {
        'original-imports': original_header + marker,
        'narrow-imports': candidate_header + marker,
        'narrow-full': candidate,
    }
    receipt = {
        'kind': 'static_source_staging_only',
        'lean_executed': False,
        'provider_validated': False,
        'performance_claim': None,
        'source': str(SOURCE),
        'original_sha256': sha(original),
        'body_sha256': sha(body),
        'full_candidate_body_equal': True,
        'historical_import_manifest_sha256': sha((OLD / 'import-manifest.json').read_bytes()),
        'historical_closure_counts_not_recomputed': {'original': 4023, 'narrow': 3827},
        'variants': {},
    }
    for label, data in variants.items():
        source_root = HERE / label / 'src'
        destination = source_root / REL
        write_new(destination, data)
        receipt['variants'][label] = {
            'source': str(destination), 'source_root': str(source_root),
            'sha256': sha(data), 'bytes': len(data),
            'import_count': sum(line.startswith(b'import ') for line in data.splitlines()),
            'completion_marker': None if label == 'narrow-full' else '#check True',
            'diagnostic_only': True,
        }
    assert SOURCE.read_bytes() == original
    receipt['source_unchanged_after'] = True
    write_new(HERE / 'staging.json', (json.dumps(receipt, indent=2) + '\n').encode())
    print(json.dumps(receipt, indent=2))

if __name__ == '__main__':
    main()
