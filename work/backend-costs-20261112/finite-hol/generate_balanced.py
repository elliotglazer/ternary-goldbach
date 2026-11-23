"""Change only witness-definition layout, preserving the checked theorem."""
from pathlib import Path
H=Path(__file__).resolve().parent
source=(H/'coverbench.sml').read_text()
start=source.index('val raw_ws =')
end=source.index('val target_tm=',start)
replacement='''val serial = ref 0;
fun define_witnesses ps =
  let val rhs = if length ps <= 32 then
        listSyntax.mk_list
          (map(fn(p,q)=>pairSyntax.mk_pair(numeral p,numeral q)) ps,
           pairSyntax.mk_prod(numSyntax.num,numSyntax.num))
      else let val middle=length ps div 2
               val left=define_witnesses(List.take(ps,middle))
               val right=define_witnesses(List.drop(ps,middle))
           in ``^left ++ ^right`` end
      val id = !serial
      val _ = serial := id+1
      val name="cert_witnesses_" ^ Int.toString id
      val def=new_definition(name^"_def",mk_eq(mk_var(name,type_of rhs),rhs))
      val _=cv_transLib.cv_trans def
  in lhs(concl def) end;
val ws = timed "input_translation" (fn()=>
  (cv_transLib.cv_trans tree_def;define_witnesses witnesses));
'''
out=source[:start]+replacement+source[end:]
(H/'coverbench_balanced.sml').write_text(out,encoding='utf-8',newline='\n')
print('Generated balanced witness definitions; acceptance and audit code unchanged.')
