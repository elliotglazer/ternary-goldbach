structure SourceStateBoundsTheory :> SourceStateBoundsTheory =
struct
  
  val _ = if !Globals.print_thy_loads
    then TextIO.print "Loading SourceStateBoundsTheory ... "
    else ()
  
  open Type Term Thm
  local open SourceStateErrorTheory in end;
  
  structure TDB = struct
    val path =
      OS.Path.base (#(FILE)) ^ ".dat"
    val timestamp = HOLFileSys.modTime path
    val thydata = 
      TheoryReader.load_thydata {
        thyname = "SourceStateBounds",
        hash = "c3240960136b1db16a579b553c7af556ebb3280f",
        path = path
      }
    fun find s = #1 (valOf (Symtab.lookup thydata s))
  end
  val () = Theory.record_metadata
    "SourceStateBounds" {timestamp=TDB.timestamp, path=TDB.path}
  
  fun op source_raw_state_error_lt_dyadic96 _ = ()
  val op source_raw_state_error_lt_dyadic96 = TDB.find
    "source_raw_state_error_lt_dyadic96"
  fun op source_raw_envelope_lt_dyadic96 _ = ()
  val op source_raw_envelope_lt_dyadic96 = TDB.find
    "source_raw_envelope_lt_dyadic96"
  fun op source_envelope_linear_prefix _ = ()
  val op source_envelope_linear_prefix = TDB.find
    "source_envelope_linear_prefix"
  
val _ = if !Globals.print_thy_loads then TextIO.print "done\n" else ()
val _ = Theory.load_complete "SourceStateBounds"

end
