from pathlib import Path
import hashlib,json,re
here=Path(__file__).resolve().parent
stem="generic07"
log=(here/f"{stem}.log").read_bytes()
assert (here/f"{stem}.status").read_text().strip()=="0"
assert b'ENCLOSURE_CHECKED' in log and b'Exporting theory "Enclosure" ... done.' in log
deps=["EnclosureScript.sml","Holmakefile","../grid-projection/.hol/objs/ProjectTheory.dat","../grid-sign-join/.hol/objs/GridSignsTheory.dat"]
ins=(here/f"{stem}.sha256").read_text().splitlines()
assert [s.split()[1] for s in ins]==deps
for path,s in zip(deps,ins):
    assert hashlib.sha256((here/path).read_bytes()).hexdigest()==s.split()[0]
files=deps+[".hol/objs/EnclosureTheory.dat",stem+".sha256",stem+".log",stem+".time",stem+".status"]
report={"theorem":"EnclosureTheory.tile_enclosures","statement":"!w e n xs hs. project_ok w e n xs hs ==> LIST_REL encloses (expanded n (2**256) xs) (grid [(w,e,n,hs)])","raw_encoding":"signed sample = int(raw)-2^255","encloses":"q*int(u) <= int(raw)-2^255 < q*int(u)+int(u)","hypotheses":[],"oracle_tag_whitelist":["DISK_THM"],"explicit_axiom_tags":[],"status":0,"sha256":{x:hashlib.sha256((here/x).read_bytes()).hexdigest() for x in files}}
(here/"receipt.json").write_text(json.dumps(report,indent=2)+"\n",encoding="utf-8")
print(report["sha256"][".hol/objs/EnclosureTheory.dat"])
