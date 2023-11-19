import VerifiedCrdt.Crdt
import VerifiedCrdt.Examples.LwwRegister.Operations
import Mathlib.Init.ZeroOne
import Init.Data.Ord

/- A last-write-wins register resolves conflicts by setting the register to whoever made the change last. -/
instance LwwRegister {ρ τ : Type} (α : Type) [Zero τ] [LT τ] [DecidableRel (@LT.lt τ _)] [Inhabited α] : Crdt ρ τ α where
  state_type := α × τ
  message_type := α × τ
  init_state _ := (default, 0)

  send state := (state, state)
  receive state message :=
    if message.snd > state.snd
      then message
      else state
  do_op op state timestamp :=
    match op with
      | LwwRegisterOp.Read => (state, state.fst)
      | LwwRegisterOp.Write value =>
        if timestamp > state.snd
          then ((value, timestamp), ())
          else (state, ())
