import VerifiedCrdt.Crdt

inductive LwwRegisterOp where
  | Read
  | Write

instance LwwRegisterOps (α : Type) : Operations α where
  ops := LwwRegisterOp
  return_type op := match op with
    | LwwRegisterOp.Read => α
    | LwwRegisterOp.Write => Unit
