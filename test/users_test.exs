defmodule UsersTest do
    use ExUnit.Case, async: true

    setup do
        %{pid: Users.agent()}
    end

    test "create new user", %{pid: pid} do
        assert Users.create(pid, "John") == :ok
    end

    test "user already exists", %{pid: pid} do
        assert Users.create(pid, "John") == :ok
        assert Users.create(pid, "John") == :error
    end

    test "create two users", %{pid: pid} do
        assert Users.create(pid, "John") == :ok
        assert Users.create(pid, "Paul") == :ok
    end

    test "read user", %{pid: pid} do
        assert Users.create(pid, "John") == :ok
        %{:load => load, :account => account} = Users.read(pid, "John")
        assert load == 0
        assert is_pid(account)
    end

end
