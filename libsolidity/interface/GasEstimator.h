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
 * @author Christian <c@ethdev.com>
 * @date 2015
 * Gas consumption estimator working alongside the AST.
 */

#pragma once

#include <liblangutil/EVMVersion.h>

#include <libevmasm/Assembly.h>
#include <libevmasm/GasMeter.h>

#include <array>
#include <map>
#include <vector>

namespace solidity::frontend
{

class ASTNode;
class FunctionDefinition;

struct GasEstimator
{
public:
	using GasConsumption = evmasm::GasMeter::GasConsumption;
	using ASTGasConsumption = std::map<ASTNode const*, GasConsumption>;
	using ASTGasConsumptionSelfAccumulated =
		std::map<ASTNode const*, std::array<GasConsumption, 2>>;

	explicit GasEstimator(langutil::EVMVersion _evmVersion): m_evmVersion(_evmVersion) {}

	/// @returns the estimated gas consumption by the (public or external) function with the
	/// given signature. If no signature is given, estimates the maximum gas usage.
	GasConsumption functionalEstimation(
		evmasm::AssemblyItems const& _items,
		std::string const& _signature = ""
	) const;

	/// @returns the estimated gas consumption by the given function which starts at the given
	/// offset into the list of assembly items.
	/// @note this does not work correctly for recursive functions.
	GasConsumption functionalEstimation(
		evmasm::AssemblyItems const& _items,
		size_t const& _offset,
		FunctionDefinition const& _function
	) const;

private:
	/// @returns the set of AST nodes which are the finest nodes at their location.
	static std::set<ASTNode const*> finestNodesAtLocation(std::vector<ASTNode const*> const& _roots);
	langutil::EVMVersion m_evmVersion;
};

}
