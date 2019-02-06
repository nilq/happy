Player = struct
  x:      "number"
  y:      "number"
  real_x: "number"
  real_y: "number"

Player\impl
  update: (dt) =>
    @real_x = math.lerp @real_x, @x * SIZE, dt * 10
    @real_y = math.lerp @real_y, @y * SIZE, dt * 10

  draw: =>
    with love.graphics
      .setColor 0, 1, 1
      .rectangle "fill", @real_x, @real_y, SIZE, SIZE

      .setColor 0, 0.8, 0.8
      .rectangle "line", @real_x, @real_y, SIZE, SIZE

  keypressed: (key, isrepeat) =>
    dx = 0
    dy = 0

    switch key
      when "right"
        dx = 1
      when "left"
        dx = -1
      when "down"
        dy = 1
      when "up"
        dy = -1

    unless dx + dy == 0
      game.world.level\set @x, @y, game.world.level.registry.NULL

    @x += dx
    @y += dy

    game.world.level\set @x, @y, game.world.level.registry.PLAYER

{
  :Player
}