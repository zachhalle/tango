(* L1 Compiler
 * Top Level Environment
 * Author: Kaustuv Chaudhuri <kaustuv+@cs.cmu.edu>
 * Modified: Alex Vaynberg <alv@andrew.cmu.edu>
 * Modified: Frank Pfenning <fp@cs.cmu.edu>
 * Converted to OCaml by Michael Duggan <md5i@cs.cmu.edu>
 * Modified: Jack Michalak <jmichala@andrew.cmu.edu>
 *           Zach Halle <zmh@andrew.cmu.edu>
 *)

open Core.Std
open Util

type os_type = Mac | Other (* OS X requires different naming conventions *)

exception EXIT

let spec =
  let open Command.Spec in
  empty
  +> anon (sequence ("files" %: string))
  +> flag "--verbose" ~aliases:["-v"] no_arg ~doc:" Verbose messages"
  +> flag "--dump-parsing" no_arg ~doc:" Pretty print parsing messages"
  +> flag "--dump-ast" no_arg ~doc:" Pretty print the AST"
  +> flag "--dump-ir" no_arg ~doc:" Pretty print the IR"
  +> flag "--dump-assem" no_arg ~doc:" Pretty print the assembly"
  +> flag "--only-typecheck" ~aliases:["-t"] no_arg ~doc:" Halt after typechecking"
  +> flag "--dump-final" no_arg ~doc:" Pretty print the final result"
  +> flag "--timing" no_arg ~doc:" Print out timing along the way"

let main files verbose dump_parsing dump_ast dump_ir dump_assem typecheck_only 
  dump_final measure_time () =
  try
    let source = match files with
    | [] -> say "Error: no input file provided"; raise EXIT
    | [filename] -> filename
    | _ -> say "Error: more than one input file"; raise EXIT
    in

    (* Parse *)
    say_if_verbose (fun () -> "Parsing... " ^ source);
    if dump_parsing then ignore (Parsing.set_trace true);

    let ast = Parse.parse source in
    say_if dump_ast (fun () -> Ast.Print.pp_program ast);

    Printf.printf "done\n"

  with
    ErrorMsg.Error -> say "Compilation failed"; exit 1
  | EXIT -> exit 1
  | Arg.Help x -> prerr_string x; exit 1
  | e -> prerr_string (Exn.to_string e); exit 1

let () = Command.run (Command.basic ~summary:"L1 compiler" spec main)
