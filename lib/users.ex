defmodule Users do

    def agent() do
        case Agent.start_link(fn -> %{} end, name: :users) do
            {:ok, pid} -> pid
            {:error, {:already_started, pid}} -> pid
        end
    end

    defp addNewUser(users, name) do
        users
        |> Map.put(
            name,
            %{
                :load => 0,
                :account => Account.create()
            }
        )
    end

    def create(pid, name) do
        case Agent.get(pid, fn users -> users[name] end) do
            nil -> Agent.update(pid, fn users -> addNewUser(users, name) end)
            _ -> :error
        end
    end

    def read(pid, name) do
        case Agent.get(pid, fn users -> users[name] end) do
            nil -> :error
            user -> user
        end
    end

end
