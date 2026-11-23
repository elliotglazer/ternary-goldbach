"""Prove the same factorial using eight balanced consecutive products."""
import extend as e
from flint import fmpz


def build(tag, cutoff):
    ns = "SmallGoldbach."+tag
    depth = (cutoff//32).bit_length()
    leaves = ["import Power10Common","import FastHex",f"namespace {ns}", "set_option maxHeartbeats 0"]
    parents = ["import "+tag+"FactorLeaves",f"namespace {ns}", "set_option maxHeartbeats 0",
               "private theorem joinProduct (d a n : Nat) {u v : Nat}",
               "    (hu : u = SmallGoldbach.rangeProduct d a (n/2))",
               "    (hv : v = SmallGoldbach.rangeProduct d (a+n/2) (n-n/2)) :",
               "    u*v = SmallGoldbach.rangeProduct (d+1) a n := congrArg₂ Nat.mul hu hv"]
    def emit(index, degree, lo, n, remaining):
        name = "fac" if index == 1 else f"v{index}"
        if remaining:
            m = n//2
            l,lv = emit(2*index,degree-1,lo,m,remaining-1)
            r,rv = emit(2*index+1,degree-1,lo+m,n-m,remaining-1)
            value = lv*rv
            lines = parents
            proof = [f"  exact joinProduct {degree-1} {lo} {n} eq{2*index} eq{2*index+1}"]
            definition = f"{l} * {r}"
        else:
            value = fmpz.fac_ui(lo+n-1)//fmpz.fac_ui(lo-1)
            lines = leaves
            proof = ["  decide +kernel"]
            definition = e.packed(int(value))
        lines.extend([f"def {name} : Nat := {definition}",
                      f"theorem eq{index} : {name} = SmallGoldbach.rangeProduct {degree} {lo} {n} := by",*proof])
        return name,value
    emit(1,depth,1,cutoff,3)
    parents.extend([f"theorem fac_eq : fac = Nat.factorial {cutoff} := SmallGoldbach.factorial_of_product {depth} eq1",f"end {ns}"])
    leaves.append(f"end {ns}")
    e.write_module(tag+"FactorLeaves",leaves)
    e.write_module(tag+"Common",parents)
