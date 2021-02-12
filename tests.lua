local lust = require "lust.lust"
local Vec2 = require "TVec"
local describe, it, expect = lust.describe, lust.it, lust.expect

describe("TVec tests", function()
	it("Constructor", function()
		local v0 = Vec2()
		local v5= Vec2(5)
		expect(v0).to.be(Vec2(0, 0))
		expect(v5).to.be(Vec2(5, 5))
	end)
	
	it("Type check", function()
		local v = Vec2()
		expect(Vec2.isVector(v)).to.be(true)
		expect(Vec2.isVector({})).to.be(false)
		expect(Vec2.isVector(nil)).to.be(false)
	end)
end)


if lust.errors > 0 then
	error("Some or all of the tests have failed.")
end