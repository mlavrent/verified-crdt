import VerifiedCrdt.Crdt
import VerifiedCrdt.Examples.GCounter.Operations
import Mathlib.Init.ZeroOne

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
