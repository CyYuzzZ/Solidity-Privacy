{
    if calldataload(0) { sstore(0, 1) }
    if add(calldataload(0), calldataload(1)) { sstore(0, 2) }
}
// ----
// step: wordSizeTransform
//
// {
//     let _1_0 := 0
//     let _1_1 := 0
//     let _1_2 := 0
//     let _1_3 := 0
//     let _2_0, _2_1, _2_2, _2_3 := calldataload(_1_0, _1_1, _1_2, _1_3)
//     if or_bool(_2_0, _2_1, _2_2, _2_3)
//     {
//         let _3_0 := 0
//         let _3_1 := 0
//         let _3_2 := 0
//         let _3_3 := 1
//         let _4_0 := 0
//         let _4_1 := 0
//         let _4_2 := 0
//         let _4_3 := 0
//         sstore(_4_0, _4_1, _4_2, _4_3, _3_0, _3_1, _3_2, _3_3)
//     }
//     let _5_0 := 0
//     let _5_1 := 0
//     let _5_2 := 0
//     let _5_3 := 1
//     let _6_0, _6_1, _6_2, _6_3 := calldataload(_5_0, _5_1, _5_2, _5_3)
//     let _7_0 := 0
//     let _7_1 := 0
//     let _7_2 := 0
//     let _7_3 := 0
//     let _8_0, _8_1, _8_2, _8_3 := calldataload(_7_0, _7_1, _7_2, _7_3)
//     let _9_0, _9_1, _9_2, _9_3 := add(_8_0, _8_1, _8_2, _8_3, _6_0, _6_1, _6_2, _6_3)
//     if or_bool(_9_0, _9_1, _9_2, _9_3)
//     {
//         let _10_0 := 0
//         let _10_1 := 0
//         let _10_2 := 0
//         let _10_3 := 2
//         let _11_0 := 0
//         let _11_1 := 0
//         let _11_2 := 0
//         let _11_3 := 0
//         sstore(_11_0, _11_1, _11_2, _11_3, _10_0, _10_1, _10_2, _10_3)
//     }
// }
