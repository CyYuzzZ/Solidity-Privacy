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

#include <test/libsolidity/SMTCheckerTest.h>
#include <test/Common.h>

using namespace std;
using namespace solidity;
using namespace solidity::langutil;
using namespace solidity::frontend;
using namespace solidity::frontend::test;

SMTCheckerTest::SMTCheckerTest(string const& _filename): SyntaxTest(_filename, EVMVersion{})
{
	auto const& choice = m_reader.stringSetting("SMTSolvers", "any");
	if (choice == "any")
		m_enabledSolvers = smtutil::SMTSolverChoice::All();
	else if (choice == "z3")
		m_enabledSolvers = smtutil::SMTSolverChoice::Z3();
	else if (choice == "cvc4")
		m_enabledSolvers = smtutil::SMTSolverChoice::CVC4();
	else if (choice == "none")
		m_enabledSolvers = smtutil::SMTSolverChoice::None();
	else
		BOOST_THROW_EXCEPTION(runtime_error("Invalid SMT solver choice."));

	auto available = ModelChecker::availableSolvers();
	if (!available.z3)
		m_enabledSolvers.z3 = false;
	if (!available.cvc4)
		m_enabledSolvers.cvc4 = false;

	auto engine = ModelCheckerEngine::fromString(m_reader.stringSetting("SMTEngine", "all"));
	if (engine)
		m_modelCheckerSettings.engine = *engine;
	else
		BOOST_THROW_EXCEPTION(runtime_error("Invalid SMT engine choice."));

	if (m_enabledSolvers.none() || m_modelCheckerSettings.engine.none())
		m_shouldRun = false;

	auto const& ignoreCex = m_reader.stringSetting("SMTIgnoreCex", "no");
	if (ignoreCex == "no")
		m_ignoreCex = false;
	else if (ignoreCex == "yes")
		m_ignoreCex = true;
	else
		BOOST_THROW_EXCEPTION(runtime_error("Invalid SMT counterexample choice."));
}

TestCase::TestResult SMTCheckerTest::run(ostream& _stream, string const& _linePrefix, bool _formatted)
{
	setupCompiler();
	compiler().setSMTSolverChoice(m_enabledSolvers);
	compiler().setModelCheckerSettings(m_modelCheckerSettings);
	parseAndAnalyze();
	filterObtainedErrors();

	return conclude(_stream, _linePrefix, _formatted);
}

void SMTCheckerTest::filterObtainedErrors()
{
	SyntaxTest::filterObtainedErrors();

	static auto removeCex = [](vector<SyntaxTestError>& errors) {
		for (auto& e: errors)
			if (
				auto cexPos = e.message.find("\\nCounterexample");
				cexPos != string::npos
			)
				e.message = e.message.substr(0, cexPos);
	};

	if (m_ignoreCex)
		removeCex(m_errorList);
}
