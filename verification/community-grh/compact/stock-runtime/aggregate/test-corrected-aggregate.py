from pathlib import Path
import copy,json,subprocess,zipfile,types,tempfile,contextlib,sys
from unittest.mock import patch
p=Path(__file__).resolve().parent;sys.path.insert(0,str(p))
import stock_aggregate as m
archive=Path('/mnt/c/Users/glaze/Downloads/aggregate-probe-failure-evidence.zip')
assert m.sha(archive)=='96193b153f83e5619e1ff581d01dbb24b8d5749e6c84d6aced72dce5cbee0f27'
with zipfile.ZipFile(archive) as z:post=json.loads(z.read('aggregate-probe-postcheck.json'))
child=post['process2910'];facts={k:child[k] for k in ('comm','cgroup','exe')};facts['cmd']=child['cmdline'].split()
for line in child['status']:
 key,val=line.split(':',1)
 if key!='Name':facts[key]=list(map(int,val.split()))
assert facts['PPid']==[2909]
parent={'Uid':[1001]*4,'Gid':[1001]*4,'comm':'systemd','cgroup':facts['cgroup'],'cmd':['/usr/lib/systemd/systemd','--user'],'exe':'/usr/lib/systemd/systemd'}
def pam(child=facts,manager=parent,group='init.scope',main='2909'):
 return m.pam_child('2910',group,main,1001,lambda pid:child if pid=='2910' else manager)
assert pam()
controls=[]
for which,key,value in [('child','Uid',[0]*4),('child','Gid',[1001,89,1001,1001]),('child','PPid',[999]),('child','cmd',['(sd-pam)','--shell']),('child','comm','related'),('child','cgroup',facts['cgroup']+'/other'),('child','exe','/tmp/systemd-executor'),('manager','exe','/tmp/systemd'),('manager','cmd',['/usr/lib/systemd/systemd','--system']),('manager','comm','user'),('manager','Uid',[0]*4),('manager','cgroup','0::/user.slice')]:
 ch,ma=copy.deepcopy(facts),copy.deepcopy(parent)
 (ch if which=='child' else ma)[key]=value;assert not pam(ch,ma);controls.append(which+'.'+key)
assert not pam(group='app.slice') and not pam(main='0')
subprocess.run([sys.executable,'-B',p/'test-stock-aggregate.py'],check=True)
with tempfile.TemporaryDirectory(dir='/var/lib') as td:
 root=Path(td);state=root/'state';state.mkdir(mode=0o700);controller=root/'controller.py';controller.write_bytes((p/'stock_aggregate.py').read_bytes())
 old=post['state'];oldtok=old['token'];(state/(oldtok+'.json')).write_text(json.dumps(old))
 inv='b144a957097a4dcf949b655476b55e7e';active=True;external=False;calls=[]
 def run(argv,check=True):
  global active
  calls.append(argv)
  if argv[:2]==['systemctl','stop']:
   assert argv[2]==m.UNIT;active=False;return types.SimpleNamespace(stdout='',returncode=0)
  if argv[:2]==['systemctl','is-active'] and '--quiet' not in argv:return types.SimpleNamespace(stdout='active' if active else 'inactive',returncode=0 if active else 3)
  raise AssertionError(argv)
 def fail(f,fragment):
  try:f()
  except RuntimeError as e:assert fragment in str(e),e
  else:raise AssertionError('accepted bad input')
 with contextlib.ExitStack() as st:
  for k,v in {'STATE':state,'HERE':controller,'identity':lambda:inv,'workloads':lambda:[('init.scope','2910','systemd-executor')],'current':lambda:m.ORIGINAL.copy(),'raw_config':lambda:{},'active_dependents':lambda:(['tg-warm-main.service'] if external else []),'manager_scoped':lambda:None,'run':run}.items():st.enter_context(patch.object(m,k,v))
  wrong=inv;inv='changed';fail(m.reconcile,'Different');inv=wrong
  external=True;fail(m.reconcile,'external');external=False
  (state/'owner').write_text('another job');fail(m.reconcile,'lease');(state/'owner').unlink()
  assert not any(x[:2]==['systemctl','stop'] for x in calls)
  assert m.reconcile()==0 and not active and not (state/'owner').exists();assert m.reconcile()==0
  token='6'*24;m.save(m.statefile(token),{'phase':'new','prior_manager':'inactive','scope':'tg-palomar-aggregate-'+token,'original_error':'fixture primary admission rejection'});m.make_lease(token)
  with patch.object(m,'workloads',side_effect=RuntimeError('foreign work')):assert m.restore(token)==0
  saved=json.loads(m.statefile(token).read_text());assert saved['settings_untouched'] and saved['cleanup_clean'] and saved['original_error']=='fixture primary admission rejection' and not (state/'owner').exists()
result={'controller_sha256':m.sha(p/'stock_aggregate.py'),'stock_probe_sha256':m.PROBE_SHA,'base_controls_sha256':m.sha(p/'stock-aggregate-control.json'),'first_failure_archive_sha256':m.sha(archive),'actual_child_snapshot':facts,'actual_first_invocation':inv,'wrong_pam_fields_rejected':controls+['scope','invalid MainPID'],'reconciliation_controls':['different manager refused','external required unit refused','concurrent lease refused','exact archived initial state and idle invocation stopped','already inactive is idempotent','unrelated pre-arm workload left running with original failure preserved'],'scope':'Archived child/boot control facts are real. Host manager response and rollback interactions were simulated locally. A real EC2 second-run positive stock profile and actual restored manager state remain required.'}
dst=p/'corrected-aggregate-control.json';dst.write_text(json.dumps(result,indent=2)+'\n');print('PASS',result['controller_sha256'],m.sha(dst))
