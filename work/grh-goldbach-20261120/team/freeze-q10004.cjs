// Run with Node from any directory. Output is deterministic and uses no sign data.
const fs = require('node:fs');
const path = require('node:path');
const crypto = require('node:crypto');
const assert = require('node:assert/strict');
const work = path.resolve(__dirname, '../..');
const hash = data => crypto.createHash('sha256').update(data).digest('hex');
const manifest = fs.readFileSync(path.join(work, 'qrh-campaign/agents/integration/transform_structural_manifest_20261111.json'));
const q = 10004;
const row = JSON.parse(manifest).conductors.find(r => r[0] === q);
const [, units, primitive, height, sampleCount] = row;
const mainLast = sampleCount-1;
assert.equal(units, 4800);
assert.equal(primitive, 2301);
assert.equal(mainLast, Math.ceil(64*height/5));
function powers(g, p) {
  const list = [1];
  while (list.length < p-1) list.push(list.at(-1)*g%p);
  assert.equal(new Set(list).size,p-1);
  return list;
}
const a = powers(6,41), b = powers(2,61);
const labels = new Map();
for (let k=1;k<40;k++) for(let l=1;l<60;l++) {
  const label = (2501*3 + 4880*a[k] + 2624*b[l])%q;
  labels.set(label,{k,l,parity:(1+k+l)%2});
}
assert.equal(labels.size,primitive);
const reference = JSON.parse(fs.readFileSync(path.join(work,'backend-costs-20261112/hol-platt/c10004-reference/receipt.json')));
for (const check of reference.nodes[0].checks) {
  const {k,l}=labels.get(check.conrey);
  assert.deepEqual([1,k,l],check.positive_frequency);
}
const cohorts = [[],[]];
let self=0;
for (const [label,{k,l,parity}] of labels) {
  const inverse=(2501*3 + 4880*a[40-k] + 2624*b[60-l])%q;
  assert.equal(label*inverse%q,1);
  if(label===inverse) self++;
  if(label>=inverse) continue;
  const key='repair-v1/'+q+'/'+label+'/'+inverse;
  cohorts[parity].push({labels:[label,inverse],frequency:[[k,l],[40-k,60-l]],key,sha256:hash(key)});
}
assert.equal(self,1);
assert.equal(cohorts[0].length+cohorts[1].length,1150);
for(const cohort of cohorts) cohort.sort((x,y)=>x.sha256.localeCompare(y.sha256,'en'));
console.log(JSON.stringify({q,manifestSHA256:hash(manifest),height,mainLast,
  spacing:'5/64',guards:[320,640].map(extra=>({extra,last:mainLast+extra,upperHeight:height+5*extra/64})),
  upperHeightMeaning:'Turing integration endpoint; sample index rounds upward',
  primitive,nonselfPairsByParity:cohorts.map(x=>x.length),even:cohorts[0][0],odd:cohorts[1][0],
  cpuHourLimits:{firstPass:4,retries:4},result:'Inventory preflight only'},null,2));
