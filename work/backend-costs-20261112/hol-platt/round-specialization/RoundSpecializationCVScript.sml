(* Total natural-DIV implementation.  Mathematical equivalence to signed
   division still requires a positive denominator in RoundSpecialization.
   round02 confirmed that CV generates no translation precondition here. *)
Theory RoundSpecializationCV
Ancestors RoundSpecialization integer
Libs intLib cv_transLib

val _ = intLib.prefer_int ();

val _ = cv_trans positive_den_div_one_def;
val _ = cv_trans round_scaled_one_def;
val _ = cv_trans rounded_butterfly_one_def;
