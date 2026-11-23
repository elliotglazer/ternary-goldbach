(* Differential tests only. This module cannot construct a theorem. *)
structure CompiledEvalChecks =
struct
structure C = CompiledComputeBenchmark;
open C;
fun require b text = if b then () else raise Fail text;
fun num i = Num (Arbnum.fromInt i);
fun lit i = Const (Arbnum.fromInt i);
fun pair x y = Binop (binop MkPair,x,y);
val checks = ref 0;
exception Signal of string;
datatype outcome = Value of cval | Raised of string;
fun observe run = Value (run ()) handle
    HOL_ERR {origin_structure,origin_function,message} =>
      Raised (origin_structure ^ ":" ^ origin_function ^ ":" ^ message)
  | Signal s => Raised ("signal:" ^ s);
(* Fail, Match, Subscript, Interrupt and resource failures are not a pass. *)
fun compare label code env ce expected =
  let val p = prepare_cval_comparison code env ce
      val a = observe (#stock p)
      val b = observe (#compiled p)
      val _ = require (a = b andalso a = expected) ("semantic test: " ^ label)
  in checks := !checks + 1 end;
val empty = Vector.fromList [] : cexp vector;
val log = ref ([] : string list);
fun record s = log := s :: !log;
fun tap s ce = Monop ((fn x => (record s; x)), ce);
fun boom s = Monop ((fn _ => raise Signal s),lit 0);
fun traced label code ce expected expectedLog =
  let val _ = log := []
      val p = prepare_cval_comparison code [] ce
      val _ = require (null (!log)) ("compile-time effect: " ^ label)
      val a = observe (#stock p)
      val la = List.rev (!log)
      val _ = log := []
      val b = observe (#compiled p)
      val lb = List.rev (!log)
      val _ = require (a = expected andalso b = expected andalso
                       la = expectedLog andalso lb = expectedLog)
                      ("evaluation order: " ^ label)
  in checks := !checks + 1 end;
fun run () =
  let
    val _ = checks := 0
    val _ = compare "const" empty [] (lit 9) (Value (num 9))
    val _ = compare "var0" empty [num 2,num 3] (Var 0) (Value (num 2))
    val _ = compare "var1" empty [num 2,num 3] (Var 1) (Value (num 3))
    val _ = compare "negative-var" empty [num 2] (Var (~1)) (Value (num 2))
    val badEnv = Raised "Thm:compute.env_lookup:Impossible: out of bounds access"
    val badCode = Raised "Thm:compute.get_code:Impossible: out of bounds access"
    val _ = compare "empty-env" empty [] (Var 0) badEnv
    val _ = compare "past-env" empty [num 1] (Var 1) badEnv
    val _ = compare "bad-code" empty [] (App (0,[])) badCode
    val _ = compare "negative-code" empty [] (App (~1,[])) badCode
    val _ = compare "let-shadow" empty []
       (Let (lit 7,Let (lit 8,pair (Var 0) (Var 1))))
       (Value (Pair (num 8,num 7)))
    val _ = compare "if-zero" empty [] (If (lit 0,boom "dead",lit 3)) (Value (num 3))
    val _ = compare "if-nonzero" empty [] (If (lit 2,lit 3,boom "dead")) (Value (num 3))
    val _ = compare "if-pair" empty [] (If (pair (lit 1) (lit 2),boom "dead",lit 3))
       (Value (num 3))
    val _ = compare "dead-invalid-call" empty [] (If (lit 1,lit 3,App (999,[])))
       (Value (num 3))
    val sample = [num 0,num 1,num 5,Pair (num 2,num 3),Pair (Pair (num 0,num 1),num 4)]
    fun mono opn = List.app (fn x =>
      compare "unary-matrix" empty [x] (Monop (monop opn,Var 0))
        (Value (monop opn x))) sample
    val _ = List.app mono [Fst,Snd,IsPair]
    fun binary opn = List.app (fn x => List.app (fn y =>
      compare "binary-matrix" empty [x,y] (Binop (binop opn,Var 0,Var 1))
        (Value (binop opn x y))) sample) sample
    val _ = List.app binary [Add,Sub,Mul,Divide,Mod,Less,Eq,MkPair]
    val _ = compare "division-zero" empty [] (Binop (binop Divide,lit 5,lit 0))
       (Value (num 0))
    val _ = compare "mod-zero" empty [] (Binop (binop Mod,lit 5,lit 0))
       (Value (num 5))
    val _ = compare "saturating-sub" empty [] (Binop (binop Sub,lit 2,lit 5))
       (Value (num 0))
    val _ = compare "pair-to-num" empty [] (Binop (binop Add,pair (lit 8) (lit 9),lit 4))
       (Value (num 4))
    val _ = compare "pair-less" empty [] (Binop (binop Less,pair (lit 8) (lit 9),lit 4))
       (Value (num 0))
    val _ = compare "structural-eq" empty []
       (Binop (binop Eq,pair (lit 8) (lit 9),pair (lit 8) (lit 9))) (Value (num 1))
    val _ = compare "fst-nonpair" empty [] (Monop (monop Fst,lit 4)) (Value (num 0))
    fun ordered x = (record "b-left-applied"; fn y => (record "b-right-applied"; Pair (x,y)))
    val _ = traced "curried-binop" empty
      (Binop (ordered,tap "x" (lit 1),tap "y" (lit 2)))
      (Value (Pair (num 1,num 2))) ["x","b-left-applied","y","b-right-applied"]
    val _ = traced "curried-left-raises" empty
      (Binop ((fn _ => raise Signal "left-application"),tap "x" (lit 1),tap "y" (lit 2)))
      (Raised "signal:left-application") ["x"]
    val appCode = Vector.fromList [pair (Var 0) (Var 1)]
    val _ = traced "argument-order" appCode
      (App (0,[tap "arg0" (lit 3),tap "arg1" (lit 4)]))
      (Value (Pair (num 3,num 4))) ["arg0","arg1"]
    val _ = traced "arguments-before-bad-lookup" empty
      (App (99,[tap "arg0" (lit 3),tap "arg1" (lit 4)])) badCode ["arg0","arg1"]
    val _ = traced "arg-error-before-bad-lookup" empty
      (App (99,[tap "arg0" (lit 3),boom "argument",tap "never" (lit 4)]))
      (Raised "signal:argument") ["arg0"]
    val _ = traced "let-once" empty (Let (tap "bound" (lit 7),pair (Var 0) (Var 0)))
      (Value (Pair (num 7,num 7))) ["bound"]
    val _ = traced "if-lazy" empty
      (If (tap "condition" (lit 0),tap "never" (lit 8),tap "else" (lit 9)))
      (Value (num 9)) ["condition","else"]
    val sub1 = Binop (binop Sub,Var 0,lit 1)
    val recursive = Vector.fromList [If (Var 0,
      Binop (binop Add,Var 0,App (0,[sub1])),lit 0)]
    val _ = List.app (fn n => compare "recursive-sum" recursive [] (App (0,[lit n]))
      (Value (num (n*(n+1) div 2)))) [0,1,2,8,32,128]
    val mutual = Vector.fromList [If (Var 0,App (1,[sub1]),lit 1),
                                  If (Var 0,App (0,[sub1]),lit 0)]
    val _ = List.app (fn n => compare "mutual-parity" mutual [] (App (0,[lit n]))
      (Value (num (if n mod 2 = 0 then 1 else 0)))) [0,1,2,7,32,127,128]
    (* Bounded composition matrix, including every constructor inside recursion. *)
    val _ = List.app (fn n => compare "nested-composition" recursive []
      (Let (App (0,[lit n]),If (Monop (monop IsPair,Var 0),lit 99,
        Binop (binop Add,Var 0,lit 1)))) (Value (num (n*(n+1) div 2 + 1)))) [0,1,5,16]
  in print ("COMPILED_SEMANTICS_PASS," ^ Int.toString (!checks) ^ "\n") end;
end;
