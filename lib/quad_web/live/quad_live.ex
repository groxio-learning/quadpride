defmodule QuadWeb.QuadLive do
  use Phoenix.LiveView
  import Phoenix.HTML, only: [raw: 1]
  alias Tetris.Brick

  def mount(_session, socket) do
    :timer.send_interval 500, self(), :tick
    brick = Brick.new_random()
    {
      :ok, 
      socket
      |> initial_state(brick)
      |> show(brick)
    }
  end
  
  def initial_state(socket, brick) do
    assign(socket, 
      brick: brick,
      score: 0
    )
  end
  
  def show(socket, brick) do
    socket
    |> assign(
      points: Points.prepare_to_render(brick)
    ) 
  end
  
  def render(assigns) do
    ~L"""
    <%= raw game_canvas_begin() %>
      <defs>
        <g id="Box">
          <rect width="20" height="20" />
        </g>
      </defs>
      
      <%= for point <- @points do %>
        <use href="#Box" x="<%= x point %>" y="<%= y point %>" />
      <% end %>

    <%= raw game_canvas_end() %>
    <h1 phx-keydown="keystroke" phx-target="window">Welcome to QuadPride</h1>
    <h2><%= @score %></h2>
    <div>
    </div>
    <pre><%= inspect @brick %></pre>
    """
  end
  
  def x({x, _y}), do: (x - 1) * 20
  def y({_x, y}), do: (y - 1) * 20

  
  def move_right(socket) do
    old_brick = socket.assigns.brick
    new_brick = 
      Tetris.move(old_brick, &Brick.move_right/1, [])
    assign(socket, brick: new_brick)
    |> show(new_brick)
  end
  
  def move_left(socket) do
    old_brick = socket.assigns.brick
    new_brick = 
      Tetris.move(old_brick, &Brick.move_left/1, [])
    assign(socket, brick: new_brick)
    |> show(new_brick)
  end

  def move_down(socket) do
    old_brick = socket.assigns.brick
    old_score = socket.assigns.score
    new_brick = Brick.move_down(old_brick)
    
    assign(
      socket, 
      brick: new_brick, 
      score: old_score+1
      )
      |> show(new_brick)
  end
  
  def rotate(socket) do
    old_brick = socket.assigns.brick
    new_brick = Brick.rotate(old_brick)
    assign(socket, brick: new_brick)
    |> show(new_brick)
  end
  
  def reflect(socket) do
    old_brick = socket.assigns.brick
    new_brick = Brick.reflect(old_brick)
    assign(socket, brick: new_brick)
    |> show(new_brick)
  end
  
  def game_canvas_end() do
    """
    </svg>
    """
  end
  
  def game_canvas_begin() do
    color = "#e8e8e8"
    
    """
    <svg 
      width="200" 
      height="400" 
      style="background-color:#{color}">
    """
  end
    
  def handle_event("keystroke", %{"code" => "ArrowRight"}, socket) do
    {:noreply, move_right(socket)}
  end
  
  def handle_event("keystroke", %{"code" => "ArrowLeft"}, socket) do
    {:noreply, move_left(socket)}
  end
  
  def handle_event("keystroke", %{"code" => "ArrowDown"}, socket) do
    {:noreply, move_down(socket)}
  end
  
  def handle_event("keystroke", %{"code" => "Slash"}, socket) do
    {:noreply, rotate(socket)}
  end
  
  def handle_event("keystroke", %{"code" => "Space"}, socket) do
    {:noreply, reflect(socket)}
  end
  
  def handle_event("keystroke", %{"code" => _}, socket) do
    {:noreply, (socket)}
  end
  
  def handle_info(:tick, socket) do
    {:noreply, move_down(socket)}
  end
end