defmodule Dir do
  defstruct name: "", absname: "", files: %{}, subdirs: [], size: -1
end

defmodule D7 do
  def p1(file) do
    file
    |> build_dirs
    |> Enum.map(& &1.size)
    |> Enum.filter(&(&1 < 100_000))
    |> Enum.sum()
  end

  def p2(file) do
    dirs = build_dirs(file)
    root_dir = Enum.find(dirs, &(&1.absname == "/"))
    unused_space = 70_000_000 - root_dir.size
    to_free = 30_000_000 - unused_space

    dirs
    |> Enum.map(& &1.size)
    |> Enum.filter(&(&1 >= to_free))
    |> Enum.sort()
    |> Enum.at(0)
  end

  defp fetch_sizes(dirs) do
    fetch_sizes(dirs, dirs, [])
  end

  defp fetch_sizes([], _, acc) do
    acc
  end

  defp fetch_sizes([dir | dirs], all_dirs, acc) do
    files_size = dir.files |> Map.values() |> Enum.sum()

    subdirs_size =
      dir.subdirs
      |> Enum.map(fn name ->
        absname = Path.expand(dir.absname <> "/" <> name)
        Enum.find(all_dirs, &(&1.absname == absname))
      end)
      |> Enum.filter(&(&1 != nil))
      |> fetch_sizes(all_dirs, [])
      |> Enum.map(& &1.size)
      |> Enum.sum()

    size = files_size + subdirs_size
    fetch_sizes(dirs, all_dirs, [%Dir{dir | size: size} | acc])
  end

  defp build_dirs(file) do
    file
    |> File.read!()
    |> String.split("\n")
    |> Enum.reduce(%{loc: "", dirs: []}, &build_dirs/2)
    |> Map.get(:dirs)
    |> fetch_sizes()
  end

  defp build_dirs("$ cd " <> dir, %{loc: loc, dirs: dirs} = ctxt) do
    loc = Path.expand(loc <> "/" <> dir)
    name = Path.basename(loc)

    case Enum.find(dirs, &(&1.absname == loc)) do
      nil ->
        dir = %Dir{name: name, absname: loc}
        %{ctxt | loc: loc, dirs: [dir | dirs]}

      _ ->
        %{ctxt | loc: loc}
    end
  end

  defp build_dirs("$ ls", ctxt) do
    ctxt
  end

  defp build_dirs(line, %{loc: loc, dirs: dirs} = ctxt) do
    current_dir = Enum.find(dirs, &(&1.absname == loc))

    case String.split(line) do
      ["dir", dir] ->
        subdirs = Enum.uniq([dir | current_dir.subdirs])
        new_current_dir = %Dir{current_dir | subdirs: subdirs}
        %{ctxt | dirs: (dirs -- [current_dir]) ++ [new_current_dir]}

      [size_str, filename] ->
        files = Map.put_new(current_dir.files, filename, String.to_integer(size_str))
        new_current_dir = %Dir{current_dir | files: files}
        %{ctxt | dirs: (dirs -- [current_dir]) ++ [new_current_dir]}
    end
  end
end
