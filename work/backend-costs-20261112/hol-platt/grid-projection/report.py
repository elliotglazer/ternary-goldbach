"""Validate the current raw and compressed inputs and price the explicit rounding replay."""
from hashlib import sha256
import json
from pathlib import Path
import re


ROOT = Path(__file__).resolve().parent


def digest(path):
    return sha256(path.read_bytes()).hexdigest()


def receipt(tag, tiles, samples):
    if (ROOT/f"{tag}.status").read_text().strip() != "0":
        raise RuntimeError(tag)
    for line in (ROOT/f"{tag}.sha256").read_text().splitlines():
        h, p = line.split(maxsplit=1)
        if digest(ROOT/p) != h:
            raise ValueError(f"changed input for {tag}: {p}")
    log = (ROOT/f"{tag}.log").read_text()
    hits = re.findall(r"^PROJECTION_COUNTS (\d+) (\d+) (\d+)$", log, re.M)
    if hits != [(str(tiles),str(samples),"8")] or len(re.findall(r'Saved theorem .+ "reject_\d+_\d+"',log)) != 8:
        raise ValueError(f"{tag}: output coverage")
    times = list(map(float,re.search(r"^PROJECTION_CPU (.+)$", log, re.M)[1].split()))
    timing = (ROOT/f"{tag}.time").read_text()
    cpu = sum(float(re.search(rf"{mode} time \(seconds\): ([\d.]+)",timing)[1]) for mode in ("User","System"))
    peak = int(re.search(r"Maximum resident set size \(kbytes\): (\d+)",timing)[1])
    return dict(tiles=tiles,samples=samples,setup=times[0],numerals=times[1],check=times[2],
                statement_checks_and_controls=times[3],worker=times[4],process=cpu,peak_kib=peak)


def main():
    inputs=json.loads((ROOT/"source.json").read_bytes())
    short=ROOT.parent/"grid-sign-join"
    raw=ROOT.parent/"full-height-count"
    if digest(ROOT/"source.hex")!=inputs["source_sha256"] or digest(short/"inputs.json")!=inputs["input_sha256"]:
        raise ValueError("different source or tile manifest")
    rows=json.loads((short/"inputs.json").read_bytes())["results"]
    for row in rows:
        label=row["label"]
        if digest(raw/f"grid-{label}.txt")!=row["input_sha256"] or digest(short/f"tiles-{label}.txt")!=row["tiles_sha256"]:
            raise ValueError(f"changed raw grid or compressed heads {label}")
    pilot=receipt("pilot01",72,4356)
    all_tiles=receipt("all01",inputs["tiles"],inputs["samples"])
    schedule=json.loads((raw/"sensitivity.json").read_bytes())
    # This population includes 640 additional grid nodes per label.
    # The measured layouts also contain both 128-sample interpolation halos.
    labels=schedule["labels"]
    population=schedule["coarse_640"]
    expanded_population=population+256*labels
    factor=expanded_population/(3600*all_tiles["samples"])
    result=dict(pilot=pilot,full=all_tiles,records=inputs,labels=labels,
                samples_hypothetically_including_halos=expanded_population,
                conditional_core_hours={k:all_tiles[k]*factor for k in ("numerals","check","worker","process")},
                assumption="Same per-sample costs at other conductors and two 128-point halos per label, on the 640-extra-node schedule. Single-conductor sensitivity, not an end-to-end forecast.")
    (ROOT/"results.json").write_text(json.dumps(result,indent=2)+"\n")
    print(json.dumps(result))


if __name__ == "__main__":
    main()
