class Crdt {ρ : Type} (τ : Type) where
  state_type : Type
  message_type : Type

  init_state : ρ → state_type
  send : state_type → state_type × message_type
  receive : state_type → message_type → state_type

class CrdtOps (τ : Type) where
  ops : Type
  return_type : ops → Type
