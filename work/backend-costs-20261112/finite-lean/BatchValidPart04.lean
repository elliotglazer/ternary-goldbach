import BatchValidPart03
set_option maxRecDepth 65536
set_option maxHeartbeats 0
namespace FiniteBatch1024
open BatchPrime BatchData1024
theorem valid_64 : treeValid certificates certificates_64 = true := by decide +kernel
theorem valid_65 : treeValid certificates certificates_65 = true := by
  have hn : nodeValid certificates 2121241 13 [2, 2, 2, 3, 5, 11, 1607] = true := by decide +kernel
  exact treeValid_node valid_63 hn valid_64
theorem valid_66 : treeValid certificates certificates_66 = true := by decide +kernel
theorem valid_67 : treeValid certificates certificates_67 = true := by decide +kernel
theorem valid_68 : treeValid certificates certificates_68 = true := by
  have hn : nodeValid certificates 5621687 5 [2, 7, 281, 1429] = true := by decide +kernel
  exact treeValid_node valid_66 hn valid_67
theorem valid_69 : treeValid certificates certificates_69 = true := by
  have hn : nodeValid certificates 2914319 7 [2, 11, 132469] = true := by decide +kernel
  exact treeValid_node valid_65 hn valid_68
theorem valid_70 : treeValid certificates certificates_70 = true := by decide +kernel
theorem valid_71 : treeValid certificates certificates_71 = true := by decide +kernel
theorem valid_72 : treeValid certificates certificates_72 = true := by
  have hn : nodeValid certificates 21691751 7 [2, 5, 5, 5, 86767] = true := by decide +kernel
  exact treeValid_node valid_70 hn valid_71
theorem valid_73 : treeValid certificates certificates_73 = true := by decide +kernel
theorem valid_74 : treeValid certificates certificates_74 = true := by decide +kernel
theorem valid_75 : treeValid certificates certificates_75 = true := by
  have hn : nodeValid certificates 81927691 2 [2, 3, 5, 13, 210071] = true := by decide +kernel
  exact treeValid_node valid_73 hn valid_74
theorem valid_76 : treeValid certificates certificates_76 = true := by
  have hn : nodeValid certificates 36709117 2 [2, 2, 3, 599, 5107] = true := by decide +kernel
  exact treeValid_node valid_72 hn valid_75
theorem valid_77 : treeValid certificates certificates_77 = true := by
  have hn : nodeValid certificates 11767033 7 [2, 2, 2, 3, 3, 3, 3, 3, 6053] = true := by decide +kernel
  exact treeValid_node valid_69 hn valid_76
theorem valid_78 : treeValid certificates certificates_78 = true := by decide +kernel
theorem valid_79 : treeValid certificates certificates_79 = true := by decide +kernel
end FiniteBatch1024
