// Variable is reset in both branches
contract C {
    function f(uint x) public pure {
        uint a = 2;
        if (x > 10) {
            a = 3;
        } else {
            a = 4;
        }
        assert(a >= 3);
    }
}
// ====
// SMTEngine: all
// ----
