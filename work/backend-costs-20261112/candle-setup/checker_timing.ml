let bench_mark label =
  let a = Bytes.create (String.length label + 1) in
  let _ = Bytes.blit_string label 0 a 0 (String.length label) in
  Cake.Runtime.customFFI "bench_time" a;;
let rec repeat_compute n tm =
  if n = 0 then () else
  let th = compute zdefs tm in
  let _ = if rand (concl th) = `numc 1` then () else failwith "checker rejected" in
  repeat_compute (n-1) tm;;
print_string "CHECKER_DEFINITIONS_DONE\n";;
