import DataP343N64
import StageFast
import Replay
open BatchedTransform DataP343N64

def valid : Prop := checkStage scale bound inputs outputs = true
def wrongRounded : Output := {y0 with pr := y0.pr+1, mr := y0.mr-1}
def wrong : Prop := checkStage scale bound inputs (wrongRounded::outputs.tail) = true
def missing : Prop := checkStage scale bound inputs outputs.tail = true
def reordered : Prop := checkStage scale bound inputs (y1::y0::outputs.drop 2) = true
def badCoefficient : Input := {x0 with wr := 0}
def badRoot : Prop := checkStage scale bound (badCoefficient::inputs.tail) outputs = true
def fastValid : Prop := checkFastStage scale (scale/2) bound inputs outputs = true
def fastWrong : Prop := checkFastStage scale (scale/2) bound inputs (wrongRounded::outputs.tail) = true
def fastMissing : Prop := checkFastStage scale (scale/2) bound inputs outputs.tail = true

#kernel_control valid accept
#kernel_control wrong reject
#kernel_control missing reject
#kernel_control reordered reject
#kernel_control badRoot reject
#kernel_control fastValid accept
#kernel_control fastWrong reject
#kernel_control fastMissing reject

/- Positive and negative half ties, checked independently of the stage data. -/
example : (BatchedTransform.computeOne 8 4 ⟨0,0,1,-1,4,0⟩).pr = 1 := by decide
example : (BatchedTransform.computeOne 8 4 ⟨0,0,1,-1,4,0⟩).pi = 0 := by decide
