contract test {
    function fun(uint256 a) public {
        uint256 i =0;
        for (i = 0; i < 10; i++) {
            uint256 x = i; break; continue;
        }
    }
}
// ----
// Warning 5740: (103-106): Unreachable code.
// Warning 5740: (144-152): Unreachable code.
// Warning 5667: (33-42): Unused function parameter. Remove or comment out the variable name to silence this warning.
// Warning 2072: (122-131): Unused local variable.
// Warning 2018: (20-169): Function state mutability can be restricted to pure
