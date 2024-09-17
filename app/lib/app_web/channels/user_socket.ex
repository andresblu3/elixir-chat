defmodule AppWeb.UserSocket do
  use Phoenix.Socket  # Esta línea es esencial para habilitar los sockets

  ## Canales
  channel "room:lobby", AppWeb.ChatChannel

  def connect(_params, socket, _connect_info) do
    {:ok, socket}
  end

  def id(_socket), do: nil
end
