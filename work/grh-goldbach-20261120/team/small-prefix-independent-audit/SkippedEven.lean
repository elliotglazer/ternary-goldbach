import ExtendedPrefixB
open SmallGoldbach
example (right : Covered 10402653188 10671088642) : Covered 10134217730 10671088642 :=
  SmallGoldbach.join ContiguousExtensionB.shard0 right
