From Stdlib Require Import ZArith Bool List Lia.
Import ListNotations.
Open Scope Z_scope.

Record input := Inp { ur:Z; ui:Z; vr:Z; vi:Z; wr:Z; wi:Z }.
Record output := Out { pr:Z; pi:Z; mr:Z; mi:Z }.
Definition within (b x:Z) := (-b <=? x) && (x <=? b).
Definition input_ok (s b:Z) (x:input) :=
  within b (ur x) && within b (ui x) && within b (vr x) &&
  within b (vi x) && within s (wr x) && within s (wi x).
Definition output_ok (b:Z) (y:output) :=
  within (4*b) (pr y) && within (4*b) (pi y) &&
  within (4*b) (mr y) && within (4*b) (mi y).
Definition check_one (s b:Z) (x:input) (y:output) :=
  let t := wr x*(vr x+vi x) in
  let u := vi x*(wr x+wi x) in
  let v := vr x*(wi x-wr x) in
  let rr := t-u in
  let ii := t+v in
  input_ok s b x && output_ok b y &&
  within (4*b*s) t && within (4*b*s) u && within (4*b*s) v &&
  ((pr y+mr y =? 2*ur x) && (pi y+mi y =? 2*ui x) &&
   (-s <=? 2*(rr-(pr y-ur x)*s)) && (2*(rr-(pr y-ur x)*s) <? s) &&
   (-s <=? 2*(ii-(pi y-ui x)*s)) && (2*(ii-(pi y-ui x)*s) <? s)).

Fixpoint check_stage (s b:Z) (xs:list input) (ys:list output) :=
  match xs,ys with
  | [],[] => true
  | x::xt,y::yt => check_one s b x y && check_stage s b xt yt
  | _,_ => false
  end.

Definition butterfly_spec (s b:Z) (x:input) (y:output) : Prop :=
  input_ok s b x = true /\ output_ok b y = true /\
  (-s <= 2*(ur x*s+(vr x*wr x-vi x*wi x)-pr y*s) <= s) /\
  (-s <= 2*(ui x*s+(vr x*wi x+vi x*wr x)-pi y*s) <= s) /\
  (-s <= 2*(ur x*s-(vr x*wr x-vi x*wi x)-mr y*s) <= s) /\
  (-s <= 2*(ui x*s-(vr x*wi x+vi x*wr x)-mi y*s) <= s).

Lemma check_one_sound s b x y :
  check_one s b x y = true -> butterfly_spec s b x y.
Proof.
  unfold check_one.
  cbn zeta.
  repeat rewrite andb_true_iff.
  repeat rewrite Z.eqb_eq.
  repeat rewrite Z.leb_le.
  repeat rewrite Z.ltb_lt.
  intros [[[[[Hin Hout] Ht] Hu] Hv] [[[[[Hpr Hpi] Hr0] Hr1] Hi0] Hi1]].
  unfold butterfly_spec.
  split; [exact Hin|]. split; [exact Hout|].
  repeat split; nia.
Qed.

Fixpoint stage_spec (s b:Z) (xs:list input) (ys:list output) : Prop :=
  match xs,ys with
  | [],[] => True
  | x::xt,y::yt => butterfly_spec s b x y /\ stage_spec s b xt yt
  | _,_ => False
  end.

Lemma check_stage_sound s b xs ys :
  check_stage s b xs ys = true -> stage_spec s b xs ys.
Proof.
  revert ys; induction xs as [|x xt IH]; intros ys H; destruct ys as [|y yt];
    cbn [check_stage stage_spec] in *; try discriminate; try exact I.
  apply andb_true_iff in H. destruct H as [Hx Ht].
  split; [apply check_one_sound; exact Hx|apply IH; exact Ht].
Qed.

Print Assumptions check_one_sound.
Print Assumptions check_stage_sound.
