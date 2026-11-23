"""Count the exact high-precision signs needed to recover each pilot's sign changes."""
import hashlib
import itertools
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent


def changes(signs):
    return sum(a != b for a, b in zip(signs, signs[1:]))


def subsets(items):
    for n in range(len(items) + 1):
        yield from itertools.combinations(items, n)


def analyze(nodes, bits):
    columns = []
    unknowns = []
    for node in nodes:
        n = node["sign_count"]
        packed = int(node["reference_signs_hex"], 16)
        assert packed.bit_length() == n + 1
        columns.append(packed & ((1 << n) - 1))
        row = next(t for t in node["tests"] if t["bits"] == bits)
        unknown = set(row["modes"])
        assert len(unknown) == row["unresolved"] and all(1 <= k <= n for k in unknown)
        unknowns.append(unknown)
    assert all(t["sign_count"] == n for t in nodes)
    full_variations = sum((a ^ b).bit_count() for a, b in zip(columns, columns[1:]))
    repairs = []
    losses = 0
    candidates = {s: True for s in subsets(range(len(nodes)))}
    for k in sorted(set.union(*unknowns)):
        reference = [(z >> (n - k)) & 1 for z in columns]
        target = changes(reference)
        holes = [i for i, u in enumerate(unknowns) if k in u]

        def count_with(picked):
            return changes([v for i, v in enumerate(reference) if i not in holes or i in picked])

        losses += target - count_with(())
        chosen = next(s for s in subsets(holes) if count_with(s) == target)
        repairs.extend((nodes[i]["j"], k) for i in chosen)
        for s in candidates:
            if candidates[s] and count_with(s) < target:
                candidates[s] = False
    whole = next(s for s, ok in candidates.items() if ok)
    return dict(bits=bits, reference_sign_changes=full_variations, coarse_only_lost_changes=losses,
                inconclusive_signs=sum(map(len, unknowns)), fewest_extra_signs=len(repairs),
                selected_pairs=repairs, fewest_whole_height_reruns=len(whole),
                selected_whole_heights=[nodes[i]["j"] for i in whole])


if __name__ == "__main__":
    artifact = HERE / "prime-131071.json"
    data = json.loads(artifact.read_bytes())
    assert [r["j"] for r in data["nodes"]] == data["requested"] == [1, 2, 3, 5694, 5695, 5696]
    output = {"input_sha256": hashlib.sha256(artifact.read_bytes()).hexdigest(),
              "conductor": data["q"], "panels": {}}
    for name, nodes in [("low", data["nodes"][:3]), ("high", data["nodes"][3:])]:
        output["panels"][name] = [analyze(nodes, p) for p in (20, 24, 28, 32)]
        for row in output["panels"][name]:
            print(name, row["bits"], row["inconclusive_signs"], row["coarse_only_lost_changes"],
                  row["fewest_extra_signs"], row["fewest_whole_height_reruns"])
    (HERE / "prime-repair.json").write_text(json.dumps(output, indent=2) + "\n")
