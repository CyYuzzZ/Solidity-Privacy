contract C {
	uint x;
	address owner;

	modifier onlyOwner {
		if (msg.sender == owner) {
			require(x > 0);
			_;
		}
	}

	function f() public onlyOwner {
		// Condition is always true due to `require(x > 0)` in the modifier.
		if (x > 0)
			x -= 1;
	}
	function g(uint y) public {
		x = 2;
		if (y > 0)
			f();
		assert(x > 0);
	}
}
// ====
// SMTEngine: all
// ----
// Warning 6838: (233-238): BMC: Condition is always true.
