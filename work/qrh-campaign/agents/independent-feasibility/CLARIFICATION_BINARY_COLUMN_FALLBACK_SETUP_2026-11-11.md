# Direct fallback setup in the binary-column comparison

2026-11-11. This narrow companion binds `FINITE_BINARY_INCIDENCE_COLUMN_RECOMMENDATION_2026-11-11.md`, SHA256 `58551C27EEB2D8E80F9F5762B00D6406CA5723F14C2868391C84C102FB464B37`. Its frozen bytes remain unchanged.

Section 4, equation (9), must expose the direct setup retained by fallback instances. Let `S_dir,new` be all direct-route setup/import/cache costs still required by the proposed portfolio, and `S_dir,old` those required by the all-direct comparator. The complete cold inequality is

    C0 + S_trans + S_dir,new
       + sum selected Col_i + sum fallback Direct_i
      < S_dir,old + sum all Direct_i.

If the fallback needs the same complete direct cache, `S_dir,new=S_dir,old` and those terms cancel; the left side does not receive a setup refund. If no direct instance remains, the new setup may be zero only when no other consumer needs it. Partial caches, shared imports, parallel copies and lifetimes receive their actual separate costs. Source/anchor costs cancel only when genuinely common; any difference is charged to the corresponding side. Equation (9)'s phrase “all differential source/anchor/transport costs included” must not be used to omit direct fallback setup.

The already-compiled row/witness comparison (8), Boolean equivalence, dimension example and fixed-check receipt are unchanged. This is an accounting correction, with no new arithmetic execution, inventory, values, builds or proof emission. Review should bind the original report and this companion together.
