# Independent review of unit-root projection through p80

2026-11-11. Root reviewed the complete corollary and its fixed-check source. The conditional paper claim passes. This is not a compiled theorem, a root certificate, or admission of a lower-precision transform.

The reviewed author paper is `agents/zero-sum/SHARED_UNIT_ROOT_PROJECTION_P80_COROLLARY_2026-11-11.md`, SHA256 `EA55F84EE4B085A12C2FABDC3B012AC376651ED2C3B3110C6B49592A17BFF9F9`. Its source and receipt hashes are `201665CE4F2AE4C75CF0FD720A109073A3687FD8E5EBC0A43C3A99544034764C` and `6D945B0E72D1AA18CC1C373D2E7560CD2F956F1DF85824681C84E9F95CE755A6`. Root verified all three hashes and the five predecessor pins in that receipt. Paths prefixed by agents are relative to work/qrh-campaign.

The mathematical premise is a specified exact unit and a grid110 center with complex-norm error at most 2^-110. Coordinate nearest rounding changes the complex center by at most sqrt(1/2)*2^-p, strictly less than (3/4)*2^-p. For every p from 80 through 108, the high error is at most (1/4)*2^-p. The strict total bound follows. No statement about two independent coordinate radii substitutes for the complex-norm premise.

For k=110-p, ties toward positive infinity give the exact integer identity A=q*2^k+r, with 0<=r<2^k, followed by M=q+[2r>=2^k]. Hence R=A-M*2^k lies in the half-open interval [-2^(k-1),2^(k-1)). This handles negative coordinates and ties. The equivalent signed residual check is valid. The argument does not commute rounding with negation or conjugation.

The candidate range |M|<=2^p must be established before using it to bound raw witness arithmetic. With |A|<=2^110+1, raw |A-M*2^k| is at most 2^111+1 and its double at most 2^112+2. Their sufficient signed capacities are 113 and 114 bits. Accepted residuals need k+1 signed bits, whereas doubled accepted residuals need k+2. The floor route has |q|<=2^p+1 and |q|*2^k+r<2^111. No small accepted residual is used to size an unchecked raw subtraction.

Root independently reconstructed these fixed inequalities and receipt widths for all 29 p labels, without importing or rerunning the author program. The three artifact pins, five source pins, 29 rows and the reported 359 author checks matched. This is fixed scalar evidence, not enumeration of any unit identity, root, conductor or workload.

The existing 15-byte raw macro capacity accommodates the extended range. Its split, signed bridges, exact folds, ranges and bindings remain charged. Low cached sums must be formed from the actual low centers. Root accepts the symbolic demand bound |I|<=J<=29|I|, with actual identities and lifetimes unknown. No setup saving follows without those data and full producer costs. Completion phases and nonunit Bluestein kernels remain separate.

DRAFT_ANCHORS: none created; repository-wide state not audited.
UNREGISTERED_SORRIES: none introduced; repository-wide state not audited.
DRAFT_IMPORT_VIOLATIONS: no imports changed; repository-wide state not audited.
SEALED_THIS_TURN: 0.
