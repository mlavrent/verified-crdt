import VerifiedCrdt.Crdt
import VerifiedCrdt.Utils
import VerifiedCrdt.Examples.GCounter.Operations
import Mathlib.Init.ZeroOne

private structure State (ρ α : Type) where
  my_replica_id : ρ
  replica_counts : ρ → α

/- A GCounter is a grow-only counter i.e. a counter that can only increase but not decrease. -/
instance GCounter {ρ τ : Type} (α : Type) [BEq ρ] [Zero α] [Max α] [Incrementable α] : Crdt ρ τ α where
  state_type := State ρ α
  message_type := ρ → α
  init_state rid := ⟨rid, fun _ => 0⟩

  send state := ⟨state, state.replica_counts⟩
  receive state message := ⟨state.my_replica_id, fun rid => max (message rid) (state.replica_counts rid)⟩
  do_op op state _ := match op with
  | GCounterOp.Read => (state, sorry) -- TODO: fix this to sum the values (how to iterate over all ρ values?)
  | GCounterOp.Increment => (⟨state.my_replica_id, fun rid => (if rid == state.my_replica_id then Incrementable.increment else id) (state.replica_counts rid)⟩, ())
