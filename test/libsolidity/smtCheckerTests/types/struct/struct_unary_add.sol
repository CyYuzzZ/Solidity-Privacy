pragma abicoder               v2;

contract C {
	struct S {
		uint x;
		uint[] a;
	}
	function f(S memory s1, S memory s2) public pure {
		delete s1;
		s1.x++;
		++s1.x;
		assert(s1.x == 2);
		assert(s1.x == s2.x);
	}
}
// ====
// SMTEngine: all
// SMTIgnoreCex: yes
// ----
// Warning 6328: (193-213): CHC: Assertion violation happens here.
