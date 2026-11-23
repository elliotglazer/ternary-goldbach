# Direct real-theory import

The staged dependency build completed all fifteen missing standard theories and stopped before the first helper proof at the unbound SML name ABS_BOUNDS. That theorem belongs to realTheory. The isolated successor adds real as a direct ancestor, already present transitively through complex. No definitions, statements or proof bodies changed. The original source, failed run, and all 142 staged object files remain preserved. Subsequent construction mounts that stage read-only and builds only this local helper.

The dependency attempt used 195.85 user plus 38.77 system CPU seconds and 477.88 wall seconds, with 991468 KiB peak RSS. It is a failed full-target build with successful library construction. Its source/log preservation checks passed, and all 142 recorded output pins were independently rehashed. No helper theorem is accepted from that run.
