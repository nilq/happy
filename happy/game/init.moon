path = "game/"

export game = state\new!
export SIZE = 20

love.graphics.setBackgroundColor 1, 1, 1

World = struct
  content: "table"
  level:   "table"

World\impl
  update: (dt) =>
    for element in *@content
      element\update dt if element.update

  keypressed: (key, isrepeat) =>
    for element in *@content
      element\keypressed key, isrepeat if element.keypressed

  draw: =>
    @level\draw!

    for element in *@content
      element\draw! if element.draw

game.init = =>
  import level  from require path .. "level"
  import player from require path .. "entities"

  world_level = level.Level
    map:    {}
    width:  love.graphics.getWidth! / SIZE
    height: love.graphics.getHeight! / SIZE
    size:   SIZE
    registry:
      NULL:   0
      BLOCK:  1
      PLAYER: 2

  world_level\init 40, 15

  @world = World
    content: {
      player.Player
        x: 10
        y: 10
        real_x: 10 * 20
        real_y: 10 * 20
    }
    level: world_level

game.update = (dt) =>
  @world\update dt

game.draw = =>
  @world\draw!

game.keypressed = (key, isrepeat) =>
  @world\keypressed key, isrepeat

  switch key
    when "escape"
      love.event.quit!
    when "r"
      love.event.quit "restart"

game