structure panel = struct
open HolKernel Parse boolLib bossLib cv_transLib meter;
fun run batched = let
 val start=cpu()
 val ins=TextIO.openIn "../../../backend-costs-20261112/hol-platt/guard-repricing/strip-repair-packets-stress.tsv"
 fun read acc=case TextIO.inputLine ins of NONE=>rev acc | SOME s =>read(String.tokens Char.isSpace s::acc)
 val rows=read []
 val _=TextIO.closeIn ins
 val keyset=List.foldl(fn(row,s)=>HOLset.add(s,String.concatWith "/" (List.take(row,3))))(HOLset.empty String.compare)rows
 val _=if length rows=270 andalso HOLset.numItems keyset=270 then () else raise Fail "keys"
 val _=print("READ "^Real.toString(cpu()-start)^"\n")
 val t=cpu()
 val terms=map short.ints rows
 val _=print("TERMS "^Real.toString(cpu()-t)^"\n")
 fun check(i,rs)=let
   val n=Int.toString i
   val rd=short.named ("tsv_"^n) (short.matrix rs)
   in short.prove ("proved_"^n) ``PanelKernel$panels`` [] [rd] end
 val _=if batched then [check(0,terms)] else ListPair.map(fn(i,row)=>check(i,[row]))(List.tabulate(length terms,fn i=>i),terms)
 in print("ACTUAL_12_NODE_ROWS "^Int.toString(length rows)^"\n") end;
end;
