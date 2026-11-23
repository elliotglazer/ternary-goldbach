# Reduce lambda applications after expanding let bindings

Projection04 proved stage40 and line60. It stopped in selected_expand because rewriting LET_THM left nested lambda applications. Both selected_expand and full_expand now finish with ordinary depth beta conversion after the same definition rewrites. Definitions and theorem statements are unchanged. The failed source, receipts and saved state are preserved under history/projection04_expand_beta.

This is a proof-tactic repair awaiting complete construction and the reload audit. No throughput or forecast change follows.
