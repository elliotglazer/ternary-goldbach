structure SourceInverseRootTheory :> SourceInverseRootTheory =
struct
  
  val _ = if !Globals.print_thy_loads
    then TextIO.print "Loading SourceInverseRootTheory ... "
    else ()
  
  open Type Term Thm
  local open RealFieldContextTheory SourceArithmeticTheory in end;
  
  structure TDB = struct
    val path =
      OS.Path.base (#(FILE)) ^ ".dat"
    val timestamp = HOLFileSys.modTime path
    val thydata = 
      TheoryReader.load_thydata {
        thyname = "SourceInverseRoot",
        hash = "6df5c9020a53fa45517948bf9b7bf7b3cf6cd320",
        path = path
      }
    fun find s = #1 (valOf (Symtab.lookup thydata s))
  end
  val () = Theory.record_metadata
    "SourceInverseRoot" {timestamp=TDB.timestamp, path=TDB.path}
  
  fun op source_sqrt_bracket _ = ()
  val op source_sqrt_bracket = TDB.find "source_sqrt_bracket"
  fun op source_inverse_root_scaled_enclosure _ = ()
  val op source_inverse_root_scaled_enclosure = TDB.find
    "source_inverse_root_scaled_enclosure"
  fun op source_inverse_root_real_error _ = ()
  val op source_inverse_root_real_error = TDB.find
    "source_inverse_root_real_error"
  fun op source_inverse_root_adjacent_squares _ = ()
  val op source_inverse_root_adjacent_squares = TDB.find
    "source_inverse_root_adjacent_squares"
  
val _ = if !Globals.print_thy_loads then TextIO.print "done\n" else ()
val _ = Theory.load_complete "SourceInverseRoot"

end
