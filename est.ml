open Utils

type id = Ident.t
type label = Ident.t
type pstring = string

type program = module_ list

and module_ = {
    md_id: id ;
    md_decls: Ist.decl list ;
    md_defs: def list ;
  }

and def = {
    df_id: id ;
    df_args: ty_id list ;
    df_return: ty_id list ;
    df_body: block list ;
  }

and ty_id = Ist.type_expr * id
and ty_idl = ty_id list

and pat = pat_el list
and pat_el = Ist.type_expr * pat_
and pat_ = 
  | Pany 
  | Pid of id
  | Pvariant of id * pat
  | Precord of id option * pfield list

and pfield = id * pat

and block = {
    bl_id: label ;
    bl_eqs: equation list ;
    bl_ret: ty_idl ;
  }

and equation = ty_idl * expr

and expr = 
  | Eid of id
  | Evalue of Ist.value
  | Evariant of id * ty_idl
  | Ebinop of Ast.bop * ty_id * ty_id
  | Euop of Ast.uop * ty_id
  | Erecord of (id * ty_idl) list 
  | Ewith of ty_id * (id * ty_idl) list 
  | Efield of ty_id * id 
  | Ematch of ty_idl * (pat * expr) list
  | Ecall of label
  | Eapply of id * ty_idl
  | Eseq of ty_id * ty_idl
  | Eif of ty_id * label * label

