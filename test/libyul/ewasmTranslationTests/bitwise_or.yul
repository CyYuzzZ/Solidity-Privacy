{
  sstore(0, or(0, 0))
  sstore(1, or(0, not(0)))
  sstore(2, or(0, 0xffffffffffffffff))
  sstore(3, or(0, 0xffffffffffffffffff00000000000000))
  sstore(4, or(0, 0xffffffffffffffffff00000000000000ffffffffffffffff))
  sstore(5, or(0, 0xffffffffffffffffff00000000000000ffffffffffffffff0000000000000000))
  sstore(6, or(0, 0xaaaaaaaaaaaaaa555555555555555555aa5555555555555aa555555555555555))
  sstore(7, or(
    0x5555555555550000aaaaaaaaaaaaaa000000aaaaaaaaa000000aaaaaaaaaaaaa,
    0xaaaaaaaaaaaaaa555555555555555555aa5555555555555aa555555555555555
  ))
}
// ----
// Trace:
// Memory dump:
//      0: 0000000000000000000000000000000000000000000000000000000000000007
//     20: ffffffffffffaa55ffffffffffffff55aa55fffffffff55aa55fffffffffffff
// Storage dump:
//   0000000000000000000000000000000000000000000000000000000000000001: ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
//   0000000000000000000000000000000000000000000000000000000000000002: 000000000000000000000000000000000000000000000000ffffffffffffffff
//   0000000000000000000000000000000000000000000000000000000000000003: 00000000000000000000000000000000ffffffffffffffffff00000000000000
//   0000000000000000000000000000000000000000000000000000000000000004: 0000000000000000ffffffffffffffffff00000000000000ffffffffffffffff
//   0000000000000000000000000000000000000000000000000000000000000005: ffffffffffffffffff00000000000000ffffffffffffffff0000000000000000
//   0000000000000000000000000000000000000000000000000000000000000006: aaaaaaaaaaaaaa555555555555555555aa5555555555555aa555555555555555
//   0000000000000000000000000000000000000000000000000000000000000007: ffffffffffffaa55ffffffffffffff55aa55fffffffff55aa55fffffffffffff
