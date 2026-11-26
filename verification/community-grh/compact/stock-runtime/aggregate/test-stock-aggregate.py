from pathlib import Path
import contextlib,hashlib,importlib.util,json,os,subprocess,tempfile,types,sys
from unittest.mock import patch
p=Path(__file__).resolve().parent
spec=importlib.util.spec_from_file_location('subject',p/'stock_aggregate.py');m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m)
live=Path('/mnt/c/Users/glaze/Documents/Codex/2026-11-25/new-chat-2/outputs/stock-runtime-and-recovery/stock-32x64-report.json')
observed=json.loads(live.read_bytes());assert m.sha(live)=='f0fc5c4d3089085dbe679c624351418f530eb698d6591f1698740e9f6ce6b898'
assert not observed['classification']['aggregate_32x64_swap0'] and observed['inner']['ancestors'][str(m.CG)]|{} and all(observed['inner']['ancestors'][str(m.CG)][k]==v for k,v in m.ORIGINAL.items())
def result(stdout='',rc=0):return types.SimpleNamespace(stdout=stdout,stderr='',returncode=rc)
def fail(fn):
 try:fn()
 except RuntimeError as e:return str(e)
 raise AssertionError('negative control accepted')
tests=[]
with tempfile.TemporaryDirectory() as td:
 root=Path(td);cg=root/'cg';state=root/'state';runtime=root/'runtime';cg.mkdir();state.mkdir()
 for k,v in m.ORIGINAL.items():(cg/k).write_text(v)
 (cg/'memory.current').write_text('12288')
 def fake_run(argv,check=True):
  if argv[0]=='systemctl' and ('ControlGroup' in argv or 'InvocationID' in argv): return result('some-id')
  if 'loginctl' in argv or 'list-jobs' in argv or 'stop' in argv or 'daemon-reload' in argv:return result()
  raise AssertionError(str(argv))
 calls=[]
 def fake_set(vals):
  calls.append(vals);now=m.BOUNDED if vals==m.SET else m.ORIGINAL
  for k,v in now.items():(cg/k).write_text(v)
  runtime.mkdir(exist_ok=True)
  for i,prop in enumerate(('CPUQuota','MemoryMax','MemorySwapMax')):
   value=(('3200%',m.BOUNDED['memory.max'],'0') if vals==m.SET else ('','infinity','infinity'))[i]
   (runtime/('50-'+prop+'.conf')).write_text('# runtime control\n[Service]\n'+prop+'='+value+'\n')
 argv0=[]
 def record(argv):
  argv0.append(argv);return 0
 with contextlib.ExitStack() as stack:
  for field,value in {'CG':cg,'STATE':state,'RUNTIME':runtime,'set_runtime':fake_set,'run':fake_run,'usercmd':lambda *a:list(a),'manager_scoped':lambda:None,'identity':lambda:'fixture-id'}.items():stack.enter_context(patch.object(m,field,value))
  stack.enter_context(patch.object(m.subprocess,'call',record))
  def init(tok):
   m.save(m.statefile(tok),{'token':tok,'phase':'new','scope':'tg-palomar-aggregate-'+tok,'prior_manager':'active'})
  token='4'*24;init(token);assert m.root_entry(token,'/policy','/scratch',[])==0
  assert m.current()==m.BOUNDED and m.controlled_files({}) and m.read_lease(token) and '--user' in argv0[-1] and 'inner' in argv0[-1];tests.append('scope of user coordinator and exact applied settings')
  conflict='5'*24;init(conflict)
  try:m.root_entry(conflict,'/policy','/scratch',[])
  except FileExistsError:pass
  else:raise AssertionError('second lease acquired')
  assert m.restore(conflict)==0 and m.read_lease(token)
  assert m.restore(token)==0 and m.current()==m.ORIGINAL and not runtime.exists() and not (state/'owner').exists()
  tests.append('competing lease refused, correct owner restored all kernel limits and private drop-ins')
  init(token)
  def broken(values):
   fake_set(values)
   if values==m.SET:raise RuntimeError('cut after mutation')
  with patch.object(m,'set_runtime',broken):assert 'cut' in fail(lambda:m.root_entry(token,'/p','/w',[]))
  assert m.restore(token)==0 and m.current()==m.ORIGINAL
  tests.append('cleanup of an interruption immediately after runtime resource mutation')
  init(token)
  runtime.mkdir();(runtime/'50-MemoryMax.conf').write_text('[Service]\nMemoryMax=12345\n')
  assert 'Existing runtime' in fail(lambda:m.root_entry(token,'/p','/w',[]));m.restore(token)
  assert (runtime/'50-MemoryMax.conf').read_text().endswith('12345\n')
  (runtime/'50-MemoryMax.conf').unlink();runtime.rmdir()
  tests.append('unrelated pre-existing resource override rejected and unchanged')
  init(token);sh=cg/'app.slice/unrelated.service';sh.mkdir(parents=True);(sh/'cgroup.procs').write_text(str(os.getpid()))
  assert 'another workload' in fail(lambda:m.root_entry(token,'/p','/w',[]));m.restore(token);(sh/'cgroup.procs').unlink();tests.append('live foreign process rejected')
  init(token);m.root_entry(token,'/p','/w',[]);(runtime/'foreign.conf').write_text('[Service]\nOther=1\n')
  assert 'Foreign' in fail(lambda:m.restore(token));assert (runtime/'foreign.conf').exists() and m.read_lease(token);(runtime/'foreign.conf').unlink();m.restore(token);tests.append('foreign runtime mutation retained and surfaced')
  init(token);m.root_entry(token,'/p','/w',[])
  with patch.object(m,'identity',lambda:'restarted'):assert 'contaminated' in fail(lambda:m.restore(token))
  assert m.current()==m.ORIGINAL and not (state/'owner').exists();tests.append('manager restart marks result invalid while restoring resources')
 unit=root/'tg-aggregate-control.service';unit.write_text('[Unit]\nWants=user@1001.service\nAfter=user@1001.service\n[Service]\nType=exec\nExecStart=/usr/bin/true\nExecStopPost=/usr/bin/python3 -I /opt/example.py restore test\nRuntimeMaxSec=180\nTimeoutStopSec=75\n')
 z=subprocess.run(['systemd-analyze','verify','--man=no',str(unit)],capture_output=True,text=True);assert z.returncode==0,(z.stdout,z.stderr);tests.append('Ubuntu systemd 255 parsed bounded service with ExecStopPost control and user-manager dependency')
assert m.sha(m.PROBE)==m.PROBE_SHA
receipt={'controller_sha256':m.sha(p/'stock_aggregate.py'),'stock_probe_sha256':m.PROBE_SHA,'prior_host_receipt_sha256':m.sha(live),'prior_host_phase_was_sibling':True,'tests':tests,'scope':'The stock 32x64 outer-only EC2 measurement is genuine. These predeployment tests exercise operative control code with an isolated simulated manager; a successful new EC2 aggregate report and release/rollback log are required.'}
out=p/'stock-aggregate-control.json';out.write_text(json.dumps(receipt,indent=2)+'\n');print('PASS',receipt['controller_sha256'],m.sha(out),flush=True)
