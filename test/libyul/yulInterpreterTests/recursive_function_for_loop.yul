{
        {
            let a := foo_0(calldataload(0))
            sstore(0, a)
        }
        function foo_0(x) -> y
        {
            y := 1
            mstore8(1, 1)
            for { } slt(1, keccak256(1, msize())) { let x_1 := foo_0(x) }
            {
                y := add(y, 1)
                continue
            }
        }
}
// ----
// Trace:
// Memory dump:
//      0: 0001000000000000000000000000000000000000000000000000000000000000
// Storage dump:
//   0000000000000000000000000000000000000000000000000000000000000000: 0000000000000000000000000000000000000000000000000000000000000002
