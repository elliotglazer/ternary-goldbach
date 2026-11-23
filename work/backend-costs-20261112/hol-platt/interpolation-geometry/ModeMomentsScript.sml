Theory ModeMoments
Ancestors MomentRates MomentTransfer WeightedSample intreal real integer arithmetic list
Libs realLib intLib
Definition weighted_powers_def:
 (weighted_powers ([]:(int # int) list) (k:num) = []) /\
 (weighted_powers ((z,x)::zs) k = (z*x**k,x)::weighted_powers zs k)
End
Definition cast_row_def:
 (cast_row ([]:(int # int) list) = []:(real # real) list) /\
 (cast_row ((z,x)::zs) = (real_of_int z, real_of_int x)::cast_row zs)
End
Theorem step_power:
 !zs k. step (weighted_powers zs k) = weighted_powers zs (SUC k)
Proof
 Induct >- simp [weighted_powers_def,step_def] >>
 Cases_on `h` >> simp [step_def,weighted_powers_def,int_exp,AC INT_MUL_ASSOC INT_MUL_COMM]
QED
Theorem initial_powers:
 !zs. weighted_powers zs 0 = zs
Proof
 Induct >- simp [weighted_powers_def] >>
 Cases_on `h` >> simp [weighted_powers_def,int_exp]
QED
Theorem cast_integer_pow:
 !k x. real_of_int(x ** k) = real_of_int x pow k
Proof
 Induct >> simp [int_exp,pow]
QED
Theorem row_monomial:
 !zs k. real_of_int(mass F (weighted_powers zs k)) = row (cast_row zs) (\x. x pow k)
Proof
 Induct >- simp [mass_def,weighted_powers_def,cast_row_def,row_def] >>
 Cases_on `h` >> simp [mass_def,weighted_powers_def,cast_row_def,row_def,cast_integer_pow]
QED
Theorem terminal_monomial:
 !zs k. real_of_int(mass T (weighted_powers zs k)) =
 absolute_row (cast_row zs) (\x. abs(x pow k))
Proof
 Induct >- simp [mass_def,weighted_powers_def,cast_row_def,absolute_row_def] >>
 Cases_on `h` >> simp [mass_def,weighted_powers_def,cast_row_def,absolute_row_def,
   GSYM cast_abs,ABS_MUL,cast_integer_pow]
QED


