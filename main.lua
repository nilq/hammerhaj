require "lib/hammerhaj"

component: position {
  x = 0, y = 0,
}

component: color {
  r = 0, g = 0, b = 0,
}

component: velocity {
  dx = 0, dy = 0,
}

assemblage: box(function(x, y, red, green, blue)
  local b = entity()

  b:add_component("position")

  b.position.x = x
  b.position.y = y

  b:add_component("color")

  b.color.r, b.color.g, b.color.b = red, green, blue

  return b
end)

local boxes = {}

for i = 1, 15000 do
  local b = create: box(
    math.random(0, love.graphics.getWidth()),
    math.random(0, love.graphics.getHeight()),

    math.random(0, 255),
    math.random(0, 255),
    math.random(0, 255)
  )

  table.insert(boxes, b)
end

function love.draw()
  for i, v in ipairs(boxes) do
    love.graphics.setColor(v.color.r, v.color.g, v.color.b)
    love.graphics.rectangle("fill", v.position.x, v.position.y, 16, 16)
  end
end
