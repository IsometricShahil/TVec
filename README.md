# TVec
1. Vector pooling.
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
1. `__pairs` metamethod.
2. Projection.
3. Cross product.
4. Mirroring.

# License
TVec.lua is licensed under the terms and condition of the MIT License.
See [LICENSE](LICENSE) for details.
(This is included at the top of TVec.lua for your convenience.)
