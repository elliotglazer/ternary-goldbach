import PackedP343N8
import NatScalarP343N8
import PackedP343N16
import NatScalarP343N16
import PackedP343N32
import NatScalarP343N32
import PackedP343N64
import NatScalarP343N64
import Replay
open PackedProbe PackedDataN64
set_option maxRecDepth 65536
set_option maxHeartbeats 0
def packedBad : Prop := packedCheck left right mask (Nat.xor expected 1) = true
#kernel_control packedBad reject
#print axioms PackedP343N8.certified
#print axioms NatScalarP343N8.certified
#print axioms PackedP343N16.certified
#print axioms NatScalarP343N16.certified
#print axioms PackedP343N32.certified
#print axioms NatScalarP343N32.certified
#print axioms PackedP343N64.certified
#print axioms NatScalarP343N64.certified
