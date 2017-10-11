defmodule ExBankingTest do
    use ExUnit.Case, async: true

    test "create new user" do
        assert ExBanking.create_user("John") == :ok
        assert ExBanking.create_user("John") == {:error, :user_already_exists}
    end
"""
    test "deposit" do
        assert ExBanking.create_user("Pit") == :ok
        assert ExBanking.deposit("Pit", 10, "USD") == :ok
    end
"""
end
