defmodule UsersTest do
    use ExUnit.Case, async: true

    setup do
        %{pid: Users.agent()}
    end

    test "create new user", %{pid: pid} do
        assert Users.create(pid, "Teddy") == :ok
    end

    test "user already exists", %{pid: pid} do
        assert Users.create(pid, "John") == :ok
        assert Users.create(pid, "John") == :error
    end

    test "create 3 users", %{pid: pid} do
        assert Users.create(pid, "Bob") == :ok
        assert Users.create(pid, "Paul") == :ok
        assert Users.create(pid, "Will") == :ok
    end

    test "read user", %{pid: pid} do
        assert Users.create(pid, "Jeff") == :ok
        assert Users.read(pid, "Jeff") == :ok
    end

end
