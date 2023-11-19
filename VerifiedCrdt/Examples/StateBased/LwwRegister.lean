import VerifiedCrdt.Crdt
import Mathlib.Init.ZeroOne

inductive LwwRegisterOp where
  | Read
  | Write

instance LwwRegisterOps (α : Type) : Operations α where
  ops := LwwRegisterOp
  return_type op := match op with
    | LwwRegisterOp.Read => α
    | LwwRegisterOp.Write => Unit

instance LwwRegister {ρ τ : Type} (α : Type) [Zero τ] [Inhabited α] : Crdt ρ τ α where
  state_type := α × τ
  message_type := α × τ
  init_state rid := (default, 0)

  send state := (state, state)
  receive state message := sorry
  do_op op state timestamp := sorry
