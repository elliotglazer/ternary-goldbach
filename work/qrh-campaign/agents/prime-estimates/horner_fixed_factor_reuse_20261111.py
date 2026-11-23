"""Bit-width and declared PA-template counts only; no arithmetic outputs."""
from pathlib import Path
import json
checks=0
def ck(x):
 global checks
 checks+=1
 assert x
def row(factor_bits,input_bits):
 n=(input_bits+7)//8
 small=(factor_bits+7)//8
 leading=input_bits-8*(n-1)
 widths=[(factor_bits+leading+8*(j-1)+7)//8 for j in range(1,n+1)]
 adds=[2*w+1 for w in widths[1:]]
 direct=5*n*small+2*small+1
 reverse=5*n*small+2*n+1
 table=n+(n-1)+sum(adds)
 setup_digits=(factor_bits+8+7)//8
 setup=255*(2*setup_digits+1+2)+4
 ck(n==15 and small==3)
 ck(widths==list(range(3,18)))
 ck(direct==232 and reverse==256 and table==337 and setup==2809)
 ck(table>direct and setup>0)
 return dict(factor_bits=factor_bits,input_bits=input_bits,
  factor_digits=small,input_digits=n,leading_input_bits=leading,
  prefix_product_digits=widths,prefix_adder_events=adds,
  direct_narrow_outer_rows=direct,direct_reverse_orientation=reverse,
  table_growing_prefix=table,table_setup=setup,
  table_lookups=n,prefix_fusions=n-1,
  direct_cell_product_events=n*small,
  direct_cell_adder_events=3*n*small,
  direct_cell_bridge_events=n*small,
  direct_outer_bridge_events=2*small+1)
rows=[row(18,117),row(20,115)]
direct=2*19*sum(r['direct_narrow_outer_rows'] for r in rows)
table=2*19*sum(r['table_growing_prefix'] for r in rows)
ck(direct==17632 and table==25612 and table-direct==7980)
ck(265800//2<2**18 and 2*265800<2**20)
ck((18+117+7)//8==17 and (20+115+7)//8==17)
ck(sum(rows[0]['prefix_adder_events'])==308)
ck(45+135+45+7==232)
out=dict(status='PASS_WIDTH_AND_MATCHED_TEMPLATE_METADATA',checks=checks,
 rows=rows,degree19_complex_product_subtotal=dict(direct=direct,table=table,
  table_excess_before_setup=table-direct,first_two_factor_setup=5618),
 scope='No tables, coefficients, quotient values, functions, builds or timings; model only.')
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf8')
print(json.dumps(dict(status=out['status'],checks=checks)))
