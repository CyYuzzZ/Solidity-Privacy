contract C {
    function f(uint a, uint b, uint c, uint d, uint e) public returns (uint) {
        return a + b + c + d + e;
    }
}
// ====
// compileToEwasm: also
// compileViaYul: also
// ----
// f(uint256,uint256,uint256,uint256,uint256): 1, 1, 1, 1, 1
// # A comment on the function parameters. #
// -> 5
// f(uint256,uint256,uint256,uint256,uint256):
// 1,
// 1,
// 1,
// 1,
// 1
// -> 5
// # Should return sum of all parameters. #
