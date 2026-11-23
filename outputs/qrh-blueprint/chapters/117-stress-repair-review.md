# Tight-checkpoint stress result and sufficient repair — 2026-11-11

Verdict: the reported first tight certificate failure is correct. It is not a proved violation of the actual theta bound. Replacing the sufficient checkpoint band ±a/24000 by ±a/10000 preserves the SAME target E on the unchanged a/4000 grid. All 538 currently recorded checkpoint brackets pass this relaxed band. This is a conditional interpolation proof plus external arithmetic review, not completion of the prime envelope or a Lean count certificate.

## Independent work and scope

Reviewed prime-estimates/resume_psi_stress512_20261111.py and its JSON, source Small.chkLow/chkStep definitions in Prelim/SmallMertens.lean:23 and SmallPsi.lean:27, and the source stg2813 theta seed in PsiSieveMain.lean:28149. The script uses two segmented sieve layouts and explicitly stops at the first failed tight checkpoint; it does not change the tight criterion during its run.

The independent audit script resume_psi_stress_repair_review_20261111.py exited 0. It replays the entire 538-window rational theta/log chain from the actual source seed, every recorded subwindow partition and count sum, and every source Taylor log-box inequality. Earlier 537 prime counts are accepted as supplied for this replay, not independently re-sieved here. Only the last window is independently recounted using a freshly trial-generated complete base, an odd-composite set, and trial division of every surviving candidate. This bounded scope does not duplicate the 135,662,074-position continuation sieve.

No Lean build, canonical source edit or frozen 104-chapter package edit was made. No external count is treated as a theorem premise accepted by the kernel.

## Exact first failure

The continuation starts after global window 33 at 1,008,283,069. It computes 505 new windows; 504 pass the tight bracket test and the last fails. Thus global windows 1 through 537 pass, and the first failed acceptance is global window 538:

- a = 1,143,659,229; b = 1,143,945,143; width = 285,914 = floor(a/4000).
- Count in (a,b] = 13,635, independently confirmed.
- Prime-list ASCII SHA256 = 93c33f8b81642a81996c441798262754e90f7db0350730fcc048f03f1063c5e8.
- Certified right log box: [20857748766,20857748786]/10^9, width 2e-8.
- Propagated L = 285974353129219719/250000000.
- Propagated U = 571950915460383649/500000000.
- L-(b-b/24000) = -49576622093/750000000, approximately -66.1021627907.
- U-L = 2209201944211/500000000, approximately 4418.403888422.

Exact order is L < b-b/24000 < U < b+b/24000. Therefore the enclosure fails to certify the lower tight inequality, while remaining compatible with that inequality being true. Its midpoint is not a certified theta value. Neither a false prime count nor an actual tight-bound violation follows from this result.

All 538 recorded prime-count windows exist externally, including the failed-acceptance window; 5,901 of the 6,439 windows remain uncounted. Do not describe the failed checkpoint as an uncounted window. Conversely, 538 counted windows do not mean 538 certified tight brackets or Lean count proofs.

## Repair without changing E

Let A=10^9, B=5*10^9 and consecutive grid endpoints satisfy

    b=min(B,a+floor(a/4000)).

Require a-a/10000 <= theta(a) <= a+a/10000 at every endpoint. Retain the reviewed P6 bound and monotonicity of theta and psi. For every real t>=A,

    0 <= psi(t)-theta(t) < 1.4262*sqrt(t) <= (17/360000)*t.

The last inequality follows at A by squaring positive rational quantities, then by monotonicity of 1/sqrt(t). For a<=v<=b, the lower error is

    v-psi(v) <= (b-a)+a/10000 <= (7/20000)*a.

For the upper error use the endpoint b:

    psi(v)-v <= (b-a)+(1/10000+17/360000)*b
               <= [1/4000+(1/10000+17/360000)*(4001/4000)]*a
               = (572053/1440000000)*a.

Both coefficients are strictly below 1/2300. Exact slacks are

    1/2300-7/20000 = 39/460000,
    1/2300-572053/1440000000 = 1242781/33120000000.

