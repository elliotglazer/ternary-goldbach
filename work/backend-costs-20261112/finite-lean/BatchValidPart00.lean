import BatchData1024
set_option maxRecDepth 65536
set_option maxHeartbeats 0
namespace FiniteBatch1024
open BatchPrime BatchData1024
theorem valid_0 : treeValid certificates certificates_0 = true := by decide +kernel
theorem valid_1 : treeValid certificates certificates_1 = true := by decide +kernel
theorem valid_2 : treeValid certificates certificates_2 = true := by
  have hn : nodeValid certificates 97 5 [2, 2, 2, 2, 2, 3] = true := by decide +kernel
  exact treeValid_node valid_0 hn valid_1
theorem valid_3 : treeValid certificates certificates_3 = true := by decide +kernel
theorem valid_4 : treeValid certificates certificates_4 = true := by decide +kernel
theorem valid_5 : treeValid certificates certificates_5 = true := by
  have hn : nodeValid certificates 373 2 [2, 2, 3, 31] = true := by decide +kernel
  exact treeValid_node valid_3 hn valid_4
theorem valid_6 : treeValid certificates certificates_6 = true := by
  have hn : nodeValid certificates 227 2 [2, 113] = true := by decide +kernel
  exact treeValid_node valid_2 hn valid_5
theorem valid_7 : treeValid certificates certificates_7 = true := by decide +kernel
theorem valid_8 : treeValid certificates certificates_8 = true := by decide +kernel
theorem valid_9 : treeValid certificates certificates_9 = true := by
  have hn : nodeValid certificates 719 11 [2, 359] = true := by decide +kernel
  exact treeValid_node valid_7 hn valid_8
theorem valid_10 : treeValid certificates certificates_10 = true := by decide +kernel
theorem valid_11 : treeValid certificates certificates_11 = true := by decide +kernel
theorem valid_12 : treeValid certificates certificates_12 = true := by
  have hn : nodeValid certificates 1129 11 [2, 2, 2, 3, 47] = true := by decide +kernel
  exact treeValid_node valid_10 hn valid_11
theorem valid_13 : treeValid certificates certificates_13 = true := by
  have hn : nodeValid certificates 919 7 [2, 3, 3, 3, 17] = true := by decide +kernel
  exact treeValid_node valid_9 hn valid_12
theorem valid_14 : treeValid certificates certificates_14 = true := by
  have hn : nodeValid certificates 541 2 [2, 2, 3, 3, 3, 5] = true := by decide +kernel
  exact treeValid_node valid_6 hn valid_13
theorem valid_15 : treeValid certificates certificates_15 = true := by decide +kernel
end FiniteBatch1024
