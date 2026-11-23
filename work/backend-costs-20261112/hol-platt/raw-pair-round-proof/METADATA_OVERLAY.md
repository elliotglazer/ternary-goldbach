# Isolated dependency metadata

Pair01 stopped before running the helper because Holmake tried to create .hol/make-deps/realTheory.sml.d in the read-only dependency stage. The attempt is terminal with exit 1 and its files are archived. All 142 library output pins still match the completed dependency-build inventory.

The successor mounts a private copy of only the stage's make-deps directory at that same container path. The original stage, sources and compiled theory objects remain read-only. Holmake can refresh disposable dependency metadata in the owned copy; it cannot rebuild or overwrite the imported library artifacts. Both the proof and reload-audit launchers use their own metadata copies. No mathematical source changes accompany this repair.
