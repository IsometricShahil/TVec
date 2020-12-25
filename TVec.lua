-- Name: TVec.lua
-- Description: Simple, pooled, 2D vector library for Lua.
-- Author: Shahil Ahmed (FlamingArr)
-- Github: github.com/FlamingArr/TVec
--
-- The MIT License (MIT)
-- 
-- Copyright (c) 2020 Shahil Ahmed
-- 
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
-- 
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
-- 
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.

--assert(cond, msg) should be avoided completely for performance reasons.
--use `if not cond then error(msg [, 2]) end

--Also going nyoom with `ffi` is not a goal of this library as,
--it's hard to unify the jitted and non-jitted version

--Localizations
local type = type
local setmetatable = setmetatable
local getmetatable = getmetatable
local sin, cos = math.sin, math.cos
local atan2 = math.atan2 or math.atan
local sqrt = math.sqrt
local abs = math.abs
local pi, huge = math.pi, math.huge
local remove = table.remove
local insert = table.insert
local tau = pi*2

local Vec2 = {}
Vec2.__index = Vec2


local ffi
if jit and jit.status() and package.preload.ffi then
	ffi = require "ffi"
end

--Everyone knows this function by now
local function clamp(v, min, max)
	return v < min and min or (v > max and max or v)
end

--Yes, I AM lazy
local function err(msg)
	error(msg, 2)
end


local _create, vType
if ffi then
	vType = ffi.typeof("struct {double x, y}") --Metatype is set at the end
	_create = function() return vType() end
else
	_create = function() return setmetatable({}, Vec2) end
end
--_create is just the version specific vector constructor
--it doesn't set the x, y components



--The stack to hold freed vectors
local freeStack = {}

local function new(x, y)
	local v = remove(freeStack) --Pop from the stack of free vectors
	v = v or _create()
	
	--Convert x and y to either a number or nil
	x = tonumber(x)
	y = tonumber(y)
	
	v.x = x or 0
	v.y = y or v.x
	return v
end

local isVector
if ffi then
	isVector = function(v)
		return type(v) == "cdata" and ffi.istype(v, vType)
	end
else
	isVector = function(v)
		return getmetatable(v) == Vec2
	end
end

local function fromAngle(r, l)
	r = tonumber(r)
	if not r then err("Number expected") end
	l = tonumber(l) or 1
	
	return new(cos(r) * l, sin(r) * l)
end

local function random(min, max)
	min = tonumber(min) or 0
	max = tonumber(max) or tau
	return fromAngle(Vec2.rand(min, max))
end

function Vec2:getAngle()
	local a = atan2(self.y, self.x)
	if a < 0 then a = a + tau end
	return a
end

function Vec2:setAngle(r)
	r = tonumber(r)
	if not r then err("Number expected") end
	
	local m = self:getMag()
	self.x = cos(r) * m
	self.y = sin(r) * m
	
	return self
end

function Vec2:getMag()
	return sqrt((self.x * self.x) + (self.y * self.y))
end

function Vec2:getMagSq() --Prefer this instead of (v:getMag()^2) for performance as it avoids a sqrt() and ^2
	return (self.x * self.x) + (self.y * self.y)
end

function Vec2:setMag(m)
	m = tonumber(m)
	if not m then err("Number expected") end
	
	self:normalize()
	self.x = self.x * m
	self.y = self.y * m
	return self
end

function Vec2:normalize()
	local v = self:getMag()
	if v ~= 0 then
		self.x = self.x / v
		self.y = self.y / v
	end
	return self
end
Vec2.normalise = normalize --Alias for variants of English


function Vec2:dot(b)
	if not isVector(b) then err("Vec2 expected") end
	return a.x * b.x + a.y * b.y
end

function Vec2:dist(b)
	if not isVector(b) then err("Vec2 expected") end
	return sqrt((a.x - b.x)*(a.x - b.x) + (a.y - b.y)*(a.y - b.y))
end

function Vec2:distSq(b)
	if not isVector(b) then err("Vec2 expected.") end
	return (a.x - b.x)*(a.x - b.x) + (a.y - b.y)*(a.y - b.y)
end

function Vec2:clampMag(min, max)
	min = tonumber(min)
	max = tonumber(max)
	
	if not (min and max) then
		err("Number expected")
	end
	
	local m = self:getMag()
	if m < min or m > max then
		self:setMag(clamp(m, min, max))
	end
	return self
end

function Vec2:limitMag(max)
	max = tonumber(max)
	if not max then err("Number expected") end
	
	self:clampMag(-huge, max)
	return self
end

function Vec2:clampAngle(min, max)
	min = tonumber(min)
	max = tonumber(max)
	
	if not (min and max) then
		err("Number expected")
	end
	
	local m = self:getAngle()
	if m < min or m > max then
		self:setAngle(clamp(m, min, max))
	end
	return self
end

function Vec2:limitAngle(max)
	max = tonumber(max)
	if not max then err("Number expected") end
	
	self:clampAngle(0, max)
	return self
end

function Vec2:set(x, y)
	x = tonumber(x)
	y = tonumber(y)
	
	self.x = x or self.x
	self.y = y or self.y
	return self
end

function Vec2:replace(v)
	if not isVector(v) then err("Vec2 expected") end
	self.x = v.x
	self.y = v.y
	return self
end

function Vec2:clone()
	return new(self.x, self.y)
end

function Vec2:unpack()
	return self.x, self.y
end

function Vec2:free()
	--Put this into the stack of free vectors
	table.insert(freeStack, self)
	return self
end

function Vec2.__eq(a, b)
	if not (isVector(a) or isVector(b)) then err("Vec2 expected") end
	return abs(a.x - b.x) < 1e-9 and --Using == on floating numbers is a sin
	       abs(a.y - b.y) < 1e-9
end

function Vec2.__unm(v)
	return new(-v.x, -v.y)
end

function Vec2.__tostring(v)
	return ("(%f, %f)"):format(v.x, v.y)
end

--Lazyness 101
--'NAME' is replaced with the name of the event (eg. 'add')
--'OP' is replaced with the operator of the event (eg. '+')

local sharedCode = [[
	function Vec2:NAME(b) --A general function, used like vec:add(v)
		if not (isVector(b) or tonumber(b)) then err("Vec2 or number expected") end
		if isVector(b) then
			self.x = self.x OP b.x
			self.y = self.y OP b.y
		else
			b = tonumber(b)
			self.x = self.x OP b
			self.y = self.y OP b
		end
	end
	
	function Vec2.__NAME(a, b) --Metamethod
		if isVector(b) and not isVector(a) then
			return b OP a --Reverse it
		end
		
		if not isVector(a) then err("Vec2 expected") end
		if not (isVector(b) or tonumber(b)) then err("Vec2 or number expected") end
		
		local nv
		if isVector(b) then
			nv = new(a.x OP b.x, a.y OP b.y)
		else
			nv = new(a.x OP b, a.y OP b)
		end
		
		return nv
	end
]]

local ops = { --The event names and their respective operators
	{"add", "+"},
	{"sub", "-"},
	{"mul", "*"},
	{"div", "/"},
	{"pow", "^"},
	{"mod", "%"},
}

local env = { --Environment to run the chunks in
	Vec2 = Vec2,
	new = new,
	isVector = isVector,
	tonumber = tonumber,
	err = err
}

for i = 1, #ops do
	local v = ops[i]
	
	--Do replacement
	local genCode = sharedCode:gsub("NAME", "%"..v[1])
	genCode = genCode:gsub("OP", "%"..v[2])
	
	--Load the chunk
	local chunk, msg = load(genCode, "metaChunk", "t", env)
	if not chunk then error(msg) end
	
	--Execute it
	chunk()
end

--Wrap Vec2.new(x, y) as Vec2(x, y)
setmetatable(Vec2, {
	__call = function(Vec2, x, y)
		return new(x, y)
	end
})

--Default to math.random
Vec2.rand = math.random

--Switch to love.math.random if avaliable
if type(love) == "table" and
   type(love.math) == "table" and
   type(love.math.random) == "function" then
	Vec2.rand = love.math.random
end

if ffi then
	ffi.metatype(vType, Vec2)
end

--Module packup
Vec2.new = new
Vec2.fromAngle = fromAngle
Vec2.fromPolar = fromAngle --Alias
Vec2.rand = math.random

return Vec2