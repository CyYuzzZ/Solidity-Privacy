{
  sstore(0, slt(0, 1))
  sstore(1, slt(0, not(0)))
  sstore(2, slt(0, 0))
  sstore(3, slt(1, 2))
  sstore(4, slt(not(0), 0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe))
  sstore(5, slt(0x8000000000000000000000000000000000000000000000000000000000000000, not(0)))
  sstore(6, slt(not(0), 0x8000000000000000000000000000000000000000000000000000000000000000))
  sstore(7, slt(0x7000000000000000000000000000000000000000000000000000000000000000, 1))
  sstore(8, slt(1, 0x7000000000000000000000000000000000000000000000000000000000000000))
  sstore(9, slt(0x7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff, not(0)))
  sstore(10, slt(not(0), 0x7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff))
  sstore(11, slt(0x7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff, 1))
  sstore(12, slt(1, 0x7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff))
  sstore(13, slt(
    0x7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff,
    0x8fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
  ))
  sstore(14, slt(
    0x8fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff,
    0x7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
  ))
  sstore(15, slt(
    0x7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff,
    not(0)
  ))
  sstore(16, slt(
    not(0),
    0x7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
  ))
  sstore(17, slt(
    not(0),
    0x8fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
  ))
  sstore(18, slt(
    0x8fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff,
    not(0)
  ))

}
// ----
// Trace:
// Memory dump:
//      0: 0000000000000000000000000000000000000000000000000000000000000012
//     20: 0000000000000000000000000000000000000000000000000000000000000001
// Storage dump:
//   0000000000000000000000000000000000000000000000000000000000000000: 0000000000000000000000000000000000000000000000000000000000000001
//   0000000000000000000000000000000000000000000000000000000000000003: 0000000000000000000000000000000000000000000000000000000000000001
//   0000000000000000000000000000000000000000000000000000000000000005: 0000000000000000000000000000000000000000000000000000000000000001
//   0000000000000000000000000000000000000000000000000000000000000008: 0000000000000000000000000000000000000000000000000000000000000001
//   000000000000000000000000000000000000000000000000000000000000000a: 0000000000000000000000000000000000000000000000000000000000000001
//   000000000000000000000000000000000000000000000000000000000000000c: 0000000000000000000000000000000000000000000000000000000000000001
//   000000000000000000000000000000000000000000000000000000000000000e: 0000000000000000000000000000000000000000000000000000000000000001
//   0000000000000000000000000000000000000000000000000000000000000010: 0000000000000000000000000000000000000000000000000000000000000001
//   0000000000000000000000000000000000000000000000000000000000000012: 0000000000000000000000000000000000000000000000000000000000000001
