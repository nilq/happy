Player = struct
  x:      "number"
  y:      "number"
  real_x: "number"
  real_y: "number"

  speed:        "number"
  move_padding: "number"

  key_buffer: "table"
  key_limit:  "number"

Player\impl
  update: (dt) =>
    @real_x = math.lerp @real_x, @x * SIZE, dt * @speed
    @real_y = math.lerp @real_y, @y * SIZE, dt * @speed

    game.camera.x = math.lerp game.camera.x, (math.floor @real_x * game.camera.zoom + SIZE), dt * game.camera.zoom
    game.camera.y = math.lerp game.camera.y, (math.floor @real_y * game.camera.zoom + SIZE), dt * game.camera.zoom

    for i, v in ipairs @key_buffer
      if i < @key_limit
        key    = table.remove @key_buffer, 1
        dx, dy = @key_to_direction key

        @move dx, dy

    with love.keyboard
      if (@real_x - @x * SIZE)^2 + (@real_y - @y * SIZE)^2 < @move_padding^2
        dx = 0
        dy = 0

        if .isDown "right"
            dx = 1
        if .isDown "left"
            dx = -1
        if .isDown "down"
            dy = 1
        if .isDown "up"
            dy = -1

        @move dx, dy

  draw: =>
    with love.graphics
      .setColor 0, 1, 1
      .rectangle "fill", @real_x, @real_y, SIZE, SIZE

      .setColor 0, 0.8, 0.8
      .rectangle "line", @real_x, @real_y, SIZE, SIZE

  keypressed: (key) =>
    keys = {
      left:  true
      right: true
      up:    true
      down:  true
    }
    
    if keys[key]
      table.insert @key_buffer, key

  key_to_direction: (key) =>
    dx = 0
    dy = 0

    switch direction
      when "right"
        dx = 1
      when "left"
        dx = -1
      when "down"
        dy = 1
      when "up"
        dy = -1
    
    dx, dy

  move: (dx, dy) =>
    if game.world.level\vacant @x + dx, @y + dy
      @x += dx
      @y += dy

      unless dx + dy == 0
        game.world.level\set @x, @y, game.world.level.registry.NULL

      game.world.level\set @x, @y, game.world.level.registry.PLAYER

{
  :Player
}