contract D {}
contract C {
  function foo(int a) external {
    this.foo{slt:5, value:3, salt: 8};
  }
}
// ----
// TypeError 9318: (64-97): Unknown call option "slt". Valid options are "salt", "value" and "gas".
// TypeError 7006: (64-97): Cannot set option "value" on a non-payable function type.
// TypeError 2721: (64-97): Function call option "salt" can only be used with "new".
