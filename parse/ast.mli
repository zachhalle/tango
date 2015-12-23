(* L1 Compiler
 * Abstract Syntax Trees
 * Author: Alex Vaynberg
 * Modified: Frank Pfenning <fp@cs.cmu.edu>
 *
 * Modified: Anand Subramanian <asubrama@andrew.cmu.edu> Fall 2010
 * Converted to OCaml by Michael Duggan <md5i@cs.cmu.edu>
 *
 * Forward compatible fragment of C0
 *)

type ident = string

type binop =
   PLUS
 | MINUS
 | TIMES
 | DIVIDEDBY
 | MODULO
 
type preop = 
  | NEGATE

type exp =
 | Var of ident
 | ConstExp of Int32.t
 | PreOp of preop * exp
 | BinOp of binop * exp * exp

type gdecl =
  GBinding of string * exp

type program = gdecl list

(* print as source, with redundant parentheses *)
module type PRINT =
  sig
    val pp_exp : exp -> string
    val pp_program : program -> string
    val pp_gdecl : gdecl -> string
  end

module Print : PRINT
