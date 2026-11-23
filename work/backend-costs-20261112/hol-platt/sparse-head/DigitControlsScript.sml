Theory DigitControls
Ancestors CheckedDigits TwoHead
Libs intLib
Theorem width_one_edges:
 TwoHead$twoval 1 0 (- &(2**501)) 0 1 0 = -1 /\
 TwoHead$twoval 1 0 (- &(2**500)) 0 1 0 = 0 /\
 TwoHead$twoval 1 0 0 0 1 0 = 1 /\
 TwoHead$twoval 1 0 (&(2**500)) 0 1 0 = 2
Proof
 EVAL_TAC
QED
Theorem cancellation_control:
 let a=2**543+2**500+2**544*(2**543-2**501);
     b=2**543+2**544*2**543;
     x=2**242+1+2**243*(2**242+1);
     y=2**242+2**243*2**242
 in TwoHead$twosweep 64 1 0 3 a b x y=(0,4) /\
 CheckedDigits$checked 64 1 0 3 a b x y=(F,0,4)
Proof
 EVAL_TAC
QED
