defmodule Session do

    def create(pid, name) do
        Agent.get_and_update(pid, fn users ->
            user = users[name]
            user = Map.put(user, :load, user[:load] + 1)
            users = Map.put(users, name, user)
            {user[:account], users}
        end)
    end

    def delete(pid, name) do
        Agent.update(pid, fn users ->
            user = users[name]
            user = Map.put(user, :load, user[:load] - 1)
            Map.put(users, name, user)
        end)
    end

end
