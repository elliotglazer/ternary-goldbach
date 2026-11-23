"""Reconstruct selected scans from frozen source TSVs, then emit HOL inputs."""
import hashlib
import json
from fractions import Fraction
from pathlib import Path

HERE = Path(__file__).resolve().parent
MANIFEST = HERE.parent / "guard-repricing" / "endpoint-policy.json"


def digest(data):
    return hashlib.sha256(data).hexdigest()


def runs(samples, step):
    result = []
    for pos, sign in samples:
        if result and result[-1][1] < 60 and pos == result[-1][0] + step * result[-1][1]:
            last = result[-1]
            last[2] |= (sign > 0) << last[1]
            last[1] += 1
        else:
            result.append([pos, 1, int(sign > 0)])
    assert [(pos + step * i, 1 if word >> i & 1 else -1)
            for pos, length, word in result for i in range(length)] == samples
    return result


def main():
    raw = MANIFEST.read_bytes()
    grid = MANIFEST.with_name("endpoint-grid.json").read_bytes()
    rows = [dict(r, grid=True) for r in json.loads(grid)["rows"]] + json.loads(raw)["rows"]
    records, seen, aliases, hashes, pairs = [], {}, {}, {}, set()
    for row in rows:
        policy = row["policy"]
        shift = int(row.get("grid", False))
        if (row["endpoint_inclusive"] and not shift) or row["guard"] != 640 or policy not in ("no_edges", "selected"):
            continue
        if shift:
            assert policy == "no_edges" and row["endpoint_inclusive"]
            policy = "grid"
        q, labels = row["q"], row["labels"]
        t, h, step = row["t_tick"], row["h_tick"], row["sub"]
        assert step in (4096, 20480) and h - t == 640 * step
        phase = Fraction(row["phase_upper"]) * 2**32
        allowance = Fraction(row["allowance"])
        assert phase.denominator == allowance.denominator == 1
        head = [q, *labels, policy, step, 640, int(phase), int(allowance), shift, int(row["passes"])]
        lines = []
        for lab, rel, kept, counts in zip(labels, row["signs"], row["kept_edges"], row["scans"], strict=True):
            path = (MANIFEST.parent / rel).resolve()
            data = path.read_bytes()
            hashes[rel] = digest(data)
            assert hashes[rel] == json.loads((path.parent / "counts.json").read_bytes())["sha256"][path.name]
            assert hashes[rel] == row["sign_sha256"][labels.index(lab)]
            assert path.name == f"signs-{lab}.tsv"
            samples = [tuple(map(int, ln.split())) for ln in data.splitlines()]
            assert all(s in (-1, 1) for _, s in samples)
            assert all(x < y for (x, _), (y, _) in zip(samples, samples[1:]))
            allowed = set(kept)
            edges = set(row["available_edges"])
            assert allowed <= edges and allowed <= {x for x, _ in samples}
            for i, (lo, hi) in enumerate([(0, t), (t, h)]):
                selected = [(x, s) for x, s in samples if (lo <= x <= hi if shift else lo < x < hi) and (x not in edges or x in allowed)]
                changes = [x for (_, a), (x, b) in zip(selected, selected[1:]) if a != b]
                k, w = len(changes), sum(hi - x for x in changes)
                assert [k, w] == counts[2*i:2*i+2]
                packed = runs([(x + shift, s) for x, s in selected], step)
                lines += [" ".join(map(str, [lo, hi + 2 * shift, k, w + shift * k, len(packed)])),
                          " ".join(str(v) for triple in packed for v in triple)]
        pair = (q, *labels)
        pairs.add(pair)
        key = (pair, tuple(head[4:]), digest("\n".join(lines).encode()))
        if key in seen:
            aliases[str((*pair, policy))] = seen[key]
            continue
        seen[key] = policy
        records.append([" ".join(map(str, head)), *lines])
    assert len(pairs) == 5
    packet = ("\n".join([str(len(records)), *(s for record in records for s in record)]) + "\n").encode()
    (HERE / "selected-packets.txt").write_bytes(packet)
    (HERE / "receipts.json").write_text(json.dumps(dict(policy_sha256=digest(raw), grid_sha256=digest(grid), inputs=hashes,
        packet_sha256=digest(packet), aliases=aliases, rows=[r[0] for r in records]), indent=2) + "\n")


if __name__ == "__main__":
    main()
