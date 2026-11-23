"""Fixed benign child. Preparation only; the reviewed supervisor launches it."""
import gc
import hashlib
import json
from pathlib import Path
import sys
import time


def main():
    case, directory, token = sys.argv[1:]
    if case not in ("normal", "timeout") or len(token) != 32:
        raise ValueError("invalid fixed fixture")
    directory = Path(directory)
    log = directory / (case + ".jsonl")
    source = hashlib.sha256(Path(__file__).read_bytes()).hexdigest().upper()
    prefix = hashlib.sha256()
    with log.open("xb", buffering=0) as stream:
        def emit(stage, **fields):
            obj = dict(case=case, token=token, source_sha256=source, stage=stage, **fields)
            raw = (json.dumps(obj, sort_keys=True, separators=(",", ":")) + "\n").encode()
            stream.write(raw)
            import os
            os.fsync(stream.fileno())
            prefix.update(raw)

        def await_ack(stage):
            deadline = time.monotonic_ns() + 5_000_000_000
            path = directory / ("normal." + stage + ".ack")
            while time.monotonic_ns() < deadline:
                try:
                    if path.read_bytes() == token.encode():
                        return
                    raise ValueError("bad acknowledgment")
                except FileNotFoundError:
                    time.sleep(.01)
            raise TimeoutError("bounded acknowledgment wait")

        if case == "timeout":
            emit("idle")
            time.sleep(60)  # supervisor must terminate this harmless idle process
            raise RuntimeError("timeout supervisor did not terminate")
        emit("baseline")
        await_ack("baseline")
        block = bytearray(16 * 1024 * 1024)
        for index in range(0, len(block), 4096):
            block[index] = 1
        block[-1] = 1
        emit("held", allocation_bytes=len(block))
        await_ack("held")
        del block
        gc.collect()
        emit("released")
        late = bytearray(32 * 1024 * 1024)
        for index in range(0, len(late), 4096):
            late[index] = 2
        late[-1] = 2
        emit("finished", allocation_bytes=len(late), prefix_sha256=prefix.hexdigest().upper())
        # Keep `late` alive through final log write and normal interpreter exit.
        return late


if __name__ == "__main__":
    retained_late_allocation = main()
