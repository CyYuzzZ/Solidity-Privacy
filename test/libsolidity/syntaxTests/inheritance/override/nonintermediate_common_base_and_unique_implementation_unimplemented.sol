interface I {
	function f() external;
	function g() external;
}
interface J {
	function f() external;
}
abstract contract IJ is I, J {
	function f() external virtual override (I, J);
}
abstract contract A is IJ
{
	function f() external virtual override;
}
abstract contract B is IJ
{
	function g() external override {}
}
abstract contract C is A, B {}
// ----
