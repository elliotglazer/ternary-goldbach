import TreeDataP343N256
import StageFast
open BatchedTransform
open DataP343N256 TreeDataP343N256
namespace TreeChunk16P343N256
theorem checked_n0_16 : checkStage scale bound xs_n0_16 ys_n0_16 = true := by decide +kernel
theorem checked_n16_32 : checkStage scale bound xs_n16_32 ys_n16_32 = true := by decide +kernel
theorem checked_n0_32 : checkStage scale bound xs_n0_32 ys_n0_32 = true := checkStage_append scale bound xs_n0_16 xs_n16_32 ys_n0_16 ys_n16_32 checked_n0_16 checked_n16_32
theorem checked_n32_48 : checkStage scale bound xs_n32_48 ys_n32_48 = true := by decide +kernel
theorem checked_n48_64 : checkStage scale bound xs_n48_64 ys_n48_64 = true := by decide +kernel
theorem checked_n32_64 : checkStage scale bound xs_n32_64 ys_n32_64 = true := checkStage_append scale bound xs_n32_48 xs_n48_64 ys_n32_48 ys_n48_64 checked_n32_48 checked_n48_64
theorem checked_n0_64 : checkStage scale bound xs_n0_64 ys_n0_64 = true := checkStage_append scale bound xs_n0_32 xs_n32_64 ys_n0_32 ys_n32_64 checked_n0_32 checked_n32_64
theorem checked_n64_80 : checkStage scale bound xs_n64_80 ys_n64_80 = true := by decide +kernel
theorem checked_n80_96 : checkStage scale bound xs_n80_96 ys_n80_96 = true := by decide +kernel
theorem checked_n64_96 : checkStage scale bound xs_n64_96 ys_n64_96 = true := checkStage_append scale bound xs_n64_80 xs_n80_96 ys_n64_80 ys_n80_96 checked_n64_80 checked_n80_96
theorem checked_n96_112 : checkStage scale bound xs_n96_112 ys_n96_112 = true := by decide +kernel
theorem checked_n112_128 : checkStage scale bound xs_n112_128 ys_n112_128 = true := by decide +kernel
theorem checked_n96_128 : checkStage scale bound xs_n96_128 ys_n96_128 = true := checkStage_append scale bound xs_n96_112 xs_n112_128 ys_n96_112 ys_n112_128 checked_n96_112 checked_n112_128
theorem checked_n64_128 : checkStage scale bound xs_n64_128 ys_n64_128 = true := checkStage_append scale bound xs_n64_96 xs_n96_128 ys_n64_96 ys_n96_128 checked_n64_96 checked_n96_128
theorem checked_n0_128 : checkStage scale bound xs_n0_128 ys_n0_128 = true := checkStage_append scale bound xs_n0_64 xs_n64_128 ys_n0_64 ys_n64_128 checked_n0_64 checked_n64_128
theorem checked_n128_144 : checkStage scale bound xs_n128_144 ys_n128_144 = true := by decide +kernel
theorem checked_n144_160 : checkStage scale bound xs_n144_160 ys_n144_160 = true := by decide +kernel
theorem checked_n128_160 : checkStage scale bound xs_n128_160 ys_n128_160 = true := checkStage_append scale bound xs_n128_144 xs_n144_160 ys_n128_144 ys_n144_160 checked_n128_144 checked_n144_160
theorem checked_n160_176 : checkStage scale bound xs_n160_176 ys_n160_176 = true := by decide +kernel
theorem checked_n176_192 : checkStage scale bound xs_n176_192 ys_n176_192 = true := by decide +kernel
theorem checked_n160_192 : checkStage scale bound xs_n160_192 ys_n160_192 = true := checkStage_append scale bound xs_n160_176 xs_n176_192 ys_n160_176 ys_n176_192 checked_n160_176 checked_n176_192
theorem checked_n128_192 : checkStage scale bound xs_n128_192 ys_n128_192 = true := checkStage_append scale bound xs_n128_160 xs_n160_192 ys_n128_160 ys_n160_192 checked_n128_160 checked_n160_192
theorem checked_n192_208 : checkStage scale bound xs_n192_208 ys_n192_208 = true := by decide +kernel
theorem checked_n208_224 : checkStage scale bound xs_n208_224 ys_n208_224 = true := by decide +kernel
theorem checked_n192_224 : checkStage scale bound xs_n192_224 ys_n192_224 = true := checkStage_append scale bound xs_n192_208 xs_n208_224 ys_n192_208 ys_n208_224 checked_n192_208 checked_n208_224
theorem checked_n224_240 : checkStage scale bound xs_n224_240 ys_n224_240 = true := by decide +kernel
theorem checked_n240_256 : checkStage scale bound xs_n240_256 ys_n240_256 = true := by decide +kernel
theorem checked_n224_256 : checkStage scale bound xs_n224_256 ys_n224_256 = true := checkStage_append scale bound xs_n224_240 xs_n240_256 ys_n224_240 ys_n240_256 checked_n224_240 checked_n240_256
theorem checked_n192_256 : checkStage scale bound xs_n192_256 ys_n192_256 = true := checkStage_append scale bound xs_n192_224 xs_n224_256 ys_n192_224 ys_n224_256 checked_n192_224 checked_n224_256
theorem checked_n128_256 : checkStage scale bound xs_n128_256 ys_n128_256 = true := checkStage_append scale bound xs_n128_192 xs_n192_256 ys_n128_192 ys_n192_256 checked_n128_192 checked_n192_256
theorem checked_n0_256 : checkStage scale bound xs_n0_256 ys_n0_256 = true := checkStage_append scale bound xs_n0_128 xs_n128_256 ys_n0_128 ys_n128_256 checked_n0_128 checked_n128_256
theorem certified : stage_spec scale bound xs_n0_256 ys_n0_256 :=
  checkStage_sound scale bound xs_n0_256 ys_n0_256 checked_n0_256
end TreeChunk16P343N256
