contract C {
    event E(string r);
    function deposit() public {
        emit E("HELLO WORLD");
    }
}
// ====
// compileViaYul: also
// ----
// deposit() ->
// ~ emit E(string): 0x20, 0x0b, "HELLO WORLD"
