import VerifiedCrdt.Crdt

/- A positive-negative counter supports three replica-local operations:
 - read the counter value
 - increment the counter value
 - decrement the counter value -/
inductive PNCounterOp where
  | Read
  | Increment
  | Decrement

instance PNCounterOps (α : Type) : Operations α where
  ops := PNCounterOp
  return_type op := match op with
    | PNCounterOp.Read => α
    | PNCounterOp.Increment => Unit
    | PNCounterOp.Decrement => Unit
