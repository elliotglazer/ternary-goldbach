# Rounded positive cosine bins and twiddle symmetry

The table uses scale 2^81. For a center c the half-unit interval has
endpoints a/D where a is 2c−1 or 2c+1 and D = 2^82. The recurrence starts
with 1 and 2a and takes 58 further steps. At index n its value is
D^n U_n(a/D), by substitution in the Chebyshev recurrence. A negative
product at the endpoints establishes opposite signs. The bounds and strict
adjacent separation are checked on the same endpoint numerators.

RootBinsScript.sml embeds the 29 integers and the full corrupted control.
RootRowsScript.sml embeds all 185 pairs, builds the first quadrant from
the centers, reflects it through the four quadrants, and checks each row
using the step 120 DIV n. The sine coordinate uses a three-quarter turn.

Run generate.py to regenerate the scripts from ../c10004-roots/table.json.
The analytic identification of the ordered roots with cos(jπ/60) requires
a Chebyshev trigonometric identity and a root count beyond these finite
statements.
