(* NON-AUTHORITATIVE EXPERIMENT. Insert inside the renamed Compute copy.
   No theorem construction. Unbuilt; equivalence has not been established. *)

type runner = cval list -> cval;

fun compile_expr lookup ce : runner =
  case ce of
    Const n => (fn _ => Num n)
  | Var n => (fn env => env_lookup n env)
  | Monop (m, x) =>
      let val cx = compile_expr lookup x
      in fn env => m (cx env) end
  | Binop (b, x, y) =>
      let val cx = compile_expr lookup x
          val cy = compile_expr lookup y
      in fn env =>
           let val bx = b (cx env)
               val vy = cy env
           in bx vy end
      end
  | App (f, xs) =>
      let val args = List.map (compile_expr lookup) xs
          fun eval_args env rest acc =
            case rest of
              [] => List.rev acc
            | c::cs => eval_args env cs (c env::acc)
      in fn env =>
           let val actuals = eval_args env args []
               val body = lookup f
           in body actuals end
      end
  | Let (x, y) =>
      let val cx = compile_expr lookup x
          val cy = compile_expr lookup y
      in fn env => cy (cx env::env) end
  | If (x, y, z) =>
      let val cx = compile_expr lookup x
          val cy = compile_expr lookup y
          val cz = compile_expr lookup z
      in fn env =>
           case cx env of
             Num n => if n = Arbnum.zero then cz env else cy env
           | _ => cz env
      end;

(* compile_expr never calls lookup during construction. All mutual recursion
   is linked before any returned runner can be invoked. The reference does
   not escape and is not written after publication. *)
fun prepare_closures (code : cexp vector) =
  let val table = ref (NONE : runner vector option)
      fun lookup f =
        case !table of
          NONE => raise Fail "unpublished compiled evaluator table"
        | SOME runners => get_code f runners
      val runners = Vector.map (compile_expr lookup) code
      val _ = table := SOME runners
  in compile_expr lookup end;

(* Both thunks consume exactly the supplied AST and environment. Construction
   is outside either thunk. This is a benchmark fixture, not a conversion. *)
fun prepare_cval_comparison code env ce =
  let val entry = prepare_closures code ce
  in {stock = fn () => exec code env ce,
      compiled = fn () => entry env}
  end;
