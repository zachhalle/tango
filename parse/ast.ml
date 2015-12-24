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
 | Bind of ident * exp * exp (* let id = e1 newline e2 *)

type gdecl =
  GBind of string * exp

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

    let pp_binop = function
      | PLUS -> "+"
      | MINUS -> "-"
      | TIMES -> "*"
      | DIVIDEDBY -> "/"
      | MODULO -> "%"
      
    let pp_preop = function
      | NEGATE -> "-"

    let rec pp_exp = function
      | Var id -> id
      | ConstExp c -> Int32.to_string c
      | PreOp (op, e) -> (pp_preop op) ^ "(" ^ (pp_exp e) ^ ")" 
      | BinOp (op, e1, e2) -> 
        "(" ^ (pp_exp e1) ^ ")" ^ (pp_binop op) ^ "(" ^ (pp_exp e2) ^ ")"
      | Bind (id, e1, e2) ->
        "let " ^ id ^ " = " ^ (pp_exp e1) ^ "\n" ^ (pp_exp e2)

    let pp_gdecl = function
      | GBind (id, e) -> id ^ " =\n" ^ "  " ^ (pp_exp e)

    let pp_program gds = 
      List.fold_right gds ~f:(fun gd ac -> ac ^ (pp_gdecl gd) ^ "\n\n") ~init:"" 
    
  end
