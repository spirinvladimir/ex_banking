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
                :account => (fn ->
                    {:ok, pid} = Agent.start(fn -> %{} end)
                    pid
                end).()
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
        case Agent.get(pid, fn users ->
            IO.inspect(users)
            users[name]
        end) do
            nil -> :error
            user -> user
        end
    end

    def load_user(pid, name) do
        Agent.get_and_update(pid, fn users ->
            user = users[name]
            user = Map.put(user, :load, user[:load] + 1)
            users = Map.put(users, name, user)
            {user[:account], users}
        end)
    end

    def save_user(pid, name) do
        Agent.update(pid, fn users ->
            user = users[name]
            user = Map.put(user, :load, user[:load] - 1)
            Map.put(users, name, user)
        end)
    end

end
