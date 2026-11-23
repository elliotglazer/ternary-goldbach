import BatchValidPart02
set_option maxRecDepth 65536
set_option maxHeartbeats 0
namespace FiniteBatch1024
open BatchPrime BatchData1024
theorem valid_48 : treeValid certificates certificates_48 = true := by
  have hn : nodeValid certificates 83231 7 [2, 5, 7, 29, 41] = true := by decide +kernel
  exact treeValid_node valid_46 hn valid_47
theorem valid_49 : treeValid certificates certificates_49 = true := by decide +kernel
theorem valid_50 : treeValid certificates certificates_50 = true := by decide +kernel
theorem valid_51 : treeValid certificates certificates_51 = true := by
  have hn : nodeValid certificates 176507 2 [2, 11, 71, 113] = true := by decide +kernel
  exact treeValid_node valid_49 hn valid_50
theorem valid_52 : treeValid certificates certificates_52 = true := by
  have hn : nodeValid certificates 110527 5 [2, 3, 13, 13, 109] = true := by decide +kernel
  exact treeValid_node valid_48 hn valid_51
theorem valid_53 : treeValid certificates certificates_53 = true := by decide +kernel
theorem valid_54 : treeValid certificates certificates_54 = true := by decide +kernel
theorem valid_55 : treeValid certificates certificates_55 = true := by
  have hn : nodeValid certificates 359171 6 [2, 5, 7, 7, 733] = true := by decide +kernel
  exact treeValid_node valid_53 hn valid_54
theorem valid_56 : treeValid certificates certificates_56 = true := by decide +kernel
theorem valid_57 : treeValid certificates certificates_57 = true := by decide +kernel
theorem valid_58 : treeValid certificates certificates_58 = true := by
  have hn : nodeValid certificates 859799 13 [2, 429899] = true := by decide +kernel
  exact treeValid_node valid_56 hn valid_57
theorem valid_59 : treeValid certificates certificates_59 = true := by
  have hn : nodeValid certificates 488227 2 [2, 3, 81371] = true := by decide +kernel
  exact treeValid_node valid_55 hn valid_58
theorem valid_60 : treeValid certificates certificates_60 = true := by
  have hn : nodeValid certificates 252913 5 [2, 2, 2, 2, 3, 11, 479] = true := by decide +kernel
  exact treeValid_node valid_52 hn valid_59
theorem valid_61 : treeValid certificates certificates_61 = true := by
  have hn : nodeValid certificates 59107 2 [2, 3, 9851] = true := by decide +kernel
  exact treeValid_node valid_45 hn valid_60
theorem valid_62 : treeValid certificates certificates_62 = true := by
  have hn : nodeValid certificates 7459 2 [2, 3, 11, 113] = true := by decide +kernel
  exact treeValid_node valid_30 hn valid_61
theorem valid_63 : treeValid certificates certificates_63 = true := by decide +kernel
end FiniteBatch1024
