/*
	This file is part of solidity.

	solidity is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.

	solidity is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with solidity.  If not, see <http://www.gnu.org/licenses/>.
*/
// SPDX-License-Identifier: GPL-3.0
/**
 * Changes the topmost block to be a function with a specific name ("main") which has no
 * inputs nor outputs.
 */

#pragma once

#include <libyul/ASTForward.h>

namespace solidity::yul
{

struct OptimiserStepContext;

/**
 * Prerequisites: Function Grouper
 */
class MainFunction
{
public:
	static constexpr char const* name{"MainFunction"};
	static void run(OptimiserStepContext&, Block& _ast) { MainFunction{}(_ast); }

	void operator()(Block& _block);

private:
	MainFunction() = default;
};

}
