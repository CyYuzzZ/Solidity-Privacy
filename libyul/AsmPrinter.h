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
 * @date 2017
 * Converts a parsed assembly into its textual form.
 */

#pragma once

#include <libyul/ASTForward.h>

#include <libyul/YulString.h>

namespace solidity::yul
{
struct Dialect;

/**
 * Converts a parsed Yul AST into readable string representation.
 * Ignores source locations.
 * If a dialect is provided, the dialect's default type is omitted.
 */
class AsmPrinter
{
public:
	AsmPrinter() {}
	explicit AsmPrinter(Dialect const& _dialect): m_dialect(&_dialect) {}

	std::string operator()(Literal const& _literal) const;
	std::string operator()(Identifier const& _identifier) const;
	std::string operator()(ExpressionStatement const& _expr) const;
	std::string operator()(Assignment const& _assignment) const;
	std::string operator()(VariableDeclaration const& _variableDeclaration) const;
	std::string operator()(FunctionDefinition const& _functionDefinition) const;
	std::string operator()(FunctionCall const& _functionCall) const;
	std::string operator()(If const& _if) const;
	std::string operator()(Switch const& _switch) const;
	std::string operator()(ForLoop const& _forLoop) const;
	std::string operator()(Break const& _break) const;
	std::string operator()(Continue const& _continue) const;
	std::string operator()(Leave const& _continue) const;
	std::string operator()(Block const& _block) const;

private:
	std::string formatTypedName(TypedName _variable) const;
	std::string appendTypeName(YulString _type, bool _isBoolLiteral = false) const;

	Dialect const* m_dialect = nullptr;
};

}
