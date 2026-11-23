"""Compare real file reopening, decoding and sign-run checks for both layouts."""

import hashlib
import json
import platform
import statistics
import struct
import time
from pathlib import Path

HERE = Path(__file__).resolve().parent
TEXT = HERE.parent / "full-height-count" / "packets.txt"
BINARY = HERE / "packets-q10000.bin"
HEADER = struct.Struct("<9Q")
RUN = struct.Struct("<IBQ")  # tick ≤ 2^32−1, length ≤ 60, low bits are the signs
PAIR = struct.Struct("<3Q")
MAGIC = b"SGNRUN01"


def read_text():
    with TEXT.open("rb") as stream:
        values = []
        for _ in range(2):
            for _ in range(4):
                header = tuple(map(int, stream.readline().split()))
                words = iter(map(int, stream.readline().split()))
                runs = list(zip(words, words, words, strict=True))
                values.append((header, runs))
            values.append(tuple(map(int, stream.readline().split())))
        assert not stream.read()
    return values


def write_binary(values):
    data = bytearray(MAGIC)
    for index, item in enumerate(values):
        if index % 5 == 4:
            data.extend(PAIR.pack(*item))
        else:
            header, runs = item
            data.extend(HEADER.pack(*header))
            for run in runs:
                data.extend(RUN.pack(*run))
    BINARY.write_bytes(data)


def read_binary():
    with BINARY.open("rb") as stream:
        assert stream.read(len(MAGIC)) == MAGIC
        values = []
        for _ in range(2):
            for _ in range(4):
                header = HEADER.unpack(stream.read(HEADER.size))
                data = stream.read(header[-1] * RUN.size)
                runs = list(RUN.iter_unpack(data))
                values.append((header, runs))
            values.append(PAIR.unpack(stream.read(PAIR.size)))
        assert not stream.read()
    return values


def verify(values):
    for index, item in enumerate(values):
        if index % 5 == 4:
            continue  # exact phase and guard operands compared with the pinned archive
        header, runs = item
        pair, label, region, lo, hi, entries, count, weight, total = header
        assert (pair, label, region) == (index // 5, index % 5 // 2, index % 5 % 2)
        assert len(runs) == total
        last_tick, last_sign = lo, None
        seen = changes = weighted = 0
        for tick, length, word in runs:
            assert 0 < length <= 60 and word < 1 << length and last_tick < tick
            last_tick = tick + 4096 * (length - 1)
            assert last_tick < hi
            transitions = (word ^ (word << 1)) & ((1 << length) - 2)
            if last_sign is not None and last_sign != word & 1:
                transitions |= 1
            changes += transitions.bit_count()
            while transitions:
                first = transitions & -transitions
                weighted += hi - tick - 4096 * (first.bit_length() - 1)
                transitions ^= first
            seen += length
            last_sign = word >> (length - 1)
        assert (seen, changes, weighted) == (entries, count, weight)


def benchmark():
    digest = hashlib.sha256(TEXT.read_bytes()).hexdigest()
    assert digest == "9a457d09f5a003ca47bae0aaa1bd4216d78ccf346e97bf1b3e03ad109ee41cd6"
    original = read_text()
    write_binary(original)
    assert read_binary() == original
    results = {}
    for checked in (False, True):
        times = {"text": [], "binary": []}
        for batch in range(6):
            readers = [("text", read_text), ("binary", read_binary)]
            for name, reader in readers[::1 if batch % 2 == 0 else -1]:
                start = time.process_time()
                for _ in range(16):
                    value = reader()
                    if checked:
                        verify(value)
                    assert value == original
                times[name].append((time.process_time() - start) / 16)
        results["read_and_verify" if checked else "read_and_compare"] = times
    report = dict(source_sha256=digest, binary_sha256=hashlib.sha256(BINARY.read_bytes()).hexdigest(),
                  text_bytes=TEXT.stat().st_size, binary_bytes=BINARY.stat().st_size,
                  python=platform.python_version(), cpu_seconds_per_archive=results,
                  medians={phase: {k: statistics.median(v) for k, v in times.items()}
                           for phase, times in results.items()})
    (HERE / "binary-archive-results.json").write_text(json.dumps(report, indent=2) + "\n")
    print(report["medians"], report["binary_bytes"])


if __name__ == "__main__":
    benchmark()
