contract test {
    function f() public returns (bool) {
        int256 x = -2**255;
        unchecked { assert(-x == x); }
        return true;
    }
}

// ====
// compileViaYul: also
// compileToEwasm: also
// ----
// f() -> true
