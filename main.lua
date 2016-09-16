require "lib/hammerhaj"

local man = entity()

component: position {
  x = 100, y = 100,
}

assemblage: box(function(x, y)
  local r = entity()
  r:add_component("position")
  return r
end)

local boy = create: box(100, 1230)

man:add_component("position")

print(boy.position.x, boy.position.y)

function love.draw()
  love.graphics.rectangle("fill", man.position.x, man.position.y, 10, 32)
end
