import DataP343N64
import StageFast
open BatchedTransform
open DataP343N64
namespace Chunk8P343N64
theorem chunk_0 : checkStage scale bound [x0, x1, x2, x3, x4, x5, x6, x7] [y0, y1, y2, y3, y4, y5, y6, y7] = true := by decide +kernel
theorem chunk_1 : checkStage scale bound [x8, x9, x10, x11, x12, x13, x14, x15] [y8, y9, y10, y11, y12, y13, y14, y15] = true := by decide +kernel
theorem chunk_2 : checkStage scale bound [x16, x17, x18, x19, x20, x21, x22, x23] [y16, y17, y18, y19, y20, y21, y22, y23] = true := by decide +kernel
theorem chunk_3 : checkStage scale bound [x24, x25, x26, x27, x28, x29, x30, x31] [y24, y25, y26, y27, y28, y29, y30, y31] = true := by decide +kernel
theorem chunk_4 : checkStage scale bound [x32, x33, x34, x35, x36, x37, x38, x39] [y32, y33, y34, y35, y36, y37, y38, y39] = true := by decide +kernel
theorem chunk_5 : checkStage scale bound [x40, x41, x42, x43, x44, x45, x46, x47] [y40, y41, y42, y43, y44, y45, y46, y47] = true := by decide +kernel
theorem chunk_6 : checkStage scale bound [x48, x49, x50, x51, x52, x53, x54, x55] [y48, y49, y50, y51, y52, y53, y54, y55] = true := by decide +kernel
theorem chunk_7 : checkStage scale bound [x56, x57, x58, x59, x60, x61, x62, x63] [y56, y57, y58, y59, y60, y61, y62, y63] = true := by decide +kernel
theorem checked : checkStage scale bound inputs outputs = true := (checkStage_append scale bound _ _ _ _ chunk_0 (checkStage_append scale bound _ _ _ _ chunk_1 (checkStage_append scale bound _ _ _ _ chunk_2 (checkStage_append scale bound _ _ _ _ chunk_3 (checkStage_append scale bound _ _ _ _ chunk_4 (checkStage_append scale bound _ _ _ _ chunk_5 (checkStage_append scale bound _ _ _ _ chunk_6 (checkStage_append scale bound _ _ _ _ chunk_7 rfl))))))))
theorem certified : stage_spec scale bound inputs outputs := checkStage_sound scale bound inputs outputs checked
end Chunk8P343N64
