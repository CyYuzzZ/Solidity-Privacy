contract C {
    function f(uint x) public pure {
        require(x == 2);
        uint y;
        // The loop condition is always true,
        // but since x is touched in the body
        // we can't infer that.
        for (; x == 2;) {
            x = 2;
        }
        // False positive due to resetting x.
        assert(x == 2);
    }
}
// ====
// SMTEngine: all
// SMTSolvers: z3
// ----
// Warning 2072: (83-89): Unused local variable.
