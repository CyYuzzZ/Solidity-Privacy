library L
{
	function add(uint x, uint y) internal pure returns (uint) {
		require(x < 1000);
		require(y < 1000);
		return x + y;
	}
}

contract C
{
	function f(uint x) public pure {
		uint y = L.add(x, 999);
		assert(y < 10000);
	}
}
// ====
// SMTEngine: all
// ----
