Player = struct
  x:      "number"
  y:      "number"
  real_x: "number"
  real_y: "number"

  speed:  "number"
  move_padding: "number"

Player\impl
  update: (dt) =>
    @real_x = math.lerp @real_x, @x * SIZE, dt * @speed
    @real_y = math.lerp @real_y, @y * SIZE, dt * @speed

    game.camera.x = math.lerp game.camera.x, (math.floor @real_x * game.camera.zoom + SIZE), dt * game.camera.zoom
    game.camera.y = math.lerp game.camera.y, (math.floor @real_y * game.camera.zoom + SIZE), dt * game.camera.zoom

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