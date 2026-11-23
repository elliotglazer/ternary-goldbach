"""Use the same sampled lengths and capacity classes for each candidate precision."""
import argparse
from pathlib import Path

from fixtures import Cyclic, make


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("bits", type=int, choices=(24, 28), default=24, nargs="?")
    bits = parser.parse_args().bits
    directory = Path(__file__).resolve().parent
    scale = 1 << bits
    for group in ("small", "medium", "long", "tail"):
        original = (directory / (group + ".txt")).read_text().splitlines()
        target = directory / (f"p{bits}_" + group + ".txt")
        with target.open("w", encoding="ascii", newline="\n") as stream:
            for line in original:
                n, _, cap, _ = map(int, line.split()[:4])
                width = Cyclic(n, 2 * cap * scale + 2, scale).width
                print(*make((n, bits, cap, width)), file=stream, flush=True)
        print(group, len(original), flush=True)


if __name__ == "__main__":
    main()
