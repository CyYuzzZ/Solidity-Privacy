contract base {
    enum Choice {A, B, C}
}


contract test is base {
    function answer() public returns (Choice _ret) {
        _ret = Choice.B;
    }
}
// ====
// compileToEwasm: also
// compileViaYul: also
// ----
// answer() -> 1
