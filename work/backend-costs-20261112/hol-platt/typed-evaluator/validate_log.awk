BEGIN {
  FS=",";
  if (order!="stock-first" && order!="typed-first") bad=1;
  split("depth1 depth8 depth32 depth128 control_checksum control_bound control_depth control_input control_coefficient",labels," ");
  split("discover parse stock_kernel_reference",parts," ");
  for (i=0;i<8;i++) for (j=1;j<=3;j++) expected["edge_round" i ":" parts[j]]=1;
  for (i=0;i<6;i++) for (j=1;j<=3;j++) expected["edge_array" i ":" parts[j]]=1;
  split("stock_array typed_array stock_accept typed_accept",ops," ");
  for (i=1;i<=9;i++) {
    l=labels[i]; wanted[l]=1; expected[l ":decode_validate"]=1;
    for(j=1;j<=3;j++) { expected[l "_array:" parts[j]]=1; expected[l "_accept:" parts[j]]=1; }
    for(r=0;r<3;r++) for(j=1;j<=4;j++) expected[l ":r" r ":" ops[j]]=1;
  }
  split("checksum bound depth input coefficient",controls," ");
  for(i=1;i<=5;i++) rejected["HOL4_REJECTED_" controls[i]]=0;
}
$1=="TYPED_TIME" {
  if(NF!=4 || !($2 in expected) || ++seen[$2]!=1 ||
     $3 !~ /^[0-9]+\.[0-9]+$/ || $4 !~ /^[0-9]+\.[0-9]+$/) bad=1;
  times++;
}
$1=="TYPED_WORKLOAD_PASS" {
  if(NF!=4 || !($2 in wanted) || ++passes[$2]!=1 || $3!="points=128") bad=1;
  n=8;
  if($2=="control_depth") n=7;
  if(substr($2,1,5)=="depth") n=substr($2,6)+0;
  if($4!="depth=" n) bad=1;
}
$1=="TYPED_ORDER" { if(NF!=2 || $2!=order || ++orders!=1) bad=1; }
$1=="TYPED_EDGES_PASS" { if(NF!=2 || $2!="22" || ++edges!=1) bad=1; }
/^HOL4_REJECTED_/ { if(!($0 in rejected) || ++rejected[$0]!=1) bad=1; }
$0=="HOL4_TYPED_DEPENDENT_BENCHMARK_DONE" { done++; }
END {
  if(times!=213 || orders!=1 || edges!=1 || done!=1) bad=1;
  for(k in expected) if(seen[k]!=1) bad=1;
  for(k in wanted) if(passes[k]!=1) bad=1;
  for(k in rejected) if(rejected[k]!=1) bad=1;
  if(bad) { print "TYPED_LOG_INVALID"; exit 1; }
  print "TYPED_LOG_VALIDATED,213";
}
