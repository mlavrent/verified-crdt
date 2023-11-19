import VerifiedCrdt.Crdt
import Mathlib.Init.ZeroOne

/- A grow-only counter supports two replica-local operations:
 - read the counter value
 - increment the counter value -/
inductive GCounterOp where
  | Read
  | Increment

instance GCounterOps (α : Type) : Operations α where
  ops := GCounterOp
  return_type op := match op with
    | GCounterOp.Read => α
    | GCounterOp.Increment => Unit

/- A GCounter is a grow-only counter i.e. a counter that can only increase but not decrease. -/
instance GCounter {ρ τ : Type} (α : Type) [Zero α] [Max α] : Crdt ρ τ α where
  state_type := ρ × (ρ → α)
  message_type := ρ → α
  init_state rid := (rid, fun _ => 0)

  send state := (state, state.snd)
  receive state message := (state.fst, fun rid => max (message rid) (state.snd rid))
  do_op op state _ := match op with
  | GCounterOp.Read => (state, sorry) -- TODO: fix this to sum the values (how to iterate over all ρ values?)
  | GCounterOp.Increment => (state, ())
