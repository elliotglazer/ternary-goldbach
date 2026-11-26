from pathlib import Path
import hashlib,json
base=Path('/work/tg-warm-diagnostics/333aa9bb21fd87ef1f6be2159dbffc2c8da75962-e8aa6e1f322d2dde06fef1d4e545b614/source')
names={'Lib.Cohomology.Etale.ConnectedComponents': 'ab9dcc42f3bd8b87daf5adac6fbccaa0567db950bfd7b71d314d6f548c189d6a', 'Lib.Cohomology.ProperBaseChange.ValuativeDensity': '93c42fbebc2e53be35db048a355116d8e11e247d900da474efa35dd14c9b4d56', 'Lib.DiscreteSeries.Bessel.BesselNormInvariance': '93c19791d3917fb98f7cd8135ff59cea65b393e94d7e9903ccbfaf3162a0c4b8', 'Lib.DiscreteSeries.Bruhat.ComplexFloorMeasure': '384524264957d68c4ea269ab3b017f2eb504635e46ad49a3b7128870c6ae0476', 'Lib.PadicComparison.Completion.RootSystems': '153c541a1ff8c9cc1823737b76e2bc66bf07cb790475823983a9367506bdd85d', 'Lib.PadicComparison.Crystalline.TestGenericFibre': '7c726cf79a24943488e9ac074560c9abae5f69fcd18c911465e17ddc96424bba', 'Lib.PadicComparison.HodgeTate.GenericFibreTests': 'bb20ddb089396ae22b8e57bc7f99741e64a777b0a2e29b398fe2513eb90e9d69', 'New.Filling.CrudeBoundDefs': '2fddfad2b464331ba03a67cfc8134fd72623afb66dde79165a0bda977a25a891', 'New.Filling.LevelBridge': '3c570f02421620b8b4f6ee9713961526057a7ca8236446206ecce2f8fdceb414', 'New.Filling.Setup': 'd3f209d4d8bba307103f04f5ce0fc52f5196e28c9564581206468219dafb6733', 'New.Filling.StableCells': '4df3825df80fb21a5e2556dfb1656bdca157217c56da9376fc8b687972d05daa', 'New.RealPlace.BesselOrthonormal': '572e56d61ce31d270e875c15d7092668a3ada848af5e07aa0d208b1c4fa201a7', 'New.RealPlace.CellNeighbourhood': 'b9cb77eb5f09f071dd9a7e89e40822e3c0c7875007b40bb1850c82afa5ec0e67', 'New.RealPlace.FrameNorm': '144c3f720a2e9cd5c05afe933c36177844ca095afff59d6b8b6a141e7011b44e', 'New.RealPlace.GramSection': 'afc0e184742c16baed0a8cfecc74ec6c90c71a38b524e6448c96ffa06ca3fd60', 'New.RealPlace.GramSectionBounds': '567fc1fb332fa9fe142317bd24f08f1fd6406dcd4a2954247085f97defbcb1ae', 'New.RealPlace.SobolevCell': 'b5679f903acc8496b7ae2fc87d01be3c136aa8bd669ede9c344f54850e2aef48'}
out={}
for n,srcsha in names.items():
 rel=n.replace('.','/')
 source=base/('CompactGRH/src/'+rel+'.lean')
 assert hashlib.sha256(source.read_bytes()).hexdigest()==srcsha,n
 stem=str(base/'.lake/build/lib/lean'/rel)
 paths={s:Path(stem+s) for s in ['.olean','.olean.private','.olean.server','.ir','.ir.sig','.trace']}
 assert all(p.is_file() for p in paths.values()),n
 out[n]={s:p.stat().st_size for s,p in paths.items()}
print(json.dumps({'modules':out,'total_bytes':sum(sum(v.values()) for v in out.values())},sort_keys=True))
