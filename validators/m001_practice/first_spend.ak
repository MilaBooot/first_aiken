use cardano/transaction.{OutputReference, Transaction, placeholder}
use mocktail.{mock_utxo_ref}
use cardano/script_context.{ScriptContext, Minting}

validator my_first_spend {
  spend(
    _datum: Option<Data>,
    _redeemer: Data,
    _input: OutputReference,
    _tx: Transaction,
  ) {
    trace @"Spending validator called"
    True
  }

  else(_) {
    fail
  }
}

test test_my_first_spend() {
  my_first_spend.spend(None, Void, mock_utxo_ref(0, 0), placeholder)
}

test test_with_trace() {
  trace @"Testing spending validator"
  my_first_spend.spend(None, Void, mock_utxo_ref(0, 0), placeholder)
}


test test_wrong_purpose() fail {
  let context =
    ScriptContext {
      transaction: placeholder,
      redeemer: Void,
      info: Minting(#""),
    }
  !my_first_spend.else(context)
}