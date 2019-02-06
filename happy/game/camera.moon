Camera = struct
  x:    "number"
  y:    "number"
  r:    "number"
  zoom: "number"

Camera\impl
  move: (dx, dy) =>
    @x += dx
    @y += dy

  set: =>
    with love.graphics
      .push!
      .translate .getWidth! / 2 - @x, .getHeight! / 2 - @y
      .rotate @r
      .scale @zoom, @zoom

  unset: =>
    love.graphics.pop!

{
  :Camera
}