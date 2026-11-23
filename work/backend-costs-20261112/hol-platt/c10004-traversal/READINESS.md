# Sequential traversal proof stage

This isolated module copies the original ft_* program definitions from the preserved fast-traversal candidate. Its inner arithmetic programs and guards remain unchanged. It adds universal list contracts for pair grouping, simultaneous take/drop, rectangular chunks, column extraction, transpose and concatenation. These are intended as the bridge to the exact original selected tensor; they do not themselves establish its final refinement or analytic correctness.

No CV translations or timing claims are added in this base stage. The next module must prove LENGTH xs = 4800 implies ft_tensor cache xs = SOME (tx_tensor_selected cache xs), and unconditional equality of ft_checked with tx_checked. Only then may matched reference/traversal diagnostic timings support an implementation choice. Actual source, roots, analytic bounds and complete zero counts remain separate obligations.

The original candidate remains unchanged. The accepted reference source hash is 4F9FE96C14463DC6BD56F2F3E80C68D2865C4ACD003CF6BC9EF569264B772346. The original candidate hash is 5602C69E6E0C3B04EF7F07B8F033DD043ECB79AA9C1262AF465A45354D60BF8E.

Before the first build, the chunk recursion variable count was renamed rowCount to avoid collision with the imported count constant. This changes only the bound variable name. Natural numeral preference is explicit.
