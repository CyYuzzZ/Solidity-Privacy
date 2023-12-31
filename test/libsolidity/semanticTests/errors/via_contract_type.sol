contract A {
  error E(uint);
}
contract X {
  error E(string);
}
contract B is A {
  function f() public pure { revert E(1); }
  function g() public pure  { revert A.E(1); }
  function h() public pure { revert X.E("abc"); }

}
// ====
// compileViaYul: also
// compileToEwasm: also
// ----
// f() -> FAILURE, hex"002ff067", hex"0000000000000000000000000000000000000000000000000000000000000001"
// g() -> FAILURE, hex"002ff067", hex"0000000000000000000000000000000000000000000000000000000000000001"
// h() -> FAILURE, hex"3e9992c9", hex"0000000000000000000000000000000000000000000000000000000000000020", hex"0000000000000000000000000000000000000000000000000000000000000003", hex"6162630000000000000000000000000000000000000000000000000000000000"
