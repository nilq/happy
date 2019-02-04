path = "game/"

game = state\new!

love.graphics.setBackgroundColor 1, 1, 1

World = struct
  content: "table",
  level:   "table",

World\impl
  update: (dt) =>
    for element in *@content
      element\update dt if element.update

  draw: =>
    @level\draw!

    for element in *@content
      element\draw! if element.draw


game.init = =>
  import level from require path .. "level"

  world_level = level.Level
    map: {}
    width:  40
    height: 30
    size:   20

  world_level\init 40, 15

  @world = World
    content: {}
    level:   world_level

game.update = (dt) =>
  @world\update dt

game.draw = =>
  @world\draw!

game.keypressed = (key) =>
  switch key
    when "escape"
      love.event.quit!
    when "r"
      love.event.quit "restart"

game