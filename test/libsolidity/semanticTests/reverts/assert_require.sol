contract C {
    function f() public {
        assert(false);
    }

    function g(bool val) public returns (bool) {
        assert(val == true);
        return true;
    }

    function h(bool val) public returns (bool) {
        require(val);
        return true;
    }
}

// ====
// compileToEwasm: also
// compileViaYul: also
// ----
// f() -> FAILURE, hex"4e487b71", 0x01
// g(bool): false -> FAILURE, hex"4e487b71", 0x01
// g(bool): true -> true
// h(bool): false -> FAILURE
// h(bool): true -> true
