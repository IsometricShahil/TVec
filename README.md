# TVec
Pooled, FFI-ed 2D vector library for Lua. <br/>

# Design
I originally started writing this library to have a vector lib that utilizes both FFI structs and pooling.
This library should have a easy to digest api and friendly design. <br/>
Although inspiration is taken from [Processing's PVector](https://processing.org/reference/PVector.html) and [Vector.lua](https://github.com/themousery/vector.lua), I don't guarantee full compatability with them.

2. Uses **FFI** where **JIT** is avaliable and enabled.
3. Flexible vector arithmatic. (ex. `3+v`, `v+3`, `v+"3"`, `"3"+v`, `v1+v2`, `v1:add(3)`,`v1:add("3")`, `v1:add(v2)`)
4. Consistent `:getBlah`/`:setBlah`,`:operation([b])` style API.
5. Argument validation for required params in all API functions, on invalid argument, throws a proper error message pointed to the proper line.
6. Prefers `love.math.random` over `math.random`, also lets you use your own random function.
7. Accepts strings as numbers. (anything convertable with `tonumber(v)` works.)

# Installation
Copy TVec.lua into your project and require it. <br/>
Ex. `Vec2 = require "TVec"`

# Documentation
The API of TVec and it's quirks are documented in the [doc file](https://github.com/FlamingArr/TVec/blob/main/TVEC_DOC.md).

# Todo
1. `__pairs` metamethod. (Will make FFI version of TVec more compatible with exisiting lua code such as [flux](https://github.com/rxi/flux).)
2. Projection.
3. Cross product.
4. Mirroring.
5. Angle between two vectors.
6. Linear interpolation.
7. `:copy` alias for `:clone`.

# Feedback
I will very much appreciate suggestions, bug reports and general feedback from others, you can provide your input in [here](https://github.com/FlamingArr/TVec/issues).

# License
TVec.lua is licensed under the terms and condition of the MIT License.
See [LICENSE](LICENSE) for details.
(This is included at the top of TVec.lua for your convenience.)
