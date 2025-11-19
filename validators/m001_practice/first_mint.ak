
use cardano/assets.{PolicyId}
use cardano/transaction.{Transaction, placeholder}
use cardano/script_context.{ScriptContext, Minting}

validator my_first_mint {
  mint(
    _redeemer: Data,
    _policy_id: PolicyId,
    _tx: Transaction,
  ) {
    True
  }

  else(_) {
    fail
  }
}

test test_my_first_mint() {
  my_first_mint.mint(Void, #"", placeholder)
}

test test_minting_with_trace() {
  trace @"Testing minting validator with trace"
  my_first_mint.mint(Void, #"", placeholder)
}

test test_minting_wrong_purpose() fail {
  let context =
    ScriptContext {
      transaction: placeholder,
      redeemer: Void,
      info: Minting(#""),
    }
  !my_first_mint.else(context)
}