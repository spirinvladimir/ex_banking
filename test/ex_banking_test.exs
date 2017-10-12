defmodule ExBankingTest do
    use ExUnit.Case, async: true

    test "create new user" do
        assert ExBanking.create_user("Jose") == :ok
        assert ExBanking.create_user("Jose") == {:error, :user_already_exists}
    end

    test "deposit" do
        assert ExBanking.create_user("Pit") == :ok
        assert ExBanking.deposit("Pit", 1, "USD") == {:ok, 1}
        assert ExBanking.deposit("Pit", 2, "USD") == {:ok, 3}
        assert ExBanking.deposit("Pit", 0.01, "EUR") == {:ok, 0.01}
        assert ExBanking.deposit("Pit", 0.99, "EUR") == {:ok, 1.0}
    end

    test "withdraw" do
        assert ExBanking.create_user("Bill") == :ok
        assert ExBanking.withdraw("Bill", 1, "USD") == {:error, :not_enough_money}
        assert ExBanking.deposit("Bill", 3, "USD") == {:ok, 3}
        assert ExBanking.withdraw("Bill", 1, "USD") == {:ok, 2}
        assert ExBanking.withdraw("Bill", 3, "USD") == {:error, :not_enough_money}
        assert ExBanking.withdraw("Bill", 2, "USD") == {:ok, 0}
        assert ExBanking.withdraw("Bill", 1, "USD") == {:error, :not_enough_money}
    end

    test "get_balance" do
        assert ExBanking.create_user("Kolyan") == :ok
        assert ExBanking.get_balance("Kolyan", "USD") == {:ok, 0}
        assert ExBanking.deposit("Kolyan", 3, "USD") == {:ok, 3}
        assert ExBanking.get_balance("Kolyan", "USD") == {:ok, 3}
        assert ExBanking.withdraw("Kolyan", 1, "USD") == {:ok, 2}
        assert ExBanking.get_balance("Kolyan", "USD") == {:ok, 2}
    end

    test "send" do
        assert ExBanking.create_user("From") == :ok
        assert ExBanking.create_user("To") == :ok
        assert ExBanking.deposit("From", 3, "USD") == {:ok, 3}
        assert ExBanking.deposit("To", 2, "USD") == {:ok, 2}
        assert ExBanking.send("From", "Not-exist-user", 3, "USD") == {:error, :receiver_does_not_exist}
        assert ExBanking.send("Not-exist-user", "To", 3, "USD") == {:error, :sender_does_not_exist}
        assert ExBanking.send("From", "To", 4, "USD") == {:error, :not_enough_money}
        assert ExBanking.send("From", "To", 3, "USD") == {:ok, 0, 5}
    end

    test "user can send money to himself" do
        assert ExBanking.create_user("Greedy") == :ok
        assert ExBanking.send("Greedy", "Greedy", 1, "USD") == {:error, :not_enough_money}
        assert ExBanking.get_balance("Greedy", "USD") == {:ok, 0}
        assert ExBanking.deposit("Greedy", 2, "USD") == {:ok, 2}
        assert ExBanking.send("Greedy", "Greedy", 1, "USD") == {:ok, 2, 2}
        assert ExBanking.get_balance("Greedy", "USD") == {:ok, 2}
    end

end
