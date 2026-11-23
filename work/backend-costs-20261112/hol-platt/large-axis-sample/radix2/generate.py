"""Extend the checked whole-axis reference with a radix-two output split."""
from pathlib import Path
import hashlib

here=Path(__file__).resolve().parent
source=here.parents[1]/"large-kronecker-hol-price/LargePanelScript.sml"
assert hashlib.sha256(source.read_bytes()).hexdigest()=="0e49e0993a28c2f6400744f3569bcf6873b06a3756b21ea450db4b57ca5a75b8"
thy=source.read_text().split('val f=TextIO.openIn "cases.txt";')[0].replace('Theory LargePanel','Theory Radix')
thy+=r"""
Definition coef_roots_def:
  (coef_roots 0 H U z step = []) /\
  (coef_roots (SUC n) H U z step =
     (kdiv (FST z+kdiv U 2) U,kdiv (SND z+kdiv U 2) U)::
     coef_roots n H U (kr_rot H z step) step)
End
Definition branched_def:
  (branched sc [] ys ws = ([],[])) /\
  (branched sc (x::xs) ys ws = case ys of [] => ([],[]) | y::rest =>
     case ws of [] => ([],[]) | w::weights =>
     let (ev,od)=branched sc xs rest weights;
         a=2*(FST x+FST y); b=2*(SND x+SND y);
         c=2*(FST x-FST y); d=2*(SND x-SND y)
     in ((a,b)::ev,kr_rot sc (c,d) w::od))
End
Definition selectmode_def:
  selectmode (k:num) es os = lp_pick (k DIV 2) (if EVEN k then es else os)
End
Definition rd_repeat_def:
  (rd_repeat 0 m d B M sc powers x1 x2 ws tw ker es acc=acc) /\
  (rd_repeat (SUC reps) m d B M sc powers x1 x2 ws tw ker es acc =
    let (ev,od)=branched sc x1 x2 tw;
        aa=lp_run d B M sc powers ev ws ker;
        bb=lp_run d B M sc powers od ws ker;
        picks=[selectmode 0 aa bb;selectmode 1 aa bb;selectmode m aa bb;selectmode (2*m-1) aa bb];
        ck=kr_mod (lp_sum aa (lp_sum bb 0)) 65537
    in rd_repeat reps m d B M sc powers x1 x2 ws tw ker es
                  (if picks=es then acc+ck else acc-9999999))
End
Definition rd_top_def:
  rd_top n p cap w d seed step twstep reps es =
    let old=(&(2**p):int); sc=2*old; U=(&(2**64):int); H=sc*U;
        m=n DIV 2; B=(&(2**(8*w)):int); M=(&(2**(8*w*m)):int)-1;
        xs=lp_inputs n (cap*old) 1276261 1534179;
        x1=TAKE m xs; x2=DROP m xs;
        ws=lp_roots m H U (H,0) seed step; tw=coef_roots m H U (H,0) twstep;
        ker=kt_pack d B (lp_conj ws); powers=kt_powers d B [];
        control=kr_mod (FST ker+SND ker+ &(LENGTH ws)+ &(LENGTH tw)+ &(LENGTH x1)+ &(LENGTH x2)) 65537
    in rd_repeat reps m d B M sc powers x1 x2 ws tw ker es control
End
val _=cv_auto_trans rd_top_def;
"""
(here/"RadixScript.sml").write_text(thy)
worker=(here.parent/"worker.sml").read_text().replace("SampleAxisTheory","RadixTheory").replace("SampleAxisTrial","RadixTrial")
worker=worker.replace("val rat=pair() val step=pair() val c=number()","val rat=pair() val step=pair() val twstep=pair() val c=number()")
worker=worker.replace(chr(96)*2+"lp_top"+chr(96)*2,chr(96)*2+"rd_top"+chr(96)*2).replace("rat,step,nu r","rat,step,twstep,nu r")
(here/"worker.sml").write_text(worker)
