(* L1 Compiler
 * Abstract Syntax Trees
 *)

(* Consider using pretty printing *)

open Core.Std

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

module type PRINT =
  sig
    val pp_exp : exp -> string
    val pp_program : program -> string
    val pp_gdecl : gdecl -> string
  end

module Print : PRINT =
  struct

    let pp_ident id = id

    let pp_oper = fun _ -> ""(*function
        PLUS -> "+"
      | MINUS -> "-"
      | TIMES -> "*"
      | DIVIDEDBY -> "/"
      | MODULO -> "%"
      | NEGATIVE -> "-"
*)
    let rec pp_exp = fun _ -> ""(*function
        Var id     -> pp_ident id
      | ConstExp c -> Int32.to_string c
      | OpExp (op, [e]) -> pp_oper op ^ "(" ^ pp_exp e ^ ")"
      | OpExp (op, [e1; e2]) ->
          "(" ^ pp_exp e1 ^ " " ^ pp_oper op ^ " " ^ pp_exp e2 ^ ")"
      | _ -> assert false*)

    let pp_program stms = "" (*"{\n" ^ pp_stms stms ^ "}"*)
    let pp_gdecl = fun _ -> ""
  end
