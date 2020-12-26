# API
### Module functions
* `TVec.new([x [, y]])` <br/>
Creates and returns a new vector. <br/>
`x` defaults to `0` and `y` defaults to `x`. <br/>

* `TVec.isVector(v)` <br/>
Returns true if `v` is a TVec vector, false otherwise. <br/>

* `TVec.fromAngle(r [, m])`
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



### Vector metamethods