{
    mstore(0, mod(calldataload(0), exp(2, 8)))
}
// ----
// step: expressionSimplifier
//
// {
//     let _4 := 0
//     mstore(_4, and(calldataload(_4), 255))
// }
