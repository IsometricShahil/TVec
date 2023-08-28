# TVec documentation
## Introduction
This documentation is divided into two sections. The **API** part documents the functions, methods and metamethods provided by TVec, while
the **General** part documents various aspects of `TVec`.

`f(x)` means `x` is a required parameter which you must pass in.
`f([x])` means `x` is an optional parameter which defaults to some value.

## API
### Module functions
* `TVec.new([x [, y]])` <br/>
Creates and returns a new vector. <br/>
`x` defaults to `0` and `y` defaults to `x`. <br/>
**Alias**: `TVec()` <br/>

* `TVec.isVector(v)` <br/>
Returns true if `v` is a TVec vector, false otherwise. <br/>

* `TVec.fromAngle(t [, m])` <br/>
Creates and returns a new vector with the angle `t` and magnitude `m`. <br/>
`m` defaults to 1. <br/>
**Alias**: `TVec.fromPolar`. <br/>

* `TVec.random(min, max)` <br/>
Creates and returns a new vector with a random angle and magnitude 1. <br/>
`min` is the minimum angle of the vector, defaults to 0. <br/>
`max` is maximum angle of the vector, defaults to 2Π. <br/>


### Vector methods
* `vec:getAngle()` <br/>
Returns the angle of the vector. <br/>

* `vec:setAngle(t)` <br/>
Sets the angle of the vector to `t`. <br/>

* `vec:getMag()` <br/>
Returns the magnitude of the vector. <br/>

* `vec:getMagSq()` <br/>
Returns the magnitude squared of the vector. <br/>

* `vec:setMag(m)` <br/>
Sets the magnitude of the vector to `m`. <br/>

* `vec:normalize()` <br/>
Normalizes the vector, i.e. sets is magnitude to 1. <br/>
**Alias**: `vec:normalise`. <br/>

* `vec:rotate(t)` <br/>
Rotates the vector by `t`.

* `vec:rotate90()` <br/>
Rotates the vector by Π or 90°, **slightly faster** than `:setAngle` and `:rotate`. <br/>

* `vec:dot(b)` <br/>
Returns the [dot product](https://en.m.wikipedia.org/wiki/Dot_product) of `vec` and `b`. <br/>

* `vec:dist(b)` <br/>
Returns the distance between `vec` and `b`. <br/>

* `vec:distSq(b)` <br/>
Returns the distance squared between `vec` and `b`. <br/>

* `vec:clampAngle(min, max)` <br/>
Clamps the angle of the vector between `min` and `max`. <br/>

* `vec:clampMag(min, max)` <br/>
Clamps the magnitude of the vector between `min` and `max`. <br/>

* `vec:clone()` <br/>
Returns a copy of `vec`. <br/>
**Alias**: `vec:copy()`. <br/>

* `vec:unpack()` <br/>
Returns the x and y components of `vec`. <br/>

* `vec:set([x [, y]])` <br/>
If `x` is given, sets the x component to `x`, else keeps it unchanged.
Same for `y`.

* `vec:free()` <br/>
Frees the vector, i.e. stores it in a pool so it can be re-used.
Recommended for vectors that are created and thrown away every frame.

* `vec:add(b)` <br/>
Performs component-wise addition with `vec` and `b`.
`b` can be a number or a TVec.
Similiary, there are `sub`, `mul`, `div`, `mod`, `pow`.

### Vector metamethods
* The operators `+`, `-`, `*`, `/`, `^`, `%` can be applied to two vectors or a vector and a scalar. <br/>
Used operator is applied component-wise and a new vector holding the result is returned. <br/>
* The `==` operator can be used to check if two vectors are equal component-wise. <br/>
* `tostring(vec)` returns a string representation of `vec`.
* TVec vectors are fully iterable with `pairs()` regardless of the vectors being ffi structs or plain lua tables. (thanks to `__pairs`)

## General
* **All** angles are given/taken in [radians](https://en.m.wikipedia.org/wiki/Radian).
* All the methods but not the metamethods modify the same object that is calling it. You can do something like `v:clone():setMag(2)` to get a new vector with the applied changes.
* Methods that don't seem to return anything, return the vector itself, so you can do `vec:setAngle(3.14):setMag(4)`.
* You can pass strings where numbers are expected, TVec will use `tonumber()` to convert them, this also applies to metamethods. <br/>
Ex. `vec:setAngle("3.14")`, `"3" + vec` <br/>
* TVec uses a custom `__pairs` metamethod to support iterating on vectors with `pairs()` even when jit is enabled, i.e. when FFI structs are used. This keeps the library compatible with existing lua libraries such as [flux](https://github.com/rxi/flux).
* While TVec validates your arguments for required params, it doesn't do that for optional params, if you pass in an invalid value for an optional param, the default value will be used.
* TVec picks `love.math.random` if it is avaliable, otherwise it uses `math.random`.
to make TVec use your own random function do, `TVec.rand = yourRandomFunction`,
when called this function should return a random value between 0 and 1.
**TVec doesn't validate your random function.**
