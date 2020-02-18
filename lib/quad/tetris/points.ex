defmodule Points do
  def draw(:l) do
    [
      {2, 1}, 
      {2, 2}, 
      {2, 3}, {3, 3}, 
    ]
  end
  def draw(:o) do
    [
      {2, 2},{2, 3},
      {3, 2},{3, 3},
    ]    
  end
  def draw(:i) do
    [
      {1, 2},
      {2, 2},
      {3, 2},
      {4, 2},
    ]    
  end
  def draw(:t) do
    [
      {2, 2},{3, 2},{4, 2},
             {3, 3},
    ]    
  end
  def draw(:z) do
    [
      {2, 2},{2, 3},
             {3, 3},{3, 4},
    ]    
  end
  
  def color(:z) do
    :blue
  end
  
  def move_point({x, y}, {change_x, change_y}) do
    {x+change_x,y+change_y}
  end
  
  def move(points, location) do
    Enum.map(
      points, 
      fn(point) -> 
        move_point(point, location) 
      end
    )
  end
  
  def rotate(points, degrees) do
    do_fn(points, fn(point) -> rotate_point(point, degrees) end)
  end
  
  def rotate_point(point, 0) do
    point
  end
  def rotate_point(point, 90) do
    point
    |> mirror_point
    |> transpose_point
  end
  def rotate_point(point, 180) do
    point
    |> rotate_point(90)
    |> rotate_point(90)
  end
  def rotate_point(point, 270) do
    point
    |> rotate_point(90)
    |> rotate_point(180)
  end
  
  def mirror_point({x, y}) do
    {5-x, y}
  end  
  
  def flip_point({x, y}) do
    {x, 5-y}
  end  
  
  def transpose_point({x, y}) do
    {y, x}
  end  
  
  def do_fn(points, f) do
    Enum.map(points,f)
  end
  
  def mirror(points) do
    points
    |> Enum.map(&mirror_point/1)
  end
  
  def reflect(points, false) do
    points
  end
  
  def reflect(points, true) do
    mirror points
  end
  
  def flip(points) do
    do_fn points, &flip_point/1
  end
  
  def transpose(points) do
    do_fn points, &transpose_point/1
  end
  
  def prepare_to_render(brick) do
    brick.name
    |> draw
    |> rotate(brick.rotation)
    |> reflect(brick.reflection)
    |> move(brick.location)
    |> add_color(Tetris.Brick.color(brick))
  end
  
  def add_color(points, color) do
    Enum.map(
      points,
      fn {x, y} -> 
        {x,y,color}
      end
    )
  end
  
  def add_color_to_point({x,y},color) do
    {x,y,color}
  end
  
end