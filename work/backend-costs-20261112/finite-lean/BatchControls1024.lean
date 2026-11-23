import BatchBlock1024
import Replay
set_option maxHeartbeats 0
set_option maxRecDepth 65536
namespace BatchControls1024
open BatchPrime BatchData1024

def badBase : Tree := match certificates with
  | .empty => .empty
  | .node l p _ fs r => .node l p 1 fs r
def badProduct : Tree := match certificates with
  | .empty => .empty
  | .node l p a fs r => .node l p a (0 :: fs) r
def missingFactor : Tree := match certificates with
  | .empty => .empty
  | .node _ p a fs r => .node .empty p a fs r
def selfReference : Tree := match certificates with
  | .empty => .empty
  | .node l p a fs r => .node l p a (p :: fs) r
def composite : Tree := .node (.node .empty 2 0 [] .empty) 9 2 [2, 2, 2] .empty

def smallTree : BatchPrime.Tree := .node (.node .empty 2 0 [] .empty) 3 2 [2]
  (.node .empty 7 3 [2, 3] .empty)
def smallGood : Prop := treeValid smallTree smallTree = true
def good : Prop := rootsKnown certificates roots = true
def goodCover : Prop := checkedCover target certificates witnesses = true
def goodWidth : Prop := (witnesses.length == 1024) = true
def goodEndpoint : Prop := (target + 2 * witnesses.length == endExclusive) = true
def wrongBase : Prop := treeValid badBase badBase = true
def wrongProduct : Prop := treeValid badProduct badProduct = true
def missing : Prop := treeValid missingFactor missingFactor = true
def circular : Prop := treeValid selfReference selfReference = true
def notPrime : Prop := treeValid composite composite = true
def emptyTree : Prop := checkedCover target .empty witnesses = true
def wrongOrigin : Prop := checkedCover (target + 2) certificates witnesses = true
def missingWitness : Prop := (witnesses.tail.length == 1024) = true
def wrongEndpoint : Prop := (target + 2 * witnesses.length == endExclusive + 2) = true

#kernel_control BatchControls1024.smallGood accept
#kernel_control BatchControls1024.good accept
#kernel_control BatchControls1024.goodCover accept
#kernel_control BatchControls1024.goodWidth accept
#kernel_control BatchControls1024.goodEndpoint accept
#kernel_control BatchControls1024.wrongBase reject
#kernel_control BatchControls1024.wrongProduct reject
#kernel_control BatchControls1024.missing reject
#kernel_control BatchControls1024.circular reject
#kernel_control BatchControls1024.notPrime reject
#kernel_control BatchControls1024.emptyTree reject
#kernel_control BatchControls1024.wrongOrigin reject
#kernel_control BatchControls1024.missingWitness reject
#kernel_control BatchControls1024.wrongEndpoint reject
end BatchControls1024
