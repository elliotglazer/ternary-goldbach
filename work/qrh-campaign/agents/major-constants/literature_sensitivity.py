"""Exploratory floating-point comparisons, not certified error bounds."""
import json
import math

x = 4.9e26
N = 1e27
result = {
    "x": x,
    "log_x": math.log(x),
    "liu_fixed_constant_error_factor": x ** (0.874957019420098946 - 0.875),
    "xu_sang_fixed_constant_error_factor": x ** (0.8748867 - 0.875),
    "li_liu_unit_constant_bound_over_N_log10": 100 * math.log10(math.log(N)) - 0.5 * math.log10(N),
    "li_liu_unit_constant_bound_over_N_div_logN_log10": 101 * math.log10(math.log(N)) - 0.5 * math.log10(N),
    "liu_wang_threshold_log10": 3100 / math.log(10),
    "warning": "Fixed-constant exponent comparison only; constants in distinct theorems are not assumed equal."
}
print(json.dumps(result, indent=2))
