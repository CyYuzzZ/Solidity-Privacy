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
 * @date 2018
 * Unit tests for JSON.h.
 */

#include <libsolutil/JSON.h>

#include <test/Common.h>

#include <boost/test/unit_test.hpp>

using namespace std;

namespace solidity::util::test
{

BOOST_AUTO_TEST_SUITE(JsonTest, *boost::unit_test::label("nooptions"))

BOOST_AUTO_TEST_CASE(json_pretty_print)
{
	Json::Value json;
	Json::Value jsonChild;

	jsonChild["3.1"] = "3.1";
	jsonChild["3.2"] = 2;
	json["1"] = 1;
	json["2"] = "2";
	json["3"] = jsonChild;

	BOOST_CHECK(
	"{\n"
	"  \"1\": 1,\n"
	"  \"2\": \"2\",\n"
	"  \"3\":\n"
	"  {\n"
	"    \"3.1\": \"3.1\",\n"
	"    \"3.2\": 2\n"
	"  }\n"
	"}" == jsonPrettyPrint(json));
}

BOOST_AUTO_TEST_CASE(json_compact_print)
{
	Json::Value json;
	Json::Value jsonChild;

	jsonChild["3.1"] = "3.1";
	jsonChild["3.2"] = 2;
	json["1"] = 1;
	json["2"] = "2";
	json["3"] = jsonChild;

	BOOST_CHECK("{\"1\":1,\"2\":\"2\",\"3\":{\"3.1\":\"3.1\",\"3.2\":2}}" == jsonCompactPrint(json));
}

BOOST_AUTO_TEST_CASE(parse_json_strict)
{
	Json::Value json;
	std::string errors;

	// just parse a valid json input
	BOOST_CHECK(jsonParseStrict("{\"1\":1,\"2\":\"2\",\"3\":{\"3.1\":\"3.1\",\"3.2\":2}}", json, &errors));
	BOOST_CHECK(json["1"] == 1);
	BOOST_CHECK(json["2"] == "2");
	BOOST_CHECK(json["3"]["3.1"] == "3.1");
	BOOST_CHECK(json["3"]["3.2"] == 2);

	// trailing garbage is not allowed in strict-mode
	BOOST_CHECK(!jsonParseStrict("{\"1\":2,\"2\":\"2\",\"3\":{\"3.1\":\"3.1\",\"3.2\":3}}}}}}}}}}", json, &errors));

	// comments are allowed in strict-mode? - that's strange...
	BOOST_CHECK(jsonParseStrict(
		"{\"1\":3, // awesome comment\n\"2\":\"2\",\"3\":{\"3.1\":\"3.1\",\"3.2\":5}}", json, &errors
	));
	BOOST_CHECK(json["1"] == 3);
	BOOST_CHECK(json["2"] == "2");
	BOOST_CHECK(json["3"]["3.1"] == "3.1");
	BOOST_CHECK(json["3"]["3.2"] == 5);

	// root element can only be object or array
	BOOST_CHECK(jsonParseStrict("[]", json, &errors));
	BOOST_CHECK(jsonParseStrict("{}", json, &errors));
	BOOST_CHECK(!jsonParseStrict("1", json, &errors));
	BOOST_CHECK(!jsonParseStrict("\"hello\"", json, &errors));

	// non-UTF-8 escapes allowed??
	BOOST_CHECK(jsonParseStrict("[ \"\x80\xec\x80\" ]", json, &errors));
	BOOST_CHECK(json[0] == "\x80\xec\x80");
}

BOOST_AUTO_TEST_SUITE_END()

}
