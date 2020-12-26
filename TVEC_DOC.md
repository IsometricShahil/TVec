# API
### Module functions
1. `TVec.new([x [, y]])` <br/>
Creates and returns a new vector. <br/>
`x`: X component of the vector, default to 0. <br/>
`y`: Y component of the vector, default to X. <br/>

2. `TVec.isVector(v)` <br/>
Returns true if `v` is a TVec vector, false otherwise. <br/>
`v`: The vector to check. <br/>

3. `TVec.fromAngle(r [, m])`
Creates and returns a vector with the angle `r` and magnitude `m`. <br/>
`r`: The angle of the vector. <br/>
`m`: The magnitude of the vector, defaults to 1. <br/>
**Alias**: `TVec.fromPolar`. <br/>

4. `TVec.random(min, max)` <br/>
Creates and returns a vector with a random angle and magnitude 1. <br/>
`min`: Minimum angle of the vector, defaults to 0. <br/>
`max`: Maximum angle of the vector, defaults to pi*2 or tau. <br/>