local lust = require "lust"
local Vec2 = require "TVec"
local describe, it, expect = lust.describe, lust.it, lust.expect

local v

describe("TVec", function()
	it("Vector creation", function()
		v = Vec2()
		expect(v.x).to.equal(0)
		expect(v.y).to.equal(0)
		
		v = Vec2(8)
		expect(v.x).to.equal(8)
		expect(v.y).to.equal(8)
		
		v = Vec2(3, 4)
		expect(v.x).to.equal(3)
		expect(v.y).to.equal(4)
	end)
end)