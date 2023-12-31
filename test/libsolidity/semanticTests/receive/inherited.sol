contract A {
    uint data;
    receive() external payable { ++data; }
    function getData() public returns (uint r) { return data; }
}
contract B is A {}
// ====
// compileToEwasm: also
// compileViaYul: also
// ----
// getData() -> 0
// () ->
// getData() -> 1
// (), 1 ether ->
// getData() -> 2
