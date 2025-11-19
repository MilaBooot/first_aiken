
// this is workshop m001 minting validator smart contract assignment


// import/use starts here

use cardano/assets.{PolicyId}
use cardano/transaction.{Transaction, placeholder}
use cardano/script_context.{ScriptContext, Minting}

// minting validator

validator m001_assignment_minting {
  // While spend have 4 params the minting is just 3
  // since the below params are started with _ underscore, void can be passed
  mint(
    _redeemer: Data,
    _policy_id: PolicyId,
    _tx: Transaction,
  ) {
    // trace print
    trace @"Workshop 1 assignment - minting validator called"
    True
  }

  else(_) {
    fail
  }
}


// Workshop m001 assignment minting validator test (without trace)

test test_m001_assignment_minting() {
  // Passing Void and empty token name for the minting
  m001_assignment_minting.mint(Void, #"", placeholder)
}

// This function is similar to the above test but with trace
test test_m001_assignment_minting_with_trace() {
  // trace print (when test run)
  trace @"Testing minting validator with trace"
  m001_assignment_minting.mint(Void, #"", placeholder)
}

// The below function is purposefully prepared to fail the test
test test_m001_assignment_minting_wrong() fail {
  let context =
    ScriptContext {
      transaction: placeholder,
      redeemer: Void,
      info: Minting(#""),
    }
  !m001_assignment_minting.else(context)
}