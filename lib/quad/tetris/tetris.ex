defmodule Tetris do
  alias Tetris.Brick
  
  def move(original_brick, change, points) do
    new_brick = change.(original_brick)
    if all_ok?(new_brick, points) do
      new_brick
    else
      original_brick
    end
  end
  
  def drop(original_brick, canvas, score) do
    new_brick = Brick.move_down(original_brick)
    new_points = Points.prepare_to_render(new_brick)
    old_points = Points.prepare_to_render(original_brick)
      
    if hits_canvas?(new_points, canvas) do  
      new_canvas = Canvas.merge(canvas, old_points)
      new_random_brick = Brick.new_random()
      {new_random_brick, new_canvas, score + 100000000}
    else
      {new_brick, canvas, score}
    end
  end
  
  def point_hits_canvas?({x, y}, canvas) do
    (y > 20) or (({x, y} in canvas))
  end
  def hits_canvas?(points, canvas) do
    points
    |> Enum.map(&point_hits_canvas?(&1, canvas))
    |> Enum.any?
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
