import VerifiedCrdt.Crdt
import VerifiedCrdt.Examples.GCounter.Operations
import Mathlib.Init.ZeroOne

private structure State (α : Type) where
  value : α
  count_since_broadcast : α


instance GCounter {ρ τ : Type} (α : Type) [Zero α] [Add α] : Crdt ρ τ α where
  state_type := State α
  message_type := α
  init_state _ := ⟨0, 0⟩

  send state := (⟨state.value, 0⟩, state.count_since_broadcast)
  receive state message := ⟨state.value + message, state.count_since_broadcast⟩
  do_op op state _ := match op with
    | GCounterOp.Read => (state, state.value)
    | GCounterOp.Increment => (⟨state.value, state.count_since_broadcast++⟩, ())
