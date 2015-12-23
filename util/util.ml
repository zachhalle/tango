(* L1 Compiler
 * Utilities and configurations for compiler
 * Authors: Jack Michalak <jmichala@andrew.cmu.edu>
 *          Zach Halle <zmh@andrew.cmu.edu>
 *
 * Contains functions and configurations used throughout the codebase.
 *)

open Core.Std

(* Verbosity *)
let be_verbose = ref false
let set_verbose b = be_verbose := b

(* Printing functions *)
let say = prerr_endline
let newline = prerr_newline
let say_if flag s =
  if flag then say (s ()) else ()
let say_if_verbose s = say_if (! be_verbose) s

(* Allows timing sections of code upon request *)
let measure_time = ref false
let set_timing b = measure_time := b
let time_maybe ?msg f = if ! measure_time then
    let t0 = Unix.gettimeofday () in
    let () = match msg with
             | None -> ()
             | Some m -> say m
    in
    let res = f () in
    say (Printf.sprintf "Executed in %f seconds\n" 
                        (Unix.gettimeofday () -. t0));
    res else f ()