{
  sstore(1, 7)
  sstore(2, sub(0, 1))
}
// ----
// Trace:
// Memory dump:
//      0: 0000000000000000000000000000000000000000000000000000000000000002
//     20: ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
// Storage dump:
//   0000000000000000000000000000000000000000000000000000000000000001: 0000000000000000000000000000000000000000000000000000000000000007
//   0000000000000000000000000000000000000000000000000000000000000002: ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
