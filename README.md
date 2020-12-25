# TVec
1. Vector pooling.
2. Uses **FFI** where **JIT** is avaliable and enabled.
3. Flexible vector arithmatic. (ex. 3+v, v+3, v1+v2, v1:add(3), v1:add(v2))
4. Consistent getBlah/setBlah,:operation(b) style API.
5. Argument validation for all API functions, on invalid argument, throws a proper error message pointed to the proper line.
6. Prefers love.math.random over math.random, also lets you use your own random function. TVec doesn't validate your custom random function.
7. Various clamping methods.

# Installation
Copy TVec.lua into your project and require it. <br/>
Ex. `Vec2 = require "TVec"`

# Documentation
The API of TVec and it's quirks are documented in [TVEC_DOC.md]

# License
TVec.lua is licensed under the terms and condition of the MIT License.
See [LICENSE] for details.
(This is included at the top of TVec.lua for your convenience)
