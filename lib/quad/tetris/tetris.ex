defmodule Tetris do
  
  def move(brick, function, points) do
    attempt = function.(brick)
    if all_ok?(attempt, points) do
      attempt
    else
      brick
    end
  end
  
  def all_ok?(brick, _points) do
    brick
    |> Points.prepare_to_render
    |> Enum.map(&point_ok?/1)
    |> Enum.all?
  end
  
  def point_ok?({x, _y}) when x < 1 do
    false
  end
  def point_ok?({x, _y}) when x > 10 do
    false
  end
  def point_ok?({_x, _y}) do
    true
  end
  
end
