"""One prespecified 524288-even interval including 10^12."""
import hashlib
import json
from math import prod
from pathlib import Path
import sys
from time import perf_counter, process_time

HERE = Path(__file__).resolve().parent
TEAM = HERE.parent
sys.path.insert(0, str(TEAM/"small-prefix"))
from generate import primes_through, odd_sieve, bitmap, pack, cover_tail
from flint import fmpz

WIDTH = 2**19
HALO = 4096
HIGH = 10**12 + 2
LOW = HIGH - 2*WIDTH


def run():
    wall, cpu = perf_counter(), process_time()
    primes = primes_through(1_000_000)
    flags = odd_sieve(3, WIDTH+HALO, primes)
    bits, rev = bitmap(flags), bitmap(flags[::-1])
    base = LOW-3-2*HALO
    available = odd_sieve(base, HALO+1, primes)
    mask = (1<<WIDTH)-1
    left = mask
    offsets = []
    for s, valid in enumerate(available):
        if valid:
            covered = (bits >> (HALO-s)) & left
            if covered:
                offsets.append(s)
                left ^= covered
                if not left:
                    break
                if len(offsets)%4 == 0 and left.bit_count() <= 192:
                    offsets.extend(cover_tail(left,available,rev,len(flags),HALO,True))
                    break
    covered = 0
    for s in offsets:
        covered |= bits >> (HALO-s)
    assert covered & mask == mask
    anchors = [base+2*s for s in offsets]
    modulus = prod(anchors)
    coverage_cpu = process_time()-cpu
    start = process_time()
    fac = fmpz.fac_ui(1_000_000)
    inv = int(pow(fac % modulus, -1, modulus))
    assert int((fac*inv)%modulus)==1
    inverse_cpu = process_time()-start
    code = f'''import SampleBits
import BandMillionFactorial
namespace TrillionEndpoint
open SmallGoldbach
set_option maxRecDepth 20000
set_option maxHeartbeats 0
def rows : List Row := [⟨{WIDTH}, {len(offsets)}, packedHex% "{pack(offsets):x}", packedHex% "{inv:x}"⟩]
theorem interval : Covered {LOW} {HIGH} :=
  checked_interval (halo := {HALO}) SampleWindow.source BandMillionFactorial.fac_eq rows
    (by decide) (by decide) (by decide +kernel) (by decide +kernel)
#print axioms interval
end TrillionEndpoint
'''
    source = code.encode()
    io = perf_counter()
    (HERE/"TrillionEndpoint.lean").write_bytes(source)
    io_wall = perf_counter()-io
    receipt = dict(low=LOW,high_exclusive=HIGH,evens=WIDTH,halo=HALO,anchors=anchors,
                   source_bytes=len(source),sha256=hashlib.sha256(source).hexdigest(),
                   coverage_cpu_s=coverage_cpu,factorial_and_inverse_cpu_s=inverse_cpu,
                   write_wall_s=io_wall,wall_s=perf_counter()-wall,cpu_s=process_time()-cpu)
    (HERE/"producer.json").write_text(json.dumps(receipt,indent=2))
    print(len(anchors),len(source),receipt["cpu_s"])


if __name__ == "__main__":
    run()
