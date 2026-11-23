(* Untrusted diagnostic worker. No HOL imports or theorem constructors. *)
structure TypedBlock =
struct
type z = IntInf.int;
type point = z * z;
exception Invalid of string;
fun require b s = if b then () else raise Invalid s;
(* INTEGER.div floors, including negative numerators. Never use quot here. *)
fun round (s:z) (r:z) =
  (require (s > 0) "nonpositive scale"; IntInf.div (2*r+s,2*s));
fun butterfly (s:z) ((ur,ui):point) ((vr,vi):point) ((wr,wi):point) =
  let val t = wr*(vr+vi)
      val a = vi*(wr+wi)
      val c = vr*(wi-wr)
      val qr = round s (t-a)
      val qi = round s (t+c)
  in ((ur+qr,ui+qi),(ur-qr,ui-qi)) end;
fun validate (s:z) (ws:point vector) (n:int) (xs:point vector) =
  (require (s > 0) "nonpositive scale";
   require (n >= 0) "negative layer count";
   require (Vector.length xs mod 2 = 0 andalso
            Vector.length ws = Vector.length xs div 2) "unequal pair/coefficient lengths";
   require (Vector.length xs <= Array.maxLen) "array capacity");
fun run s ws n xs =
  let val _ = validate s ws n xs
      val len = Vector.length xs
  in if len = 0 then Vector.fromList [] else
    let val a = Array.tabulate (len,fn i => Vector.sub (xs,i))
        val b = Array.array (len,(0,0):point)
        (* old[offset+i] is logical input i. New buffer is written at
           unrotated indices, so its next offset is 1, not offset+1. *)
        fun read old offset i =
          Array.sub (old,if offset = 0 then i else if i = len-1 then 0 else i+1)
        fun layer old dst offset j =
          if j = Vector.length ws then () else
          let val i = 2*j
              val (p,m) = butterfly s (read old offset i)
                                    (read old offset (i+1)) (Vector.sub (ws,j))
              val _ = Array.update (dst,i,p)
              val _ = Array.update (dst,i+1,m)
          in layer old dst offset (j+1) end
        fun loop old dst offset k =
          if k = 0 then Vector.tabulate (len,fn i => read old offset i)
          else (layer old dst offset 0; loop dst old 1 (k-1))
    in loop a b 0 n end
  end;
fun within (bound:z) (x:z) = ~bound <= x andalso x <= bound;
fun outputAccept (bound:z) (expected:z) (ys:point vector) =
  let val bounded = Vector.all (fn (r,i) => within bound r andalso within bound i) ys
      fun checksum j acc = if j < 0 then acc else
        let val (r,i) = Vector.sub (ys,j)
        in checksum (j-1) (r+3*i+9*acc) end
  in bounded andalso checksum (Vector.length ys-1) 0 = expected end;
fun accept s ws n xs bound expected = outputAccept bound expected (run s ws n xs);
end;
