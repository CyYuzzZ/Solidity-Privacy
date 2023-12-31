contract test {
    function f(uint x) public pure returns (uint, int) {
        unchecked {
            uint a = 2 ** x;
            int b = -2 ** x;
            return (a, b);
        }
    }
}
// ====
// compileViaYul: also
// compileToEwasm: also
// ----
// f(uint256): 0 -> 1, 1
// f(uint256): 1 -> 2, -2
// f(uint256): 2 -> 4, 4
// f(uint256): 13 -> 0x2000, -8192
// f(uint256): 113 -> 0x020000000000000000000000000000, -10384593717069655257060992658440192
// f(uint256): 114 -> 0x040000000000000000000000000000, 20769187434139310514121985316880384
// f(uint256): 1113 -> 0x00, 0
// f(uint256): 1114 -> 0x00, 0
