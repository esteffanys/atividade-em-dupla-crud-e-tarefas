defmodule Tasks do

  def principal do
    loop()
  end

  def loop() do
    IO.puts "Sistema Final"
    IO.puts "============="
    IO.puts "1. Rotacionar"
    IO.puts "2. Translação"
    IO.puts "3. Reflexão"
    IO.puts "4. Escala"
    IO.puts "5. Sair"

    IO.puts "Entre com sua opção: "
    opcao = IO.gets("") |> String.trim |> String.to_integer()

    case opcao do
      1 -> rot()
      2 -> trans()
      3 -> ref()
      4 -> escala()
      5 -> sair()
      _ ->
        IO.puts "Opção inválida"
        loop()
    end
  end

  def rot() do
    pontos_fixos = [{1, 2}, {3, 4}, {5, 6}]

    IO.puts "Digite o angulo para rotação"
    angulo = IO.gets("") |> String.trim |> String.to_integer()

    pontos = Enum.map(pontos_fixos, fn ponto ->
      Task.async(fn ->
        {x, y} = ponto
        {x * :math.cos(angulo) - y * :math.sin(angulo),
         x * :math.sin(angulo) + y * :math.cos(angulo)}
      end)
    end) |> Enum.map(&Task.await/1)

     IO.inspect pontos
     loop()

  end


  def trans do
    pontos_fixos = [{1, 2}, {3, 4}, {5, 6}]

    IO.puts "Digite o valor de x a somar"
    dx = IO.gets("") |> String.trim |> String.to_integer()

    IO.puts "Digite o valor de y a somar"
    dy = IO.gets("") |> String.trim |> String.to_integer()

    pontos = Enum.map(pontos_fixos, fn ponto ->
      Task.async(fn ->
        {x, y} = ponto
        {x + dx, y + dy}
      end)
    end) |> Enum.map(&Task.await/1)

    IO.inspect pontos
    loop()

  end

  def ref() do
    pontos_fixos = [{1, 2}, {3, 4}, {5, 6}]

    IO.puts "Digite o eixo x ou y"
    eixo = IO.gets("") |> String.trim

    pontos = Enum.map(pontos_fixos, fn ponto->
      Task.async(fn ->
      {x, y} = ponto
      case eixo do
        "x" -> {x, -y}
        "y" -> {-x, y}
      end
      end)
    end) |> Enum.map(&Task.await/1)

    IO.inspect pontos
    loop()

  end

  def escala do
    pontos_fixos = [{1, 2}, {3, 4}, {5, 6}]

    IO.puts "Digite a coordenada x para multiplicar"
    sx = IO.gets("") |> String.trim |> String.to_integer()

    IO.puts "Digite a coordenada y para multiplicar"
    sy = IO.gets("") |> String.trim |> String.to_integer()

    pontos = Enum.map(pontos_fixos, fn ponto ->
      Task.async(fn ->
        {x, y} = ponto
        {x * sx, y * sy}
      end)
    end) |> Enum.map(&Task.await/1)

    IO.inspect pontos
    loop()

  end

  def sair do
    IO.puts "Sistema encerrado."
    :ok
  end

end

Tasks.principal()
