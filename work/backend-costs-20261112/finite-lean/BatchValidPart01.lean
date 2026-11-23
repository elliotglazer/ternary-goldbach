import BatchValidPart00
set_option maxRecDepth 65536
set_option maxHeartbeats 0
namespace FiniteBatch1024
open BatchPrime BatchData1024
theorem valid_16 : treeValid certificates certificates_16 = true := by decide +kernel
theorem valid_17 : treeValid certificates certificates_17 = true := by
  have hn : nodeValid certificates 1721 3 [2, 2, 2, 5, 43] = true := by decide +kernel
  exact treeValid_node valid_15 hn valid_16
theorem valid_18 : treeValid certificates certificates_18 = true := by decide +kernel
theorem valid_19 : treeValid certificates certificates_19 = true := by decide +kernel
theorem valid_20 : treeValid certificates certificates_20 = true := by
  have hn : nodeValid certificates 2693 2 [2, 2, 673] = true := by decide +kernel
  exact treeValid_node valid_18 hn valid_19
theorem valid_21 : treeValid certificates certificates_21 = true := by
  have hn : nodeValid certificates 2141 2 [2, 2, 5, 107] = true := by decide +kernel
  exact treeValid_node valid_17 hn valid_20
theorem valid_22 : treeValid certificates certificates_22 = true := by decide +kernel
theorem valid_23 : treeValid certificates certificates_23 = true := by decide +kernel
theorem valid_24 : treeValid certificates certificates_24 = true := by
  have hn : nodeValid certificates 3851 2 [2, 5, 5, 7, 11] = true := by decide +kernel
  exact treeValid_node valid_22 hn valid_23
theorem valid_25 : treeValid certificates certificates_25 = true := by decide +kernel
theorem valid_26 : treeValid certificates certificates_26 = true := by decide +kernel
theorem valid_27 : treeValid certificates certificates_27 = true := by
  have hn : nodeValid certificates 6053 2 [2, 2, 17, 89] = true := by decide +kernel
  exact treeValid_node valid_25 hn valid_26
theorem valid_28 : treeValid certificates certificates_28 = true := by
  have hn : nodeValid certificates 4703 5 [2, 2351] = true := by decide +kernel
  exact treeValid_node valid_24 hn valid_27
theorem valid_29 : treeValid certificates certificates_29 = true := by
  have hn : nodeValid certificates 3301 6 [2, 2, 3, 5, 5, 11] = true := by decide +kernel
  exact treeValid_node valid_21 hn valid_28
theorem valid_30 : treeValid certificates certificates_30 = true := by
  have hn : nodeValid certificates 1429 6 [2, 2, 3, 7, 17] = true := by decide +kernel
  exact treeValid_node valid_14 hn valid_29
theorem valid_31 : treeValid certificates certificates_31 = true := by decide +kernel
end FiniteBatch1024
