contract C
{
	uint x;
	function f() internal {
		require(x < 10000);
		x = x + 1;
	}
	function g(bool b) public {
		x = 0;
		if (b)
			f();
		// Should fail for `b == true`.
		assert(x == 0);
	}
}
// ====
// SMTEngine: all
// ----
// Warning 6328: (176-190): CHC: Assertion violation happens here.\nCounterexample:\nx = 1\nb = true\n\nTransaction trace:\nC.constructor()\nState: x = 0\nC.g(true)\n    C.f() -- internal call
