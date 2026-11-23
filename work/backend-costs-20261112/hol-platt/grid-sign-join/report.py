"""Collect successful sample-to-count replays and their measured local CPU costs."""
from hashlib import sha256
import json
from pathlib import Path
import re


HERE = Path(__file__).resolve().parent


def receipt(tag, marker):
    if (HERE/f"{tag}.status").read_text().strip() != "0":
        raise ValueError(f"failed replay {tag}")
    log = (HERE/f"{tag}.log").read_text()
    if marker not in log:
        raise ValueError(f"{tag} did not execute {marker}")
    for line in (HERE/f"{tag}.sha256").read_text().splitlines():
        digest, path = line.split(maxsplit=1)
        if sha256((HERE/path).read_bytes()).hexdigest() != digest:
            raise ValueError(f"{tag}: changed {path}")
    times = (HERE/f"{tag}.time").read_text()
    times = [float(re.search(rf"{mode} time \(seconds\): ([\d.]+)",times)[1])
             for mode in ("User","System")]
    return log, sum(times)


def main():
    data = json.loads((HERE/"inputs.json").read_bytes())
    channels = []
    for row in data["results"]:
        label = row["label"]
        log, cpu = receipt(f"joined07_Label{label}",f"GRID_CHANNEL_DONE {label}")
        if sha256((HERE.parent/"full-height-count"/f"grid-{label}.txt").read_bytes()).hexdigest() != row["input_sha256"]:
            raise ValueError(f"changed grid {label}")
        units = {}
        for kind in ("INPUT","EVAL"):
            match = re.search(rf"^JOIN_{kind} (.+)$", log, re.M)
            units[kind.lower()] = list(map(float,match[1].split()))
        channels.append(dict(label=label, samples=row["samples"], head_bits=row["head_bits"],
                             process_cpu=cpu, **units))
    _, join_cpu = receipt("joined07_JoinCount","JOINED_PAIRS_DONE")
    _, tables_cpu = receipt("tables02","JOIN_TABLES_DONE")
    samples = sum(c["samples"] for c in channels)
    bits = sum(c["head_bits"] for c in channels)
    report = dict(raw_input_hash_checks="Python", shared_grid_channel_and_count_checks="HOL4",
                  channels=channels, head_bits_per_sample=bits/samples,
                  samples_including_halos=samples, join_cpu=join_cpu, tables_cpu=tables_cpu,
                  phase_cpu=sum(sum(c["input"])+sum(c["eval"]) for c in channels),
                  channel_process_cpu=sum(c["process_cpu"] for c in channels))
    (HERE/"results.json").write_text(json.dumps(report,indent=2)+"\n")
    print(json.dumps(report))


if __name__ == "__main__":
    main()
