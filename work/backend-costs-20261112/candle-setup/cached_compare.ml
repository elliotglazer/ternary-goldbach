(* The wrapper in candle/compute.ml rewrites the equations on EVERY call.
   Prepare those exact theorems once; no kernel behavior is changed. *)
let prepared_defs =
  let _ = bench_mark "prepare_start" in
  let ds = map (REWRITE_RULE [LET_END_DEF]) zdefs in
  let _ = bench_mark "prepare_end" in ds;;
let rec repeat_kernel n tm =
  if n = 0 then () else
  let th = Kernel.compute (COMPUTE_INIT_THMS,prepared_defs) tm in
  let _ = if rand (concl th) = `numc 1` then () else failwith "cached checker rejected" in
  repeat_kernel (n-1) tm;;
let _ = bench_mark "cached1_start"; repeat_kernel 100 fixture; bench_mark "cached1_end";;
let _ = bench_mark "cached2_start"; repeat_kernel 100 fixture; bench_mark "cached2_end";;
let _ = bench_mark "cached3_start"; repeat_kernel 100 fixture; bench_mark "cached3_end";;
let _ = bench_mark "constant_prepared_start"; repeat_kernel 100 `numc 1`;
        bench_mark "constant_prepared_end";;
let _ = bench_mark "constant_wrapper_start"; repeat_compute 100 `numc 1`;
        bench_mark "constant_wrapper_end";;
check_axioms ();;
print_string "CACHED_COMPARE_DONE\n";;
