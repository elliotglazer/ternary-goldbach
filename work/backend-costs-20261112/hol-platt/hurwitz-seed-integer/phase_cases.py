"""Create local recurrence checks from the same mode and bands as the seed replay."""
import json
from produce import HERE, S, power_phase, root_and_step, scale
from cases import zig


def main():
    rows = json.loads((HERE/"integer.json").read_bytes())["bands"]
    with (HERE/"phase-cases.txt").open("w",encoding="ascii",newline="\n") as out:
        for r in rows:
            f = r["grid"]
            n = r["phase_states_per_group"]//2
            A = (1+n)*f+r["center"]
            mag, step = root_and_step(A,f)
            k = A.bit_length()-f.bit_length()
            if (f<<k)>A:
                k-=1
            j = r["lo"]
            start = power_phase(mag,step,j)
            print(r["band"],f,A,k,mag,*map(zig,step),j,*map(zig,start),file=out)
            for span in (0,128,min(1024,r["hi"]-j-1)):
                z = start
                for _ in range(span):
                    z=scale(z,*step,S)
                print(span,*map(zig,z),file=out)
            z = start
            exact = []
            for _ in range(32):
                z = scale(z,*step,S)
                exact.extend(map(zig,z))
            print(*exact,file=out)


if __name__=="__main__":
    main()
