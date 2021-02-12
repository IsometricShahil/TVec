local lust = require "lust.lust"
local Vec2 = require "TVec"
local describe, it, expect = lust.describe, lust.it, lust.expect

describe("TVec tests", function()
	describe("General", function()
		it("Constructor", function()
				local v0 = Vec2()
				local v5 = Vec2(5)
				expect(v0).to.be(Vec2(0, 0))
				expect(v5).to.be(Vec2(5, 5))
		end)
		
		it("Type", function()
				local v = Vec2()
				expect(Vec2.isVector(v)).to.be(true)
				expect(Vec2.isVector({})).to.be(false)
				expect(Vec2.isVector(nil)).to.be(false)
		end)
		
		it("Pool", function()
				local v1 = Vec2()
				v1:free()
				expect(Vec2()).to.be(v1)
		end)
		
		it("Clone", function()
			local v1 = Vec2(10, 8)
			local v2 = v1:clone()
			
			expect(v1).to.be(v2)
			expect(rawequal(v1, v2)).to.be(false)
		end)
		
		it("Unpack", function()
			local v = Vec2(5, 8)
			local x, y = v:unpack()
			expect(x).to.be(5)
			expect(y).to.be(8)
		end)
		
		it("Set", function()
			local v = Vec2()
			v:set(1)
			v:set(nil, 7)
			expect(v).to.be(Vec2(1, 7))
		end)
	end)
	
	describe("Mathematical", function()
		it("From polar", function()
			local v = Vec2.fromAngle(math.pi, 8)
			expect(v).to.be(Vec2(-8, 0))
			
			v = Vec2.fromPolar(math.pi/2, 0)
			expect(v).to.be(Vec2())
		end)
		
		it("Angle", function()
			local v = Vec2(5, 0)
			v:setAngle(math.pi/2)
			expect(v).to.be(Vec2(0, 5))
			expect(v:getAngle()).to.be(math.pi/2)
		end)
		
		it("Rotation", function()
			local v = Vec2(10, 0)
			v:setAngle(math.pi/2)
			v:rotate(math.pi/2)
			expect(v:getAngle()).to.be(math.pi)
			v:rotate90()
			expect(v:getAngle()).to.be(math.pi*1.5)
		end)
		
		it("Normalize", function()
			local v = Vec2(8, 0)
			v:normalize()
			expect(v).to.be(Vec2(1, 0))
			
			v = Vec2()
			v:normalise()
			expect(v).to.be(Vec2())
		end)
		
		it("Magnitude", function()
			local v = Vec2(5, 0)
			v:setMag(10)
			expect(v).to.be(Vec2(10, 0))
			
			expect(v:getMag()).to.be(10)
			expect(v:getMagSq()).to.be(100)
		end)
		
		it("Distance", function()
			local v1 = Vec2(-8, 6)
			local v2 = Vec2(3, 7)
			local d = math.sqrt((-8 - 3)^2 + (6 - 7)^2) + 0.0 -- Convert to a float as well
			expect(v1:dist(v2)).to.be(d)
			expect(v1:distSq(v2)).to.be(d*d)
		end)
		
		it("Clamp", function()
			
		end)
		
		it("Dot", function()
			
		end)
	end)
end)


if lust.errors > 0 then
	error("Some or all of the tests have failed.")
end