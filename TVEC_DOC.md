# TVec documentation
## Introduction
This documentation is divided into two sections.
The **API** part documents the functions, methods and metamethods provided by TVec, while
The **Quirks** part documents various information about `TVec`.
You are advised to read both of these sections.

## API
### Module functions
* `TVec.new([x [, y]])` <br/>
Creates and returns a new vector. <br/>
`x` defaults to `0` and `y` defaults to `x`. <br/>

* `TVec.isVector(v)` <br/>
Returns true if `v` is a TVec vector, false otherwise. <br/>

* `TVec.fromAngle(t [, m])` <br/>
Creates and returns a new vector with the angle `t`. <br/>
`m` is the magnitude of the vector, defaults to 1. <br/>
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
Rotates the vector by Π or 90°, significantly faster than `:setAngle` and `:rotate`. <br/>

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

* `vec:unpack()` <br/>
Returns the x and y components of `vec`. <br/>

### Vector metamethods
* The operators `+`, `-`, `*`, `/`, `^`, `%` can be applied to two vectors or a vector and a scalar. <br/>
Used operator is applied component-wise and a new vector holding the result is returned. <br/>
* The `==` operator can be used to check if two vectors are equal component-wise. <br/>
* `tostring(vec)` returns a string representation of `vec`.



## Quirks
* **All** angles are given/taken in [radians](https://en.m.wikipedia.org/wiki/Radian).
* Methods that don't seem to return anything, return `vec`, so you can do `vec:setAngle(3.14):setMag(4)`.
* You can pass strings where numbers are expected, TVec will use `tonumber()` to convert them, this also applies to metamethods. <br/>
Ex. `vec:setAngle("3.14")`, `"3" + vec` <br/>
* While TVec validates your arguments for required params, it doesn't do that for optional params, if you pass in an invalid value for an optional param, the default value is used.
* TVec picks `love.math.random` if it is avaliable, otherwise it uses `math.random`.
**TVec doesn't validate your random function.**
to make TVec use your own random function do, `TVec.rand = yourRandomFunction`,
when called this function should return a random value between 0 and 1.
