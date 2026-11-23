import BatchValidPart06
set_option maxRecDepth 65536
set_option maxHeartbeats 0
namespace FiniteBatch1024
open BatchPrime BatchData1024
theorem valid_112 : treeValid certificates certificates_112 = true := by decide +kernel
theorem valid_113 : treeValid certificates certificates_113 = true := by decide +kernel
theorem valid_114 : treeValid certificates certificates_114 = true := by
  have hn : nodeValid certificates 166666666198608437 2 [2, 2, 7, 2141, 2780187265607] = true := by decide +kernel
  exact treeValid_node valid_112 hn valid_113
theorem valid_115 : treeValid certificates certificates_115 = true := by
  have hn : nodeValid certificates 85167993628723 2 [2, 3, 79, 3119, 57607987] = true := by decide +kernel
  exact treeValid_node valid_111 hn valid_114
theorem valid_116 : treeValid certificates certificates_116 = true := by decide +kernel
theorem valid_117 : treeValid certificates certificates_117 = true := by decide +kernel
theorem valid_118 : treeValid certificates certificates_118 = true := by
  have hn : nodeValid certificates 3999999988766602259 2 [2, 12391, 161407472712719] = true := by decide +kernel
  exact treeValid_node valid_116 hn valid_117
theorem valid_119 : treeValid certificates certificates_119 = true := by decide +kernel
theorem valid_120 : treeValid certificates certificates_120 = true := by decide +kernel
theorem valid_121 : treeValid certificates certificates_121 = true := by
  have hn : nodeValid certificates 3999999988766604197 3 [2, 2, 11, 197, 42299, 10909654253] = true := by decide +kernel
  exact treeValid_node valid_119 hn valid_120
theorem valid_122 : treeValid certificates certificates_122 = true := by
  have hn : nodeValid certificates 3999999988766603191 6 [2, 3, 5, 29, 31, 148312939887527] = true := by decide +kernel
  exact treeValid_node valid_118 hn valid_121
theorem valid_123 : treeValid certificates certificates_123 = true := by
  have hn : nodeValid certificates 3999999988766601467 2 [2, 43, 46511627776355831] = true := by decide +kernel
  exact treeValid_node valid_115 hn valid_122
theorem valid_124 : treeValid certificates certificates_124 = true := by
  have hn : nodeValid certificates 13397325173 2 [2, 2, 7, 11, 59, 737251] = true := by decide +kernel
  exact treeValid_node valid_108 hn valid_123
theorem valid_125 : treeValid certificates certificates_125 = true := by
  have hn : nodeValid certificates 8589934757 2 [2, 2, 13, 165191053] = true := by decide +kernel
  exact treeValid_node valid_93 hn valid_124
theorem valid_126 : treeValid certificates certificates_126 = true := by
  have hn : nodeValid certificates 1285099 2 [2, 3, 17, 43, 293] = true := by decide +kernel
  exact treeValid_node valid_62 hn valid_125
end FiniteBatch1024
