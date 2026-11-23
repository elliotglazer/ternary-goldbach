from pathlib import Path
here=Path(__file__).resolve().parent
for q in ("7689","7283","10000"):
 p=here/q/"run.sh"
 s=p.read_text()
 key='test ! -e "$label.log"'
 meta='''for dep in ../../grid-enclosure ../../sparse-head ../../stencil-perturbation ../../raw-analytic/dependency-build-win01 ../../interpolation-geometry; do
 if test -d "$dep/.hol/make-deps"; then
  dest="$here/metadata/$(basename "$dep")"
  mkdir -p "$dest"
  cp -a "$dep/.hol/make-deps/." "$dest/"
  mount --bind "$dest" "$dep/.hol/make-deps"
 fi
done
'''
 if meta not in s:p.write_bytes(s.replace(key,meta+key).encode())
