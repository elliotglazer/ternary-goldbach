# Conditional cost of the four-band plus-height profile

2026-11-11. Integer/rational schedule metadata only. This compares the new coupled profile with the **current reviewed Tplus profile**, not the original Platt heights. The analytic profile is pending independent review at this freeze. There are no computed spectral values, successful signs, Turing closures, builds or runtime claims.

For the same large-conductor circuit, the new main general-complex-product count is between .906524 and .906525 times the current main count. With 640 auxiliary nodes on both sides of the comparison, the ratio is between .912650 and .912651. The shared P27 head-addition count falls to between .666420 and .666421 of the current main count because the common height prefix shrinks more than the weighted conductor grid. Initialization and transform setup do not shrink.

## Exact schedule and scope

The candidate is COUPLED_PLUS_HEIGHT_CUBIC_BUDGET_2026-11-11.md, SHA256 6767F9E14E5B6D7264D972085EA9C70359C87544403D37DAE315CBEF2510FC54. Its full four-band rule applies to all supported conductors. In the branch priced here, c>10000, its parameter is always u=19.5:

    Hnew(c)=ceil(200+max(255,19.5*3.1416*1063200/qt(c))),
    Jnew(c)=ceil(64*Hnew(c)/5)+1,
    t_j=5j/64, j=0,...,Jnew-1.

The two ceilings are separate. The old comparison uses the current Tplus ceiling with floor260 and u=23.3 except even c>60000, where u=19.89. It uses the same two-ceiling grid convention. The last grid point can lie above the integer certificate height, by at most1/16; that point and its arithmetic errors remain charged.

The conductor set is unchanged: odd10000<c<=132900 or4|c<=265800. It has125400 conductors,4333246843 primitive labels, and7133015232 unit-residue inputs per common height. The7499 small conductors with18477108 primitive labels and the principal branch are excluded from both compared totals. Although the new analytic rule also changes some smaller heights, this report claims no cost reduction for that separately implemented branch.

The script imports only the pinned metadata definitions before the existing inventory loop. It uses the identical fixed-original-order pruned circuit, including full retained Bluestein leaves. It reconstructs the current Tplus main totals and all selected-P27 scenario totals exactly before comparing the candidate. No axis-order optimization, new pruning, reduced precision or altered root setup is introduced.

## Main and auxiliary conductor work

Every extra node adds the unchanged one-height totals. The extensions167,320,640 have lengths835/64,25,50 measured from the last main grid point. They are conditional scenarios, not sufficient universal Turing guards. If the count is based at the integer certificate height instead, the main-grid overshoot must also be included.

| Schedule | Conductor-height nodes | Residue inputs | Primitive outputs |
|---|---:|---:|---:|
|Current Tplus main|1729026050|65920064426356|40474902420727|
|Candidate main|1545129536|60719106537478|36733644379717|
|Candidate +167|1566071336|61910320081222|37457296602498|
|Candidate +320|1585257536|63001671411718|38120283369477|
|Candidate +640|1625385536|65284236285958|39506922359237|

| Schedule | General complex products G | Complex additions A | G / current same-extension G |
|---|---:|---:|---|
|Current Tplus main|1120925963188476|2319745161470097|1|
|Candidate main|1016146569565796|2104881781255801|[.906524,.906525]|
|Candidate +167|1036661049747026|2147380233179650|[.908204,.908205]|
|Candidate +320|1055455753146596|2186315940630841|[.909691,.909692]|
|Candidate +640|1094764936727396|2267750100005881|[.912650,.912651]|

The receipt also preserves quarter turns, negations and dyadic scalings separately. They are not priced as general products. All main per-conductor grids are prefixes of their current Tplus grids. Compared with the current *main* grids, the candidate +167,+320,+640 scenarios extend41543,51450,53987 individual conductors, respectively. This does not enlarge the global seed domain. Comparing candidate+d against current+d is always a prefix comparison.

For P20 contraction, literal Horner has19 stages per residue input. The main candidate has1153663024212082 real-times-complex stages and the same number of complex additions. With each G implemented by four real products, transform plus Horner uses6371912326687348 real products and8549382750067358 real additions. The product count is between .911749 and .911750 of the corresponding current main count. The receipt includes all auxiliary scenarios and the separate cached-three-product and general-three-product alternatives using the already reviewed formulas. Those alternatives retain their different setup, temporary-width and rounding requirements; none is selected by an equal-cost assumption.

