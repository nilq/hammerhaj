local _entities    = {}
local _components  = {}
local _assemblages = {}

local function call_index(t, func, ...)
  local args = {...}
  if #args > 0 then
    return getmetatable(t).__index(nil, func)(nil, ...)
  end
  return function(...)
    return getmetatable(t).__index(nil, func)(nil, ...)
  end
end

local _type = type
function type(n)
  local mt = {}
  if _type(n) == "table" then
    mt = getmetatable(n) or mt
  end
  if _type(rawget(mt, "__type")) == "string" then
    return rawget(meta, "__type")
  end
  return _type(n)
end

entity = function(k)
  if _entities[k] then
    error("entity '" .. k .. "' already exists!")
  end

  local ent = {
    components = {},
    id = math.random(),
  }

  local ent = setmetatable(ent, {
    __type  = "entity",
    __index = function(t, k)
      return ent.components[k]
    end,
  })

  function ent:add_component(ck)
    if self.components[ck] then
      error("component '" .. ck .. "' does not exist!")
    elseif self.components[ck] then
      error("component '" .. ck .. "' has already been added to '" .. k  .. "'!")
    end
    self.components[ck] = _components[ck]
  end

  function ent:remove_component(ck)
    if not self.components[ck] then
      error("component '" .. ck .. "' doesn't exist on '" .. k .. "'!")
    end
    self.components[ck] = nil
  end

  return ent
end

component = setmetatable({}, {
  __call  = call_index,
  __index = function(_, k)
    return function(_, body)
      if _components[k] then
        error("component '" .. k .. "' already exists!")
      end
      if type(body) == "table" then
        _components[k] = body
      else
        error("components need a table body; found " .. type(body) .. "!")
      end
    end
  end,
})

assemblage = setmetatable({}, {
  __call  = call_index,
  __index = function(_, k)
    return function(_, a)
      if _assemblages[k] then
        error("assemblage '" .. k .. "' already exists!")
      end
      if type(a) == "function" then
        _assemblages[k] = a
      else
        error("assemblages need an assemblage function; found " .. type(a) .. "!")
      end
    end
  end,
})

create = setmetatable({}, {
  __call = call_index,
  __index = function(_, k)
    if _assemblages[k] then
      return function(...)
        local args = {}
        for i, v in ipairs({...}) do
          if i > 1 then
            args[#args + 1] = v
          end
        end
        return _assemblages[k](args)
      end
    else
      error("assemblage '" .. k .. "' does not exist!")
    end
  end,
})
