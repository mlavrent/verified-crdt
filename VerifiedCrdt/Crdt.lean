/- A type α implementing this has known operations that can be performed on it (`ops`). The
return type for each operation is given by `return_type`.  -/
class Operations (α : Type) where
  ops : Type
  return_type : ops → Type

/- A conflict-free replicated data type (CRDT) provides three essential operations:
 - send a message to other replicas
 - receive a message from other replicas
 - do an operation on the current replica
Here, ρ denotes the type of the replica ids and τ is the timestamp type. -/
class Crdt (ρ τ α : Type) [Operations α] where
  state_type : Type
  message_type : Type
  init_state : ρ → state_type

  send : state_type → state_type × message_type
  receive : state_type → message_type → state_type
  do_op (op : Operations.ops α) : state_type → τ → state_type × (Operations.return_type op)
