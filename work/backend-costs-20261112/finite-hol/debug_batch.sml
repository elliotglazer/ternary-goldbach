top_goals();
e (completeInduct_on `p` >> rpt strip_tac);
e (Cases_on `p = 2`);
e (fs [PRIME_2]);
e (qpat_x_assum `node_valid tree p a fs` mp_tac >>
   asm_simp_tac (srw_ss()) [node_valid_def,exp_mod_binary_eqn] >> rpt strip_tac);
e (`EVERY prime fs` by (fs [EVERY_MEM] >> metis_tac [cert_contains_valid]));
e (metis_tac [prime_cert_check]);
top_goals();
