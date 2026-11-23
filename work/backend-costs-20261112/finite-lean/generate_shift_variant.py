import re
from pathlib import Path
H=Path(__file__).resolve().parent
s=(H/'Block1024.lean').read_text()
s=s.replace('import Data1024','import Data1024\nimport PrimeBitmapShift')
s=s.replace('PrimeBitmap.singleton ','PrimeBitmap.singleton_shift ')
s=re.sub(r'\(2 \^ (\d+)\)',r'(1 <<< \1)',s)
(H/'BlockShift1024.lean').write_text(s,encoding='utf-8',newline='\n')
