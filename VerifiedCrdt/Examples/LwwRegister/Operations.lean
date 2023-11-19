import VerifiedCrdt.Crdt

inductive LwwRegisterOp (α : Type) where
  | Read
  | Write (value : α)

instance LwwRegisterOps (α : Type) : Operations α where
  ops := LwwRegisterOp α
  return_type op := match op with
    | LwwRegisterOp.Read => α
    | LwwRegisterOp.Write _ => Unit
