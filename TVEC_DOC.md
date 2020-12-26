# API
### Module functions
* `TVec.new([x [, y]])` <br/>
Creates and returns a new vector. <br/>
`x` defaults to `0` and `y` defaults to `x`. <br/>

* `TVec.isVector(v)` <br/>
Returns true if `v` is a TVec vector, false otherwise. <br/>

* `TVec.fromAngle(r [, m])` <br/>
Creates and returns a new vector with the angle `r`. <br/>
`m` is the magnitude of the vector, defaults to 1. <br/>
**Alias**: `TVec.fromPolar`. <br/>

* `TVec.random(min, max)` <br/>
Creates and returns a new vector with a random angle and magnitude 1. <br/>
`min` is the minimum angle of the vector, defaults to 0. <br/>
`max` is maximum angle of the vector, defaults to 2Π. <br/>


### Vector methods
* `vec:getAngle()` <br/>
Returns the angle of the vector. <br/>

* `vec:setAngle(r)` <br/>
Sets the angle of the vector to `r`. <br/>

* `vec:getMag()` <br/>
Returns the magnitude of the vector. <br/>

* `vec:getMagSq()` <br/>
Returns the magnitude squared of the vector. <br/>

* `vec:setMag(m)` <br/>
Sets the magnitude of the vector to `m`. <br/>

* `vec:normalize()` <br/>
Normalizes the vector, i.e. sets is magnitude to 1. <br/>
**Alias**: `vec:normalize`. <br/>

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
The operators `+`, `-`, `*`, `/`, `^`, `%` can be applied to two vectors or a vector and a scalar. <br/>
The operator is applied component-wise and a new vector holding the result is returned. <br/>

The `==` operator can be used to check if two vectors are equal component-wise.
`tostring(vec)` returns a string representation of `vec`.