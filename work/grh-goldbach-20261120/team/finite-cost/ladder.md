# Joint cost of binary Goldbach and a prime ladder to 10^27

The cheapest binary cutoff depends on the end-to-end price of an accepted rung. The model keeps the shared prime table as a fixed expense at each block width. Shrinking the binary range reduces the number of coverage tiles and anchor sets. The ladder then needs more rungs to reach the same height.

| Assumed CPU ms per rung | Best binary cutoff (rounded) | Binary core-hours | Ladder core-hours | Combined core-hours |
| ---: | ---: | ---: | ---: | ---: |
| 0.1 | 1.59 × 10^15 | 26,862 | 17,558 | 44,420 |
| 1 | 5.75 × 10^15 | 66,278 | 48,316 | 114,595 |
| 10 | 1.98 × 10^16 | 174,792 | 140,012 | 314,804 |

| Chosen cutoff | Binary alone | With ladder at 0.1 ms | With ladder at 1 ms | With ladder at 10 ms |
| ---: | ---: | ---: | ---: | ---: |
| 2.51 × 10^15 | 37,111 h | 48,198 h | 147,974 h | 1,145,738 h |
| 10^16 | 101,966 h | 104,745 h | 129,756 h | 379,866 h |
| 1.1 × 10^16 | 110,370 h | 112,896 h | 135,632 h | 362,996 h |

The columns are conditional on a functioning production checker and coverage of every prime window. Rung throughput includes candidate generation, primality proof, ordinary interval checks, storage and assembly. Exceptional window repairs, including their frequency and cost, remain unmeasured. The analytic proof above 10^27 and GRH integration have separate costs.

For even binary cutoff B, a rung p covers odd targets from p+4 to p+B. Two successive rungs leave no uncovered odd target if their gap is at most B−2. Starting at 3 gives initial coverage through B+3. The Saouter-type layout uses F=2^30, windows of candidate indices t=0,…,2047, and spacing S=floor((B−2)/(2F))−2047. Rung i is a prime of the form (2(Si−t)+1)F+1. This bounds every gap by 2F(S+2047). The model reserves ceil(10^27/(2FS)) new rungs. The earlier alternative assumption of 20% extra rungs gives optima of 47,723, 123,781 and 341,500 hours for the same three rung prices.

The joint search compares the twelve power-of-two block widths in the binary model. For each width, relaxing the integer counts gives a lower bound of the form a·y+c+d/y, where y is the nominal rung spacing. It reaches its minimum at sqrt(d/a). The script checks nearby integer cutoffs and the nearest lattice, tile and block boundaries. Its selected cost differs from the smallest relaxed lower bound by under 0.1 core-hour, far below uncertainty in the throughput assumptions.

Run `python model.py` and `python -B ladder.py` in this directory. `ladder.json` records the exact candidate cutoffs, component costs, rung counts and relaxed lower bounds for both geometries.
