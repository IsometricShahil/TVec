# TVec
Pooled, FFI-ed 2D vector library for Lua. <br/>

# Design
I originally started writing this library to have a vector library that utilizes both FFI structs and pooling. <br/>
This library should have an easy to digest API and friendly design. <br/>
Although inspiration is taken from [Processing's PVector](https://processing.org/reference/PVector.html) and [Vector.lua](https://github.com/themousery/vector.lua), I don't guarantee full compatability with them.

# Installation
Copy TVec.lua into your project and require it. <br/>
Ex. `Vec2 = require "TVec"`

# Documentation
The API of TVec and it's quirks are documented in the [doc file](https://github.com/FlamingArr/TVec/blob/main/TVEC_DOC.md).

# Todo
* Projection.
* Cross product.
* Mirroring.
* Angle between two vectors.
* Linear interpolation.

# Testing
TVec uses [lust](https://github.com/bjornbytes/lust) for it's unit testing. <br/>
To run the unit tests you must place lust beside the `tests.lua` file and then run, <br/>
`$ luajit tests.lua`. <br/>
`luajit` can be `lua` too (or.. whatever "lua" you have brewed..). <br/>
Additionally, the test suite is run automatically with every commit or PR using:-
* LuaJIT with jit enabled
* LuaJIT with jit disabled
* Lua5.4

See, [actions](https://github.com/FlamingArr/TVec/actions) for the results.

# Feedback
I will very much appreciate suggestions, bug reports and general feedback from others, you can provide your input in [here](https://github.com/FlamingArr/TVec/issues).

# License
TVec.lua is licensed under the terms and condition of the MIT License.
See [LICENSE](LICENSE) for details.
(This is included at the top of TVec.lua for your convenience.)
