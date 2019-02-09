local Level = struct({
  map = "table",
  width = "number",
  height = "number",
  size = "number",
  registry = "table"
})
Level:impl({
  init = function(self)
    local map = { }
    for x = 0, self.width do
      local row = { }
      for y = 0, self.height do
        row[y - 1] = 0
      end
      map[x - 1] = row
    end
    self.map = map
  end,
  set = function(self, x, y, val)
    assert(x < self.width and y < self.height and x >= 0 and y >= 0)
    self.map[x][y] = val
  end,
  get = function(self, x, y)
    assert(x < self.width and y < self.height and x >= 0 and y >= 0)
    return self.map[x][y]
  end,
  vacant = function(self, x, y)
    return (x < self.width and y < self.height and x >= 0 and y >= 0) and self.map[x][y] ~= 1
  end,
  draw = function(self)
    do
      local _with_0 = love.graphics
      for i = 0, self.height do
        _with_0.setColor(0.9, 0.9, 0.9)
        _with_0.line(0, i * self.size, _with_0.getWidth(), i * self.size)
      end
      for i = 0, self.width do
        _with_0.setColor(0.9, 0.9, 0.9)
        _with_0.line(i * self.size, 0, i * self.size, _with_0.getHeight())
      end
      for x = 0, self.width - 1 do
        for y = 0, self.height - 1 do
          local _exp_0 = self:get(x, y)
          if 1 == _exp_0 then
            _with_0.setColor(0.5, 0.5, 0.5)
            _with_0.rectangle("fill", x, y, x * self.size, y * self.size)
          end
        end
      end
      return _with_0
    end
  end
})
return {
  Level = Level
}
