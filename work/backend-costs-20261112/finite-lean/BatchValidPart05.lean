import BatchValidPart04
set_option maxRecDepth 65536
set_option maxHeartbeats 0
namespace FiniteBatch1024
open BatchPrime BatchData1024
theorem valid_80 : treeValid certificates certificates_80 = true := by
  have hn : nodeValid certificates 357914083 2 [2, 3, 79, 103, 7331] = true := by decide +kernel
  exact treeValid_node valid_78 hn valid_79
theorem valid_81 : treeValid certificates certificates_81 = true := by decide +kernel
theorem valid_82 : treeValid certificates certificates_82 = true := by decide +kernel
theorem valid_83 : treeValid certificates certificates_83 = true := by
  have hn : nodeValid certificates 3691617563 2 [2, 1845808781] = true := by decide +kernel
  exact treeValid_node valid_81 hn valid_82
theorem valid_84 : treeValid certificates certificates_84 = true := by
  have hn : nodeValid certificates 1073742077 3 [2, 2, 11, 1163, 20983] = true := by decide +kernel
  exact treeValid_node valid_80 hn valid_83
theorem valid_85 : treeValid certificates certificates_85 = true := by decide +kernel
theorem valid_86 : treeValid certificates certificates_86 = true := by decide +kernel
theorem valid_87 : treeValid certificates certificates_87 = true := by
  have hn : nodeValid certificates 8589933271 3 [2, 3, 3, 5, 43, 2219621] = true := by decide +kernel
  exact treeValid_node valid_85 hn valid_86
theorem valid_88 : treeValid certificates certificates_88 = true := by decide +kernel
theorem valid_89 : treeValid certificates certificates_89 = true := by decide +kernel
theorem valid_90 : treeValid certificates certificates_90 = true := by
  have hn : nodeValid certificates 8589934201 11 [2, 2, 2, 3, 5, 5, 19, 23, 181, 181] = true := by decide +kernel
  exact treeValid_node valid_88 hn valid_89
theorem valid_91 : treeValid certificates certificates_91 = true := by
  have hn : nodeValid certificates 8589933733 2 [2, 2, 3, 3739, 191449] = true := by decide +kernel
  exact treeValid_node valid_87 hn valid_90
theorem valid_92 : treeValid certificates certificates_92 = true := by
  have hn : nodeValid certificates 8589932731 2 [2, 3, 3, 5, 3709, 25733] = true := by decide +kernel
  exact treeValid_node valid_84 hn valid_91
theorem valid_93 : treeValid certificates certificates_93 = true := by
  have hn : nodeValid certificates 151607987 2 [2, 75803993] = true := by decide +kernel
  exact treeValid_node valid_77 hn valid_92
theorem valid_94 : treeValid certificates certificates_94 = true := by decide +kernel
theorem valid_95 : treeValid certificates certificates_95 = true := by decide +kernel
end FiniteBatch1024
