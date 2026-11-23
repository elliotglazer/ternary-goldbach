Theory RetainedTransfer
Ancestors HardyRepair WeightedSample real
Libs realLib intLib
Definition nodes_def:
 (nodes 0 j (f:num->'a) = []) /\
 (nodes (SUC n) j f=f j::nodes n (SUC j) f)
End
Theorem length_nodes[simp]:
 !n j f. LENGTH (nodes n j f) = n
Proof
 Induct >> simp[nodes_def]
QED
Theorem successful_reads:
 !ws tab j a c z v. GridSigns$dot_window tab j ws a c=SOME(z,v) ==>
 ?ps. LENGTH ps=LENGTH ws /\ WindowPerturbation$reads tab j ps
Proof
 Induct >> rpt gen_tac
 >- (strip_tac >> qexists_tac `[]` >> simp[WindowPerturbationTheory.reads_def]) >>
 simp[GridSignsTheory.dot_window_def] >> CASE_TAC >> simp[] >>
 PairCases_on `x` >> simp[] >> strip_tac >>
 first_x_assum drule >> strip_tac >>
 qexists_tac `(x0,x1)::ps` >> simp[WindowPerturbationTheory.reads_def]
QED
Definition retained_def:
 retained tab raw vs <=>
 !i p. sptree$lookup i tab=SOME p ==>
 Enclosure$encloses (raw i) p /\ abs(vs i-real_of_int(WindowPerturbation$raw_center(raw i)))<=2
End
Theorem lifted_reads:
 !ps tab j raw vs. retained tab raw vs /\ WindowPerturbation$reads tab j ps ==>
 LIST_REL Enclosure$encloses (nodes (LENGTH ps) j raw) ps /\
 LIST_REL (\v z. abs(v-real_of_int z)<=2) (nodes (LENGTH ps) j vs)
     (MAP WindowPerturbation$raw_center (nodes (LENGTH ps) j raw))
Proof
 Induct >> simp[nodes_def,WindowPerturbationTheory.reads_def] >>
 rpt gen_tac >> strip_tac >> res_tac >> fs[retained_def] >> metis_tac[]
QED
Theorem sign_has_support:
 !tab ks t k r off den err ws.
 sptree$lookup k ks=SOME(r,off,den,err,ws) /\ GridSigns$at_repair tab ks t k <> 0 ==>
 ?ps. LENGTH ps=LENGTH ws /\ WindowPerturbation$reads tab (129+t DIV 4096-r DIV 2) ps
Proof
 rpt gen_tac >> strip_tac >>
 Cases_on `GridSigns$dot_window tab (129+t DIV 4096-r DIV 2) ws 0 0`
 >- (fs[GridSignsTheory.at_repair_def,LET_THM] >> gvs[AllCaseEqs()]) >>
 PairCases_on `x` >> metis_tac[successful_reads]
QED
Theorem chain_bounds:
 !x y z a b c:real. abs(x-y)<=a /\ abs(y-z)<=b /\ a+b<=c ==> abs(x-z)<=c
Proof
 rpt gen_tac >> simp[ABS_BOUNDS] >> realLib.REAL_ARITH_TAC
QED
fun showg (g as (a,t))=(List.app(fn x=>print("ASSUM "^term_to_string x^"\n"))a;print("GOAL "^term_to_string t^"\n");ALL_TAC g);
fun print_step s g=(print("TRANSFER_STEP "^s^"\n"); ALL_TAC g);
Theorem compressed_analytic_sign:
 !tab ks t k r off den err ws raw vs hardy j R.
 sptree$lookup k ks=SOME(r,off,den,err,ws) /\
 KernelWeights$kernel_ok r off (&den) ws /\
 retained tab raw vs /\ j=129+t DIV 4096-r DIV 2 /\
 abs(&(den*2**220)*hardy t-WeightedSample$weighted ws (nodes (LENGTH ws) j vs))<=R /\
 R+10* &den <= &(den*err) ==>
 (GridSigns$at_repair tab ks t k=2 ==> 0<hardy t) /\
 (GridSigns$at_repair tab ks t k=1 ==> hardy t<0)
Proof
 rpt gen_tac >> strip_tac >>
 Cases_on `GridSigns$at_repair tab ks t k=0` >- simp[] >>
 `?ps. LENGTH ps=LENGTH ws /\ WindowPerturbation$reads tab j ps`
 by metis_tac[sign_has_support] >>
 print_step "support" >>
 `LIST_REL Enclosure$encloses (nodes (LENGTH ws) j raw) ps /\
  LIST_REL (\v z. abs(v-real_of_int z)<=2) (nodes (LENGTH ws) j vs)
      (MAP WindowPerturbation$raw_center (nodes (LENGTH ws) j raw))`
 by metis_tac[lifted_reads] >>
 print_step "lift" >>
 `abs(WeightedSample$weighted ws (nodes (LENGTH ws) j vs) -
 real_of_int(StencilReceipt$dot ws (MAP WindowPerturbation$raw_center (nodes (LENGTH ws) j raw)))) <= 10 * &den`
 by (MATCH_MP_TAC (Q.SPECL [`r`,`off`,`den`,`ws`,`nodes (LENGTH ws) j vs`,`MAP WindowPerturbation$raw_center (nodes (LENGTH ws) j raw)`] WeightedSampleTheory.certified_coarse_samples) >> simp[]) >>
 print_step "weighted" >>
 `abs(&(den*2**220)*hardy t-real_of_int(StencilReceipt$dot ws (MAP WindowPerturbation$raw_center (nodes (LENGTH ws) j raw)))) <= &(den*err)`
 by metis_tac[chain_bounds] >>
 print_step "radius" >>
 MATCH_MP_TAC (Q.SPECL [`tab`,`ks`,`t`,`k`,`r`,`off`,`den`,`err`,`ws`,`ps`,`nodes (LENGTH (ws:int list)) j (raw:num->num)`,`hardy`] HardyRepairTheory.repair_real_sign) >> rpt conj_tac >> TRY (first_assum ACCEPT_TAC) >> TRY (qpat_x_assum `LENGTH ps = LENGTH ws` (ACCEPT_TAC o SYM)) >> TRY (qpat_x_assum `j = _` (fn eq => PURE_REWRITE_TAC [GSYM eq]) >> first_assum ACCEPT_TAC) >> showg
QED






