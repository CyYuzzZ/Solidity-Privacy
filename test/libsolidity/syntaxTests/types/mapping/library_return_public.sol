library L
{
    function f(mapping(uint => uint) storage a, mapping(uint => uint) storage b, bool c) public pure returns(mapping(uint => uint) storage) {
        return c ? a : b;
    }
}
// ----
