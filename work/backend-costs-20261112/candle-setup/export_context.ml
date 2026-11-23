#use "../bootstrap_sound.ml";;
print_string "CHECKER_CONTEXT_EXPORT_START\n";;
bench_mark "context_export_start";;
Kernel.print_thm TRUTH;;
bench_mark "context_export_end";;
print_string "CHECKER_CONTEXT_EXPORT_DONE\n";;
