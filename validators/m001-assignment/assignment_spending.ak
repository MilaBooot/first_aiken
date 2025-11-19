
// this is workshop 1 m001 spending validator smart contract assignment


// import/use starts here
use cardano/transaction.{OutputReference, Transaction, placeholder}
use mocktail.{mock_utxo_ref}
use cardano/script_context.{ScriptContext, Minting}

// main validator function

validator m001_assignment_spend {
  spend(
    _datum: Option<Data>,
    _redeemer: Data,
    _input: OutputReference,
    _tx: Transaction,
  ) {
    // trace print
    trace @"Workshop 1 assignment - spending validator called"
    True
  }

  else(_) {
    fail
  }
}

// Workshop 1 m001 assignment spending validator test (without trace)
test test_m001_assignment_spend() {
  // 4 params are required for spending
  m001_assignment_spend.spend(None, Void, mock_utxo_ref(0, 0), placeholder)
}

test test_m001_assignment_spending_with_trace() {
  // trace print (when test run)
  trace @"Testing workshop 1 m001 spending validator"

  // 4 params are required for spending
  m001_assignment_spend.spend(None, Void, mock_utxo_ref(0, 0), placeholder)
}

// this test is purposefully prepared to fail
test test_fail_m001_assignment_spending() fail {
  let context =
    ScriptContext {
      transaction: placeholder,
      redeemer: Void,
      info: Minting(#""),
    }
  !m001_assignment_spend.else(context)
}