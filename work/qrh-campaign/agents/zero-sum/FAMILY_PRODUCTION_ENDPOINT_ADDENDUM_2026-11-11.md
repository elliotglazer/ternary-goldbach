# Endpoint addendum to the full-family completeness plan

2026-11-11. Optional mathematical strengthening of the conservative endpoint contract in `FAMILY_PRODUCTION_COMPLETENESS_PLAN_2026-11-11.md` (SHA740840E7576E988AF4C8F8053030BE59EB4EA18DE8C7E0D6B391BF7C9B1C5DEF). The frozen plan is unchanged. This addendum was prompted by the independent review; no numerical computation or existing analytic theorem is asserted proved here.

The integrated count inequality can use closed counts and does not inherently require a separate zero-free top boundary. The exact hypotheses are:

* For almost every t in(T,T+h), the convention-fixed identity holds:
  C_chi(t)=2theta_a(t)/pi+S_chi(t)+S_barchi(t), where C counts nontrivial zeros with |gamma|<=t, including multiplicity and real zeros.
* The S functions are integrable there and have the two stated Turing integral bounds. Any chosen one-sided values at zero ordinates do not change those integrals.
* Zeros are locally finite and conjugation identifies negative ordinates for chi with positive ordinates for barchi, preserving multiplicity.

Fix T>0, h>0, including the possibility of zeros exactly at either endpoint. For t>T there is the exact counting identity

    C_chi(t)=C_chi(T)+A_chi(T,t]+A_barchi(T,t],

where A counts positive ordinates strictly greater than T and at most t. Zeros at T are already in the closed base count; zeros at T+h contribute only on an integration set of measure zero. Integrating the a.e. count formula gives

    h*C_chi(T)=integral_T^(T+h) 2theta_a(t)/pi dt
      +integral S_chi+integral S_barchi
      -integral [A_chi(T,t]+A_barchi(T,t]].

For disjoint certified sign intervals(u_j,v_j) contained in(T,T+h), each known zero contributes at least T+h-v_j to the final integral. Therefore exactly the plan's upper bound remains valid:

    C_chi(T)<=U=[integral 2theta_a/pi-W+B_chi+B_barchi]/h.

Main critical-line sign intervals strictly below T and an exact central contribution provide K_main<=C_chi(T). If U<K_main+1, integer saturation proves C_chi(T)=K_main. It also rules out any additional zero at |gamma|=T, since such a zero would have been included in C_chi(T) but not in the open main sign intervals. No separate top-path evaluation is logically necessary for this integrated variant.

For real chi, both auxiliary channels and both positive main counts have the factor2 specified in the plan. For nonreal pairs, each member contributes one positive channel. Real zeros remain in C_chi(T) and cannot be dropped. The conclusion through inclusive Hcert follows for T>=Hcert.

This reduction does not erase hypotheses from a theorem that explicitly assumes nonexceptional endpoints. A formal implementation must prove the a.e./closed-count version from the argument principle and local finiteness, or derive it by limits with all continuity/integrability estimates justified. The original Turing bound's full hypotheses still require source verification. It also does not turn incomplete sign searches into a certificate: only exact saturation closes a character or pair.

Fourier normalization clarification for the companion plan: with its already defined Z_chi(t)=epsilon_chi*Lambda_chi(1/2+it), the function whose transform has the displayed prefactor is exactly

    F_a(t,chi)=c^(-(2a+1)/4)*exp(pi*eta*t/4)*Z_chi(t).

The conductor scalar is positive and does not change sign certificates, but it is essential in the Fourier identity and its absolute error budget. It must not be omitted when translating the source theorem. This clarifies the phrase 'corresponding gamma-completed critical-line function'; it changes neither count normalization nor saturation.
