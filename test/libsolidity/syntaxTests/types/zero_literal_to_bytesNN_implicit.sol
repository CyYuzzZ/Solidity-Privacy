contract C {
    function f() public pure {
      bytes1 b1 = 0;
      bytes2 b2 = 0;
      bytes3 b3 = 0;
      bytes4 b4 = 0;
      bytes8 b8 = 0;
      bytes16 b16 = 0;
      bytes32 b32 = 0;
      b1; b2; b3; b4; b8; b16; b32;
    }
    function g() public pure {
      bytes1 b1 = 0x000;
      bytes2 b2 = 0x00000;
      bytes3 b3 = 0x0000000;
      bytes4 b4 = 0x000000000;
      bytes8 b8 = 0x00000000000000000;
      b1; b2; b3; b4; b8;
    }
    function h() public pure {
      bytes1 b1 = 0x0;
      bytes2 b2 = 0x0;
      bytes3 b3 = 0x0;
      bytes4 b4 = 0x0;
      bytes8 b8 = 0x0;
      bytes16 b16 = 0x0;
      bytes32 b32 = 0x0;
      b1; b2; b3; b4; b8; b16; b32;
    }
}
// ----
