import AdjacentShard0
import AdjacentShard1
import AdjacentShard2
import AdjacentShard3
open SmallGoldbach
theorem adjacent_block : Covered 99250000000 99518435456 :=
  (SmallGoldbach.join (SmallGoldbach.join AdjacentShard0.covered AdjacentShard1.covered) (SmallGoldbach.join AdjacentShard2.covered AdjacentShard3.covered))
#print axioms adjacent_block
