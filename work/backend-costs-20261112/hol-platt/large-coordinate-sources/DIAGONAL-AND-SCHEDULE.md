# Removing the last diagonal

Let c be the exact unit postchirp, c' its stored approximation with |c'-c|≤δ<1, U the exact pre-post convolution value in the stage's real units, and V a certified rounded output. Assume |V-c'U|≤r and |V-Dχ|≤E. Since |c|=1, multiplication by c preserves norm. The triangle inequality gives |U-conj(c)Dχ|≤E+r+δ|U|. An available upper bound for |U| from the accumulator itself gives the sharpest data-specific charge. If |V|≤B, take (B+r)/|c'|, bounding |c'| below by 1−δ if necessary. If only |Dχ|≤M is known, use (E+r+δM)/(1−δ) for the whole error. For a nearest p-grid terminal in both coordinates r≤2^(-p)/√2. An exact shift changes the represented units and applies the same scaling to every radius. Multiplying εχ by c preserves H exactly.

A direct stage estimate avoids paying the old post-rounding error twice. For exact input x with |x|≤X, input approximation error ε, prechirp coefficient error δ1, rounded prechirp stage error r1, unit convolution kernel coefficient error δ2, and n terms, the prechirped input error is e1=(1+δ1)ε+Xδ1+r1. The convolution error is at most n[(1+δ2)e1+Xδ2]. This controls U directly relative to conj(c)D for an exact unnormalized Bluestein identity. Per-term bounds can be summed, or |x_j| summed instead of nX. This estimate assumes exact convolution arithmetic and the correct odd-period sign extension where applicable. Any output coefficient rescaling, intermediate round, truncated term, or normalization changes those hypotheses.

# Campaign phase schedule

The pinned transform_structural_manifest_20261111.json (SHA-256 a41d70db2bb439d73cc817f80b24cb598d3efa89cce1d19a5fa618abbe239637) assigns 125,400 conductors. Summing J+41+extra for each gives the counts below. One initial unit at j=0 removes one update per conductor. The maximum J is 84,200 at q=10004.

| Extra ticks | (q,j) rows | q-step updates | Unique ticks | Both gamma parities |
|---:|---:|---:|---:|---:|
| 0 | 1,528,006,797 | 1,527,881,397 | 84,241 | 168,482 |
| 167 | 1,548,948,597 | 1,548,823,197 | 84,408 | 168,816 |
| 320 | 1,568,134,797 | 1,568,009,397 | 84,561 | 169,122 |
| 640 | 1,608,262,797 | 1,608,137,397 | 84,881 | 169,762 |

For each q initialize the unit step exp(−5i log(q)/128). Cache the two parity factors Γ(g)/|Γ(g)| exp(−it log(π)/2) for each tick; equivalently exponentiate the imaginary component of a certified logarithm of Γ. The remaining q step raised to j gives the normalized conductor/gamma phase. The ratio to unnormalized G is positive for q>0 and Re(g)>0. A coordinate sign test on unscaled Γ will lose useful absolute precision at large heights. The branch of log Γ has no effect after exponentiation.

For a unit step with error δ≤2^(−P), Euclidean rounding ≤2^(−P), exact seed 1, j updates yield error ≤2j·2^(−P)(1+2^(−P))^j. For P≥p+21 and p≥1, j≤84880, this is <0.084·2^(−p); check that normalized gamma enclosure, multiplying both parities, final rounding, and static phase errors fit the sector gate independently. For example, using the same internal precision for a gamma phase with error ≤2^(−P) and each multiplication, the final error before p-grid rounding stays below 0.085·2^(−p). Final rounding contributes at most 2^(−p)/√2, giving <2^(−p) Euclidean error. A near-axis interval may straddle zero and must take a wider-precision or fallback path. No assertion about how often this happens follows from the schedule.

Per (q,j>0) allow one complex rotation and two parity products; the latter can share the q angle. Per q allow one certified logarithm/unit seed; per unique tick allow two certified gamma phases. The static phase merge can require up to 4,333,246,843 epsilon/postchirp products (sum of primitive counts). Existing Gauss roots, Bluestein chirps, and terminal checks may be reused only where their record keys and precision actually match. Static phase computation is distinct from proving gamma enclosures. Conditional base phase-table cost is 424.45 core-hours per millisecond for the entire bundle per (q,j), rising to 446.74 at extra 640. Static merge costs 1,203.68 core-hours per millisecond per character. These are sensitivity prices, with no claim of measured HOL throughput. Repeated output I/O, cold root/gamma certificates, widths, signed range fallbacks and archival costs require their own measurements or an explicit fusion contract.

