# TVec
Pooled, FFI-ed 2D vector library for Lua.

# Design
This library aims to take advantage of luaJIT's FFI (if avaliable) and pooling. </br>
Although inspiration is taken from [Processing's PVector](https://processing.org/reference/PVector.html) and [Vector.lua](https://github.com/themousery/vector.lua), the API is mostly incompatible.

# Installation
Copy TVec.lua into your project and require it.
Ex. `Vec2 = require "TVec"`

# Documentation
See [the documentation](https://github.com/FlamingArr/TVec/blob/main/TVEC_DOC.md).

# Todo
* Projection.
* Cross product.
* Mirroring.
* Angle between two vectors.
* Linear interpolation.

# Testing
TVec uses [lust](https://github.com/bjornbytes/lust) for it's unit tests. <br/>
To run the unit tests
1. Place lust beside the `tests.lua` file, a simple way to do that would be to run, `git clone https://github.com/bjornbytes/lust` <br/>
2. Run, `luajit tests.lua` or `lua tests.lua`.

Additionally, the test suite is run automatically with every commit or PR using:
* LuaJIT with jit enabled
* LuaJIT with jit disabled
* Lua5.4

See, [actions](https://github.com/FlamingArr/TVec/actions) for the results.

# Feedback
I will very much appreciate suggestions, bug reports and general feedback from you, you can provide your input [here](https://github.com/FlamingArr/TVec/issues).

# License
TVec.lua is licensed under the terms and condition of the MIT License.
See [LICENSE](LICENSE) for details.
(This is included at the top of TVec.lua for your convenience.)
