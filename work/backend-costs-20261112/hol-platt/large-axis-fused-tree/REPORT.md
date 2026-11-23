# Large-character last axes and a whole-transform comparison

The +640 schedule has 39,241,839,619,586 retained primitive outputs. Reading the last axis in the frozen physical order gives 38,663,206,948,326 eligible for the large cyclic Bluestein postchirp (98.53%). Every one of these final axes has even length. This includes 122,954,371,578 outputs from large power-of-two axes since the selected cost fold uses the cyclic circuit for every axis of length at least 32. The other 578,632,671,260 outputs come from the short direct DFT, including 64,836,951,755 with power-of-two length. No last axis is an identity. Moving a long axis to the end wherever available could reach 38,999,326,085,670 outputs but would change earlier pruning and cost.

Across the 92,554,583,306 actual long last-axis slices, the ordinary spectrum has 38,776,754,304,088 values before removing 113,547,355,762 imprimitive modes. The short final axis takes 4,173,489,020 eight-height packets. Its 579,194,553,232 retained-mode slots include 561,881,972 padding slots. terminal.py uses the manifest order in guard-repricing/price_axes.py. padding.py reads the same height band boundaries. Both JSON outputs give results for all four guard lengths.

The stock HOL4 pilot prices the entire cyclic transform at p24. It fuses prechirp rotation with the first balanced packing level and postchirp rotation with the unpacking tree, and uses four ordinary products for each scalar complex rotation. Packed convolutions retain the original three wide products. Each alternative checks the same checksum and four numerical centers as the original. The two methods use identical root seeds, input generator, capacities and dimensions.

| Axis length | Fused/original CPU after zero-repeat controls |
|---:|---:|
| 32 | 1.328 |
| 100 | 0.947 |
| 232 | 0.987 |
| 462 | 0.939 |
| 1,152 | 0.849 |
| 2,956 | 0.963 |
| 5,526 | 1.078 |

The second run used three positive trials per mode, with 48 transform repetitions per trial below length 500 and eight at larger lengths. The two zero-repeat controls bracketed the positive trials. The 1,152-point shape also showed a ratio of 0.850 on the shorter first run. The mixed results do not justify a campaign-wide discount. Each measurement includes the entire postchirp, so it cannot also credit a separate terminal postchirp replacement. Repeated.json and v02.log give the raw and derived results.
