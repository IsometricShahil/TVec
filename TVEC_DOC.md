# API
### Module functions
* `TVec.new([x [, y]])` <br/>
Creates and returns a new vector. <br/>
`x` defaults to `0` and `y` defaults to x. <br/>

* `TVec.isVector(v)` <br/>
Returns true if `v` is a TVec vector, false otherwise. <br/>

* `TVec.fromAngle(r [, m])`
Creates and returns a new vector with the angle `r`. <br/>
`m` is the magnitude of the vector, defaults to 1. <br/>
**Alias**: `TVec.fromPolar`. <br/>

* `TVec.random(min, max)` <br/>
Creates and returns a new vector with a random angle and magnitude 1. <br/>
`min`: Minimum angle of the vector, defaults to 0. <br/>
`max`: Maximum angle of the vector, defaults to 2Π. <br/>


### Vector methods
* `vec:getAngle()`
Returns the angle of the vector.
* `vec:setAngle(r)`
Sets the angle of the vector to `r`.
* `vec:getMag()`

* `vec:getMagSq()`

* `vec:setMag(m)`

* `vec:normalize()`



### Vector metamethods