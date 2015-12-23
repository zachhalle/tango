(* L1 Compiler
 * Utilities and configurations for compiler
 * Authors: Jack Michalak <jmichala@andrew.cmu.edu>
 *          Zach Halle <zmh@andrew.cmu.edu>
 *
 * Contains functions and configurations used throughout the codebase.
 *)

val say : string -> unit
val newline : unit -> unit
val say_if : bool -> (unit -> string) -> unit

val set_verbose : bool -> unit
val say_if_verbose : (unit -> string) -> unit

val set_timing : bool -> unit
val time_maybe : ?msg:string -> (unit -> 'a) -> 'a
