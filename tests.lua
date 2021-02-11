local lust = require "lust.lust"
local describe = lust.describe
local it = lust.it
local expect = lust.expect


describe("TVec tests", function()
	it("Passing", function()
		expect(56).to.be(56)
	end)
	it("Failing", function()
		expect(50).to_not.be(50)
	end)
end)


if lust.errors > 0 then
	error("Some or all tests have failed.")
end