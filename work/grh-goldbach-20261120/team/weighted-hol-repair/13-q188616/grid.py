"""Produce certified dyadic raw time samples and verify independent Dirichlet L evaluations."""
from hashlib import sha256
import json
from pathlib import Path
from time import process_time

from flint import acb, arb, ctx, dirichlet_char

from spectrum import HERE,BITS,Q,LABELS,parameters,phase_and_weights

GRID_BITS = 220
HALO = 128


def run():
    ctx.prec,ctx.threads = 336,1
    start = process_time()
    meta = json.loads((HERE/"spectrum.json").read_bytes())
    source = HERE/"coefficients.tsv"
    assert sha256(source.read_bytes()).hexdigest()==meta["sha256"][source.name]
    main,last,N,J,theta = parameters()
    phases,_ = phase_and_weights()
    dt = arb(5)/64
    omega = 2*arb.pi()/(N*dt)
    b = arb.pi()/4-theta/(last*dt)
    eps = 1/(arb((1<<80)*4)*3**theta)
    error = 3*eps/(4*omega)
    assert 2*arb(2)**(-GRID_BITS) < eps/(64*(arb(44)/(7*N*dt)))
    receipts = []
    for col,label in enumerate(LABELS):
        spectrum = [acb(0)]*N
        count = 0
        with source.open() as f:
            for line in f:
                fields = line.split()
                j = int(fields[0])
                assert j==count
                count += 1
                v = acb(arb((int(fields[1+2*col]),-BITS)),arb((int(fields[2+2*col]),-BITS)))
                # FLINT's forward DFT has a negative exponent.
                spectrum[-j] = v
                if j:
                    spectrum[j] = v.conjugate()
        assert count==J+1
        t0 = process_time()
        raw = acb.dft(spectrum)
        del spectrum
        fft_seconds = process_time()-t0
        path = HERE/("grid-%d.txt"%label)
        retained = {}
        with path.open("w",newline="\n") as out:
            for j in range(-HALO,last+HALO+1):
                z = raw[j % N]
                assert z.imag.contains(0)
                mid = int((z.real.mid()*(1<<GRID_BITS)).floor().unique_fmpz())
                assert abs(z.real*(1<<GRID_BITS)-mid)<2
                out.write(str(mid)+"\n")
                if j in (-1,0,1,main,last):
                    retained[j] = z.real
        del raw
        # Verify the complete normalization by an independent evaluation of L(s,chi).
        ctx.prec = 228
        chi = dirichlet_char(Q,label)
        k = arb(1+2*chi.parity())/2
        checks = []
        t0 = process_time()
        for j,value in retained.items():
            t = dt*j
            s = acb(arb(1)/2,t)
            pref = ((s+chi.parity())/2*(arb(Q)/arb.pi()).log() +
                    ((s+chi.parity())/2).lgamma() + b*t-k/2*arb(Q).log()).exp()
            expected = phases[col]*pref*chi.l(s)/omega
            assert expected.imag.contains(0) and abs(expected.real-value)<error
            checks.append(dict(tick=j,difference=str(abs(expected.real-value)),raw=str(value)))
        ctx.prec = 336
        receipts.append(dict(label=label,fft_cpu=fft_seconds,reference_cpu=process_time()-t0,
                             checks=checks,grid_sha256=sha256(path.read_bytes()).hexdigest()))
        print(label,fft_seconds,receipts[-1]["reference_cpu"],flush=True)
    (HERE/"grid.json").write_text(json.dumps(dict(bits=GRID_BITS,halo=HALO,rows=receipts,
        total_cpu=process_time()-start,spectrum_sha256=meta["sha256"][source.name],
        script_sha256=sha256(Path(__file__).read_bytes()).hexdigest()),indent=2)+"\n")


if __name__=="__main__":
    run()
