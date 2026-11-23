import PackedLoadedP343N8
import PackedLoadedP343N16
import PackedLoadedP343N32
import PackedLoadedP343N64
import NatScalarP343N8
import NatScalarP343N16
import NatScalarP343N32
import NatScalarP343N64
import Replay
set_option maxRecDepth 65536
set_option maxHeartbeats 0
#audit_packed_literals LoadedPackedDataN8 "packed_literals_8.json"
#audit_packed_literals LoadedPackedDataN16 "packed_literals_16.json"
#audit_packed_literals LoadedPackedDataN32 "packed_literals_32.json"
#audit_packed_literals LoadedPackedDataN64 "packed_literals_64.json"
open PackedProbe LoadedPackedDataN64
def loadedPackedBad : Prop := packedCheck left right mask (Nat.xor expected 1) = true
#kernel_control loadedPackedBad reject
#print axioms PackedLoadedP343N8.certified
#print axioms NatScalarP343N8.certified
#print axioms PackedLoadedP343N16.certified
#print axioms NatScalarP343N16.certified
#print axioms PackedLoadedP343N32.certified
#print axioms NatScalarP343N32.certified
#print axioms PackedLoadedP343N64.certified
#print axioms NatScalarP343N64.certified
