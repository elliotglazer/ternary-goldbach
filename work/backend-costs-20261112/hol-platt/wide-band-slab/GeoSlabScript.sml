Theory GeoSlab
Ancestors list arithmetic integer cv_std
Libs cv_transLib intLib
Definition fromzig_def:
  fromzig (z:num) = if EVEN z then (&(z DIV 2):int) else -(&(z DIV 2))
End
Definition nextw_def:
  nextw (w:int) r v = if v=0 then 0 else (w*r+v/2)/v
End
val next_p_def=cv_trans_pre "next_p" nextw_def;
Theorem next_ok[cv_pre]:
  !w r v. next_p w r v
Proof
  simp[next_p_def]
QED
Definition dot_def:
  (dot ([]:int list) (w:int) r v = 0) /\
  (dot (x::xs) w r v = x*w + dot xs (nextw w r v) r v)
End
Definition comp0_def:
  comp0 (z:num) = z DIV 5192296858534827628530496329220096
End
Definition comp1_def:
  comp1 (z:num) = comp0 (z MOD (2 ** 232)) + (2 ** 120)*comp0 (z DIV (2 ** 232))
End
Definition comp2_def:
  comp2 (z:num) = comp1 (z MOD (2 ** 464)) + (2 ** 240)*comp1 (z DIV (2 ** 464))
End
Definition comp3_def:
  comp3 (z:num) = comp2 (z MOD (2 ** 928)) + (2 ** 480)*comp2 (z DIV (2 ** 928))
End
Definition comp4_def:
  comp4 (z:num) = comp3 (z MOD (2 ** 1856)) + (2 ** 960)*comp3 (z DIV (2 ** 1856))
End
Definition comp5_def:
  comp5 (z:num) = comp4 (z MOD (2 ** 3712)) + (2 ** 1920)*comp4 (z DIV (2 ** 3712))
End
Definition comp6_def:
  comp6 (z:num) = comp5 (z MOD (2 ** 7424)) + (2 ** 3840)*comp5 (z DIV (2 ** 7424))
End
Definition dispatch_def:
  dispatch (k:num) z = if k=4 then comp4 z else comp6 z
End
Definition outs_def:
  (outs k b v xs ([]:num list) = []:num list) /\
  (outs k (b:num) (v:num) xs (r::rs) =
    dispatch k (Num (&b + dot xs (&5192296858534827628530496329220096) (fromzig r) (&v))) ::
    outs k b v xs rs)
End
Definition ok_def:
  ok k b v xs rs ys <=> outs k b v (MAP fromzig xs) rs = ys
End
Definition decomp_def:
  decomp k xs ys <=> MAP (dispatch k) xs = ys
End
val _=cv_auto_trans ok_def;
val _=cv_auto_trans decomp_def;
Definition digest_def:
  (digest ([]:num list) acc = acc) /\
  (digest (x::xs) acc = digest xs ((acc*17+x) MOD 2305843009213693951))
End
Definition live_def:
  live k b v xs rs n <=>
    digest (outs k b v (MAP fromzig xs) rs) 0 = n
End
Definition rawlive_def:
  rawlive k xs n <=> digest (MAP (dispatch k) xs) 0 = n
End
val _=cv_auto_trans live_def;
val _=cv_auto_trans rawlive_def;
Definition pfx_def:
  (pfx 0 k b xs vs rss acc = acc:num) /\
  (pfx (SUC n) k b xs [] rss acc = acc) /\
  (pfx (SUC n) k b xs (v::vs) [] acc = acc) /\
  (pfx (SUC n) k b xs (v::vs) (rs::rss) acc =
    pfx n k b xs vs rss (digest (outs k b v xs rs) acc))
End
Definition resident_def:
  resident n k b cs vs rss expected <=>
    let seed=(SUM cs + b) MOD 2305843009213693951 in
    pfx n k b (MAP fromzig cs) vs rss seed = expected
End
val _=cv_auto_trans resident_def;

val clock=Timer.startCPUTimer();
fun cpu()=let val {usr,sys}=Timer.checkCPUTimer clock in Time.toReal(Time.+(usr,sys)) end;
val io=TextIO.openIn "geometry.txt";
fun tokens()=case TextIO.inputLine io of SOME s=>String.tokens Char.isSpace s | NONE=>raise Fail "eof";
fun nn s=numSyntax.mk_numeral(Arbnum.fromString s);
fun zig s=let val neg=String.isPrefix "-" s
              val z=Arbnum.fromString(if neg then String.extract(s,1,NONE) else s)
              val m=Arbnum.+(Arbnum.+(z,z),Arbnum.fromInt(if neg then 1 else 0))
          in numSyntax.mk_numeral m end;
