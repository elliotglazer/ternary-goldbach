import Power4

namespace SmallGoldbach

-- Three plus twice three is nine. This proposed source bit fails primality.
example : segmentOK ⟨3, 3, 1, 0⟩ = false := by decide +kernel

-- An empty anchor list leaves the first requested even number uncovered.
example : checkRow Power4.bits Power4.fac 100 1024 6 ⟨1, 0, 0, 0⟩ = false := by decide +kernel

-- All prime offsets and the coverage mask are retained; corrupt just the modular inverse.
example : (match Power4.rows with
    | first :: second :: _ =>
        checkRow Power4.bits Power4.fac 100 1024 (6+2*first.width) {second with inv := 0}
    | _ => true) = false := by decide +kernel

end SmallGoldbach
