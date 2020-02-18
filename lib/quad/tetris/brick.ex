defmodule Tetris.Brick do
  defstruct [:name, :location, :rotation, :reflection]
  
  def new do
    %__MODULE__{
      name: :o,
      location: {3,0},
      rotation: 90,
      reflection: true 
    }
  end


  def new_random do
    %__MODULE__{
      name: random_name(),
      location: {3,0},
      rotation: random_degrees(),
      reflection: random_reflection() 
    }
  end
  
  def random_name do
    [:z, :l, :o, :i, :t] 
    |> Enum.random
  end
  
  def random_degrees do
    [90, 180, 270, 0]
    |> Enum.random
  end
  
  def random_reflection do
    [true, false]
    |> Enum.random
  end
    
  def reflect(brick) do
    %{brick| reflection: not brick.reflection}
  end

  def turn(270)  do
    0
  end
  def turn(degrees) do
    degrees + 90
  end
  
  def rotate(brick) do
    %{brick| rotation: turn(brick.rotation)}
  end
  
  def right({x, y}) do
    {x+1, y}
  end
  def move_right(brick) do
    %{brick| location: right(brick.location)}
  end
  def left({x, y}) do
    {x-1, y}
  end
  def move_left(brick) do
    %{brick| location: left(brick.location)}
  end
  def down({x, y}) do
    {x, y+1}
  end
  def move_down(brick) do
    %{brick| location: down(brick.location)}
  end
end