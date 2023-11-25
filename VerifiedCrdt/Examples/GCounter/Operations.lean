import VerifiedCrdt.Crdt

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

class Incrementable (α : Type) where
  increment : α → α