On [A,B], log(v)>0 and log(v)<23: exp(1)>2.7 and the exact rational inequality 2.7^23>5e9 suffice. As a<=v, both errors are strictly below v/2300 < .01*v/log(v). Hence the original E(v), abs(psiN(v)-v)<=.01*v/log(v), follows on every integer in the complete grid once the endpoint certificates are proved. The real step-function version also follows; no extra floor error is needed inside this argument. The final shortened grid cell only improves the width inequalities.

The source seed bracket is inside the relaxed band. All 538 supplied later brackets satisfy it as well; their smallest positive margin is 63519486670203/10^9 = 63519.486670203. This establishes present-data compatibility, not that all future 5,901 brackets will pass. The wider band is a newly justified sufficient condition, not a silent reinterpretation of the stress run's fixed 24000 test.

## Source and remaining proof obligations

The original source logarithm certificates use scale 10^9. Changing the checkpoint tolerance does not change that scale or the accepted log-box formulas. All widths checked here are within 1e-7. Propagation uses lower endpoint logs for lower increments and upper endpoint logs for upper increments, with exact open-left/closed-right prime counts. No prime-power counting is needed if P6 is supplied by its reviewed proof.

The stress script correctly reports that the old 66000-bit mask-length inequality first fails at global window 398: floor(sqrt(b))+32768=66003. This is an implementation specification issue, not a defect in its external Python sieve. Future source count proofs require a sufficiently long generalized mask and complete base-prime certificate; the old cnt3 theorem must not simply be reused outside its hypotheses.

This repair concerns only the finite short-gap certificate condition. The short gap remains useful for the full E route only with the separate, unproved complete low-zeta strip and reciprocal-moment certificate through height 10^6, plus the selected global and finite spectral inputs. It does not replace or follow from the original shared .555 premise alone. The primary longer-gap route in the frozen package is unchanged.

## Pins

| Artifact | SHA256 |
|---|---|
| prime-estimates/resume_psi_stress512_20261111.py | 9BF1A629542C848378D8B5419C36170C062C73B563D6A734F5B8DAE82D92B3E7 |
| prime-estimates/resume_psi_stress512_20261111.json | EADD08660ECD980AEEDBC12F87EB495BC2432F56C6C4A8DC626C4C699B67E593 |
| prime-estimates/resume_psi_stress512_20261111.resources.json | 4E89F2FC3C4B2B0308D43A7FEDE6740C301A31B19FE44787847F5FA3B7783FD6 |
| prior short-gap JSON | E8065467BE53708445486B2F5EA5CBBE408B3A014CF2D1FA8746EC999485F595 |
| prior 32-window JSON | 03B835D97BE31AEAA9E48D9AE1A3275BD033767BE8E07EFACAE5118820151D5D |

The independent script and result JSON are saved beside this review. The producer resource report is retained only as reported external measurements; no Lean timing or full-gap performance extrapolation was checked.

## Frozen producer-note review

After the independent replay, read both completed producer notes in full. The stress note correctly distinguishes the conservative square-root-cap mask failure at index398 from the largest-required-prime cap, and records exit0 as completion of a failed-certificate stop protocol. The relaxed-condition note agrees with the independent interpolation and chain replay above. No blocking correction found. Its description of the new condition as pending independent review is superseded by this mathematical acceptance, not by a Lean proof.

- `RESUME_PSI_STRESS512_2026-11-11.md`: `F623DCAD230D8B4CB3684F3A8317991A6560851D491A852B26615EAA9A5D0CBA`.
- `RESUME_PSI_RELAXED_CHECKPOINT_2026-11-11.md`: `E988744F9E9469E88F8E38B94FC8EC2732A73B0C8777EC90E8D2F4198A28F3B5`.
- `resume_psi_relaxed_checkpoint_20261111.py`: `880BBE3DEF05DDB93934C8AC113F38CA4A98866F14ECA3A18E58E084C5F42344`.
- `resume_psi_relaxed_checkpoint_20261111.json`: `BAB7CB9CC59412DA30C6FF9869AE6FCFB02C5E45B70D9ADB1D686858A2EBA928`.
