{
    let a := mload(0)
    if mload(1)
    {
        a := mload(1)
        a := mload(2)
        a := mload(3)
    }
    mstore(a, 0)
}
// ----
// step: ssaAndBack
//
// {
//     let a := mload(0)
//     if mload(1) { a := mload(3) }
//     mstore(a, 0)
// }
