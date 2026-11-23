"""Count same-conductor, same-band height lanes on the saved main grids."""

import hashlib
import json
from pathlib import Path


def fold():
    work = Path(__file__).resolve().parents[3]
    path = work / "qrh-campaign/agents/integration/transform_structural_manifest_20261111.json"
    raw = path.read_bytes()
    manifest = json.loads(raw)
    widths = (8, 16, 32, 64)
    reports = []
    for scenario, extra in enumerate(manifest["extras"]):
        padded = dict.fromkeys(widths, 0)
        useful = 0
        for record in manifest["conductors"]:
            _, phi, _, _, _, _, heights = record
            bands = heights[5 * scenario:5 * (scenario + 1)]
            if len(bands) != 5:
                raise ValueError("missing source bands")
            useful += phi * sum(bands)
            for width in widths:
                padded[width] += phi * sum((-h) % width for h in bands)
        reports.append(dict(extra=extra, actual_residue_heights=useful,
                            unused_residue_lanes=padded,
                            occupancy={w: useful/(useful+n) for w, n in padded.items()}))
    return dict(input_sha256=hashlib.sha256(raw).hexdigest(),
                conductors=len(manifest["conductors"]), scenarios=reports)


if __name__ == "__main__":
    print(json.dumps(fold(), indent=2))
