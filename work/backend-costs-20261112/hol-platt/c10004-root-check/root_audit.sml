open HolKernel Parse boolLib bossLib RootBinsTheory RootRowsTheory;
val allowed = ["bool.BOOL_CASES_AX","bool.ETA_AX","bool.SELECT_AX","bool.INFINITY_AX"];
fun req b = if b then () else raise Fail "root theorem audit";
fun check (name,th,expected) =
  let val (os,_) = Tag.dest_tag (tag th)
  in req (null (hyp th) andalso aconv (concl th) expected andalso
          List.all (fn x => x="DISK_THM") os);
     print (name ^ " oracles=" ^ String.concatWith ";" os ^ " " ^ Parse.thm_to_string th ^ "\n") end;
val _ = List.app (fn thy => List.app (fn (ax,_) =>
  req (List.exists (fn a => a=thy^"."^ax) allowed)) (DB.axioms thy))
  ("RootRows"::Theory.ancestry "RootRows");
val _ = check ("checked_centers",checked_centers,
  ``LENGTH centers = 29 /\ bins centers``);
val _ = check ("bad_controls",bad_controls,
  ``~bins (REVERSE centers) /\ ~bins ([2414538057589098062288674;2404606394965568644465104;2388083873355579785397988;2365015779842398068798910;2335465342466899605490583;2299513556923904919222126;2257258964558609385331670;2208817382271605575144981;2154321585072809065792412;2093920942154385339393396;2027781007480176582717122;1956083066013794310681501;1879023636829135070510865;1796813934465258764642714;1709679290002018430137083;1617858533443232932823586;1521603339100247369812173;1421177535770139339473510;1316856383599324666577970;1208925819614629174706176;1097681673989773395710702;983428859195429304991594;866480534255332415585815;747157246399165135975325;625786052464881175353500;502699622458646154579412;378235327729474314820805;252734316257811264463481;126540577592632483075291]:int list)``);
val _ = check ("checked_rows",checked_rows,``MAP FST rows = [2;3;5;10;15;20;30;40;60] /\ EVERY rowok rows``);
val _ = print "ROOT_AUDIT_PASS\n";