fun nl f row=listSyntax.mk_list(map f row,numSyntax.num);
val templates=ref ([]:(int * (term list * thm)) list);
fun encodeBase tm = if type_of(rand tm) <> ``:num list`` then EVAL tm else
  let val (f,xs)=dest_comb tm val (items,ty)=listSyntax.dest_list xs
      val (vs,pat)=case List.find(fn (n,_)=>n=length items) (!templates) of SOME(_,p)=>p
        | NONE=>let val vs=List.tabulate(length items,fn j=>mk_var("slot"^Int.toString j,ty))
                    val pat=EVAL(mk_comb(f,listSyntax.mk_list(vs,ty)))
                    val _=templates:=(length items,(vs,pat))::(!templates)
                in (vs,pat) end
  in INST(ListPair.map(fn(v,a)=>v |-> a)(vs,items)) pat end;
val geom=ref ([]:term list);
val encs=ref ([]:(term * thm) list);
val reuse=ref false;
val hits=ref 0;
fun encode tm =
  if !reuse andalso List.exists (fn v=>aconv (rand tm) v) (!geom) then
    case List.find (fn (a,_)=>aconv a tm) (!encs) of
      SOME (_,th)=>(hits:=(!hits)+1;th)
    | NONE=>let val th=encodeBase tm in encs:=(tm,th)::(!encs);th end
  else encodeBase tm;
fun stage label tm = let val start=cpu()
  val (f,args)=strip_comb tm
  fun fresh a j=mk_var("argument"^Int.toString j,type_of a)
  fun vars aa=ListPair.map (fn(a,j)=>fresh a j)(aa,List.tabulate(length aa,fn j=>j))
  val vs=vars args
  val rep=cv_repLib.cv_rep_for [] (list_mk_comb(f,vs))
  val ft=cv_typeLib.from_to_thm_for(type_of tm)
  val ctx=UNDISCH_ALL(MATCH_MP(MATCH_MP cv_repTheory.cv_rep_eval rep) ft)
  val concrete=INST(ListPair.map(fn(v,a)=>v |-> a)(vs,args)) ctx
  fun goargs 0=ALL_CONV | goargs n=RATOR_CONV(goargs(n-1)) THENC RAND_CONV encode
  val base=CONV_RULE(RAND_CONV (RAND_CONV (goargs(length args)))) concrete
  val (cvf,cvargs)=strip_comb(rand(rhs(concl base)))
  val conv=cv_computeLib.cv_compute(cv_eqs_for(list_mk_comb(cvf,vars cvargs)))
  val _=print("SETUP "^label^" "^Real.toString(cpu()-start)^"\n")
  fun run i=let val t=cpu()
    val raw=CONV_RULE(RAND_CONV(RAND_CONV conv)) base
    val b=cpu() val dec=CONV_RULE(RAND_CONV EVAL) raw
    val th=List.foldl(fn(h,t)=>PROVE_HYP(prove(h,SIMP_TAC(srw_ss()) [])) t) dec (hyp dec)
    val (oracles,axs)=Tag.dest_tag(tag th)
    val _=if null(hyp th) andalso null axs andalso List.all(fn s=>s="DISK_THM")oracles
          andalso aconv(lhs(concl th)) tm andalso aconv(rhs(concl th)) T then () else raise Fail label
    in print("SLAB "^label^" "^Int.toString i^" "^Real.toString(b-t)^" "^Real.toString(cpu()-b)^"\n") end
  in run end;

fun group()=let val t=cpu()
  val [ng]=tokens()
  val groups=List.tabulate(valOf(Int.fromString ng),fn _=>tokens())
  val vs=nl nn (map hd groups)
  val rss=listSyntax.mk_list(map (fn s=>nl zig (tl s)) groups,``:num list``)
  val _=geom:=[vs,rss] val _=encs:=[]
  val _=print("GEOMLOAD "^ng^" "^Real.toString(cpu()-t)^"\n")
  fun height order=let val a=cpu()
    val [tag,k,b,n,count,expected]=tokens()
    val cs=nl zig (tokens())
    val tm=list_mk_comb(``resident``,[nn n,nn k,nn b,cs,vs,rss,nn expected])
    val _=print("COEFFLOAD "^tag^" "^Real.toString(cpu()-a)^"\n")
    fun trial i on=let val _=reuse:=on val _=hits:=0
      val name=tag^"_"^(if on then "reuse" else "plain")^Int.toString i
      val eval=stage name tm
      val _=eval i
      val _=if not on orelse (!hits=2 orelse (order=1 andalso i=1 andalso !hits=0)) then ()
            else raise Fail "geometry cache did not hit both checked conversions"
      in print("HITS "^name^" "^Int.toString(!hits)^"\n") end
    in List.app(fn i=>List.app(trial i)(if i mod 2=0 then [true,false] else [false,true]))[1,2,3] end
  in height 1; height 2 end;
val _=List.app(fn _=>group())[1,2,3,4,5];
val _=print "GEOMETRY_DONE\n";
