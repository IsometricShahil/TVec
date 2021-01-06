-- Name: TVec.lua
-- Description: Simple, pooled, 2D vector library for Lua.
-- Author: Shahil Ahmed (FlamingArr)
-- Github: github.com/FlamingArr/TVec
--
-- The MIT License (MIT)
-- 
-- Copyright (c) 2021 Shahil Ahmed
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

--assert(cond, msg) should be avoided completely to not generate garbage.
--use `if not cond then error(msg [, 2]) end

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

local MAX_FREE = 100 --Maximum number of freed vectors to hold in stack

local TVec = {}
TVec.__index = TVec


local ffi

--We use ffi structs if:
--1. JIT exists at all.
--2. JIT is enabled.
--3. FFI exists.
if jit and jit.status() and package.preload.ffi then
	ffi = require "ffi"
end

--C L A M P
local function clamp(v, min, max)
	return v < min and min or (v > max and max or v)
end

--Shortcut, keeps my fingers sane
local function err(msg)
	error(msg, 3)
end


local _create, vType
if ffi then
	vType = ffi.typeof("struct {double x, y;}") --Metatype is set at the end
	_create = function() return vType() end
else
	_create = function() return setmetatable({}, TVec) end
end
--_create is just the version specific vector constructor
--it doesn't set the x, y components



--The stack to hold freed vectors
local freeStack = {}

local function new(x, y)
	local v = remove(freeStack) --Pop from the stack of free vectors
	v = v or _create() --If the stack was empty then v will be nil, construct a new vector in that case
	
	--Convert x and y to a number
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
		return getmetatable(v) == TVec
	end
end

local function fromAngle(t, m)
	t = tonumber(t)
	if not t then err("Number expected") end
	m = tonumber(m) or 1
	
	return new(cos(t) * m, sin(t) * m)
end

local function random(min, max)
	min = tonumber(min) or 0
	max = tonumber(max) or tau
	
	local t = min + (max - min) * TVec.rand()
	return fromAngle(t)
end

function TVec:getAngle()
	local t = atan2(self.y, self.x)
	if t < 0 then t = t + tau end
	return t
end

function TVec:setAngle(t)
	t = tonumber(t)
	if not t then err("Number expected") end
	
	local m = self:getMag()
	self.x = cos(t) * m
	self.y = sin(t) * m
	
	return self
end

function TVec:getMag()
	return sqrt((self.x * self.x) + (self.y * self.y))
end

function TVec:getMagSq()
	return (self.x * self.x) + (self.y * self.y)
end

function TVec:setMag(m)
	m = tonumber(m)
	if not m then err("Number expected") end
	
	self:normalize()
	self.x = self.x * m
	self.y = self.y * m
	return self
end

function TVec:normalize()
	local v = self:getMag()
	if v ~= 0 then
		self.x = self.x / v
		self.y = self.y / v
	end
	return self
end
TVec.normalise = normalize --Alias

function TVec:rotate(t)
	t = tonumber(t)
	if not t then err("Number expected") end
	
	local oldT = self:getAngle()
	self:setAngle(oldT+t)
	return self
end

function TVec:rotate90()
	self:set(-self.y, self.x)
	return self
end

function TVec:dot(b)
	if not isVector(b) then err("TVec expected") end
	return a.x * b.x + a.y * b.y
end

function TVec:dist(b)
	if not isVector(b) then err("TVec expected") end
	local xd = a.x - b.x
	local yd = a.y - b.y
	return sqrt(xd * xd + yd * yd)
end

function TVec:distSq(b)
	if not isVector(b) then err("TVec expected.") end
	local xd = a.x - b.x
	local yd = a.y - b.y
	return xd * xd + yd * yd
end

function TVec:clampMag(min, max)
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

function TVec:clampAngle(min, max)
	min = tonumber(min)
	max = tonumber(max)
	
	if not (min and max) then
		err("Number expected")
	end
	
	local t = self:getAngle()
	if t < min or t > max then
		self:setAngle(clamp(t, min, max))
	end
	return self
end

function TVec:clone()
	return new(self.x, self.y)
end

function TVec:unpack()
	return self.x, self.y
end

function TVec:set(x, y)
	x = tonumber(x)
	y = tonumber(y)
	
	if x then self.x = x end
	if y then self.y = y end
end

function TVec:free()
	for i = 1, MAX_FREE do
		if freeStack[i] == nil then
			freeStack[i] = self
			break
		end
		
		if freeStack[i] == self then
			err("Vector is already freed")
		end
	end
	
	return self
end

function TVec.__eq(a, b)
	if not (isVector(a) and isVector(b)) then err("TVec expected") end
	return abs(a.x - b.x) < 1e-9 and --Using == on floating numbers is a sin
	       abs(a.y - b.y) < 1e-9
end

function TVec.__unm(v)
	return new(-v.x, -v.y)
end

function TVec.__tostring(v)
	return ("(%f, %f)"):format(v.x, v.y)
end

--Lazyness 101
--'NAME' is replaced with the name of the event (eg. 'add')
--'OP' is replaced with the operator of the event (eg. '+')

local sharedCode = [[
	function TVec:NAME(b) --An inline method, used like vec:add(v)
		if not (isVector(b) or tonumber(b)) then err("TVec or number expected") end
		if isVector(b) then
			self.x = self.x OP b.x
			self.y = self.y OP b.y
		else
			b = tonumber(b)
			self.x = self.x OP b
			self.y = self.y OP b
		end
		
		return self
	end
	
	function TVec.__NAME(a, b) --Metamethod
		if isVector(b) and not isVector(a) then
			return b OP a --Reverse it
		end
		
		if not isVector(a) then err("TVec expected") end
		if not (isVector(b) or tonumber(b)) then err("TVec or number expected") end
		
		local nv
		if isVector(b) then
			nv = new(a.x OP b.x, a.y OP b.y)
		else
			b = tonumber(b)
			nv = new(a.x OP b, a.y OP b)
		end
		
		return nv
	end
]]

local ops = {
	--Format: {Event, Operator}
	{"add", "+"},
	{"sub", "-"},
	{"mul", "*"},
	{"div", "/"},
	{"pow", "^"},
	{"mod", "%"},
}

local env = { --Environment to run the chunks in
	TVec = TVec,
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

--Don't hold these in memory
ops = nil
env = nil

--Wrap TVec.new(x, y) as TVec(x, y)
setmetatable(TVec, {
	__call = function(_, x, y)
		return new(x, y)
	end
})

--Default to math.random
TVec.rand = math.random

--Switch to love.math.random if avaliable
if type(love) == "table" and
   type(love.math) == "table" and
   type(love.math.random) == "function" then
	TVec.rand = love.math.random
end

if ffi then
	ffi.metatype(vType, TVec)
end

--Module packup
TVec.new = new
TVec.isVector = isVector
TVec.fromAngle = fromAngle
TVec.fromPolar = fromAngle --Alias
TVec.random = random
TVec.rand = math.random

TVec._stack = freeStack --In case, you feel like... "messing"
return TVec