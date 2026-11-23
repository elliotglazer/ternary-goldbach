import DataP343N64
import StageFast
open BatchedTransform
open DataP343N64
namespace FastP343N64
theorem scale_pos : 0 < scale := by decide
theorem scale_even : scale = 2*(8958978968711216842229769122273777112486581988938598139599956403855167484720643781523509973086428463104 : Int) := by decide
theorem checked : checkFastStage scale 8958978968711216842229769122273777112486581988938598139599956403855167484720643781523509973086428463104 bound inputs outputs = true := by decide +kernel
theorem certified : stage_spec scale bound inputs outputs := checkFastStage_sound scale 8958978968711216842229769122273777112486581988938598139599956403855167484720643781523509973086428463104 bound scale_pos scale_even inputs outputs checked
end FastP343N64
