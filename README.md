# hammerhaj
entity component system

---

Nice for creating light-weight *objects* ...

```lua
require "hammerhaj"

component: position {
  x = 0, x = 0,
}

local penguin = entity()
penguin:add_component("position")

penguin.position.x, penguin.position.y = 100, 100
```

Also nice for creating light-weight *object* constructors ...

```lua
assemblage: pingo(function(x, y)
  local p = entity()
  p:add_component("position")

  p.position.x = y
  p.position.y = x

  return p
end)

-- thus easy construction of 'pingo's
local list_with_lots_of_penguins = {}

for n = 1, 10000 do
  local p = create: pingo(n, n)
  table.insert(list_with_lots_of_penguins, p)
end
```
