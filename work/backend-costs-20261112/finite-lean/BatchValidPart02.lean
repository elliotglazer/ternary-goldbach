import BatchValidPart01
set_option maxRecDepth 65536
set_option maxHeartbeats 0
namespace FiniteBatch1024
open BatchPrime BatchData1024
theorem valid_32 : treeValid certificates certificates_32 = true := by decide +kernel
theorem valid_33 : treeValid certificates certificates_33 = true := by
  have hn : nodeValid certificates 9397 2 [2, 2, 3, 3, 3, 3, 29] = true := by decide +kernel
  exact treeValid_node valid_31 hn valid_32
theorem valid_34 : treeValid certificates certificates_34 = true := by decide +kernel
theorem valid_35 : treeValid certificates certificates_35 = true := by decide +kernel
theorem valid_36 : treeValid certificates certificates_36 = true := by
  have hn : nodeValid certificates 14983 3 [2, 3, 11, 227] = true := by decide +kernel
  exact treeValid_node valid_34 hn valid_35
theorem valid_37 : treeValid certificates certificates_37 = true := by
  have hn : nodeValid certificates 11783 5 [2, 43, 137] = true := by decide +kernel
  exact treeValid_node valid_33 hn valid_36
theorem valid_38 : treeValid certificates certificates_38 = true := by decide +kernel
theorem valid_39 : treeValid certificates certificates_39 = true := by decide +kernel
theorem valid_40 : treeValid certificates certificates_40 = true := by
  have hn : nodeValid certificates 26083 7 [2, 3, 3, 3, 3, 7, 23] = true := by decide +kernel
  exact treeValid_node valid_38 hn valid_39
theorem valid_41 : treeValid certificates certificates_41 = true := by decide +kernel
theorem valid_42 : treeValid certificates certificates_42 = true := by decide +kernel
theorem valid_43 : treeValid certificates certificates_43 = true := by
  have hn : nodeValid certificates 44809 11 [2, 2, 2, 3, 1867] = true := by decide +kernel
  exact treeValid_node valid_41 hn valid_42
theorem valid_44 : treeValid certificates certificates_44 = true := by
  have hn : nodeValid certificates 33403 3 [2, 3, 19, 293] = true := by decide +kernel
  exact treeValid_node valid_40 hn valid_43
theorem valid_45 : treeValid certificates certificates_45 = true := by
  have hn : nodeValid certificates 20681 3 [2, 2, 2, 5, 11, 47] = true := by decide +kernel
  exact treeValid_node valid_37 hn valid_44
theorem valid_46 : treeValid certificates certificates_46 = true := by decide +kernel
theorem valid_47 : treeValid certificates certificates_47 = true := by decide +kernel
end FiniteBatch1024