## Shared selected-P27 work

The largest candidate main J is85902, uniquely at c=10004 with Hnew=6711. The current maximum is102145. All conductors start at j=0, so the global seed request is exactly this prefix. The candidate's last heights are:

| Extra nodes | Global nodes | Last height |
|---:|---:|---:|
|0|85902|429505/64|
|167|86069|107585/16|
|320|86222|431105/64|
|640|86542|432705/64|

All are below the current main maximum7980 and within the old V10000/J128000 proofs. The first four unchanged (V,D,N) bands have6401,6400,12800,38400 nodes, respectively. In the final band (10000,8192,3387), the current main38144 nodes become21901,22068,22221,22541 for the four candidate scenarios. No D or N is retuned.

For each band with H heights, use K=27D+20 source coefficients, H*N*(26D+19) reciprocal scales, H*N*K head additions, H*(153D+146) E recurrence stages,64H*K Bernoulli terms and additions,330H*D midpoint updates, and20H*(2D+1) final P20 deliveries. These are exactly the selected source ledger, not P24 comparison costs.

| Category | Current main | Candidate main | Candidate +167 | Candidate +320 | Candidate +640 |
|---|---:|---:|---:|---:|---:|
|P27 source coefficients|13658841620|10065825048|10102766116|10136610328|10207395608|
|Head reciprocal scales|35130458950228|23411650051777|23532135250696|23642519894017|23873389736257|
|Head accumulator additions|36481686540592|24312139411228|24437258808544|24551889154588|24791638897948|
|E recurrence stages|77403439250|57042481404|57251819578|57443608444|57844735484|
|Bernoulli terms (and additions)|874165863680|644212803072|646577031424|648743060992|653273318912|
|Midpoint updates|166916428800|123005752320|123457213440|123870827520|124735902720|
|Final P20 deliveries|20234337300|14911506200|14966232100|15016370200|15121234200|
|Height/argument pairs|1351525157121|900708862350|905343863349|909590301390|918471740430|
|Fine-state updates|1351497402624|900681107853|905316108852|909562546893|918443985933|

Each height/argument pair also incurs its separate state-to-EM-grid conversion. The stored fine recurrence state is not overwritten by that rounded copy. The receipt gives shared R recurrence stages and coarse-anchor instances as separate categories. Final assembly, exports and their proof witnesses remain additional work; the table does not assign them zero cost.

## Unchanged setup and limits

The largest seed band remains present. Its nested rational argument union is still27754497 points through x=3389. All initial B certificates, step-cis certificates and step-grid conversions remain27754497. The selected log error2^-144, base error2^-120, step/update error2^-140 and EM conversion error2^-122 remain. The log setup still has582822471 nonanchor Horner stages, with its unchanged anchors; no weaker precision is inferred from the shorter recurrence.

The transform setup retains12496 top axis lengths,32942 active nodes,6004 Blue kernels,337702368 kernel entries,140276846 chirp entries and maximum padded length262144. Its construction still costs2244782056 G and5502647200 A, and the full CT root-table upper count remains1116142487. New setup at the same precision is zero; old setup is not zero.

The candidate was checked against the reduced base-gap and star cutoff for every included conductor; both fit inside its requested RH height. This is metadata verification of a conditional certificate union, not proof of the analytic inputs. A<=9e-12, B<1915 and the source profile remain the actual mathematical obligations described by the author note. Principal and small-conductor costs, auxiliary success, interpolation, sign certificates, Turing completeness, exceptional precision, serialization, Lean/MM0 checking and binary coverage remain outside these subtotals. In particular a 9% transform-product reduction is not a 9% end-to-end time reduction.

The new script coupled_plus_height_inventory_20261111.py and its JSON bind the candidate and four prior circuit/ledger artifacts by exact hashes. Every old baseline total is reconciled before the new counts are emitted. The receipt refuses overwrite; predecessor files are unchanged. Independent review is needed before accepting this conditional cost comparison.
