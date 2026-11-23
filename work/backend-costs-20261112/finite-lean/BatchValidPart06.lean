import BatchValidPart05
set_option maxRecDepth 65536
set_option maxHeartbeats 0
namespace FiniteBatch1024
open BatchPrime BatchData1024
theorem valid_96 : treeValid certificates certificates_96 = true := by
  have hn : nodeValid certificates 8589935399 11 [2, 11, 2339, 166931] = true := by decide +kernel
  exact treeValid_node valid_94 hn valid_95
theorem valid_97 : treeValid certificates certificates_97 = true := by decide +kernel
theorem valid_98 : treeValid certificates certificates_98 = true := by decide +kernel
theorem valid_99 : treeValid certificates certificates_99 = true := by
  have hn : nodeValid certificates 8589936367 6 [2, 3, 3, 11, 19, 43, 53101] = true := by decide +kernel
  exact treeValid_node valid_97 hn valid_98
theorem valid_100 : treeValid certificates certificates_100 = true := by
  have hn : nodeValid certificates 8589935909 2 [2, 2, 103, 331, 62989] = true := by decide +kernel
  exact treeValid_node valid_96 hn valid_99
theorem valid_101 : treeValid certificates certificates_101 = true := by decide +kernel
theorem valid_102 : treeValid certificates certificates_102 = true := by decide +kernel
theorem valid_103 : treeValid certificates certificates_103 = true := by
  have hn : nodeValid certificates 8589937579 2 [2, 3, 719, 1991177] = true := by decide +kernel
  exact treeValid_node valid_101 hn valid_102
theorem valid_104 : treeValid certificates certificates_104 = true := by decide +kernel
theorem valid_105 : treeValid certificates certificates_105 = true := by decide +kernel
theorem valid_106 : treeValid certificates certificates_106 = true := by
  have hn : nodeValid certificates 8589938743 3 [2, 3, 3, 7, 11, 6197647] = true := by decide +kernel
  exact treeValid_node valid_104 hn valid_105
theorem valid_107 : treeValid certificates certificates_107 = true := by
  have hn : nodeValid certificates 8589938117 2 [2, 2, 127, 16909327] = true := by decide +kernel
  exact treeValid_node valid_103 hn valid_106
theorem valid_108 : treeValid certificates certificates_108 = true := by
  have hn : nodeValid certificates 8589936877 2 [2, 2, 3, 715828073] = true := by decide +kernel
  exact treeValid_node valid_100 hn valid_107
theorem valid_109 : treeValid certificates certificates_109 = true := by decide +kernel
theorem valid_110 : treeValid certificates certificates_110 = true := by decide +kernel
theorem valid_111 : treeValid certificates certificates_111 = true := by
  have hn : nodeValid certificates 331786433449 17 [2, 2, 2, 3, 3, 3, 3, 37, 59, 234547] = true := by decide +kernel
  exact treeValid_node valid_109 hn valid_110
end FiniteBatch1024
