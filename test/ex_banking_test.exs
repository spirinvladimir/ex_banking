defmodule ExBankingTest do
    use ExUnit.Case, async: true

    test "create new user" do
        assert ExBanking.create_user("Jose") == :ok
        assert ExBanking.create_user(1) == {:error, :wrong_arguments}
        assert ExBanking.create_user("Jose") == {:error, :user_already_exists}
    end

    test "deposit" do
        assert ExBanking.deposit(1, 1, "USD") == {:error, :wrong_arguments}
        assert ExBanking.deposit("Pit", 1, 1) == {:error, :wrong_arguments}
        assert ExBanking.deposit("Pit", -1, "USD") == {:error, :wrong_arguments}
        assert ExBanking.create_user("Pit") == :ok
        assert ExBanking.deposit("Pit", 1, "USD") == {:ok, 1}
        assert ExBanking.deposit("Pit", 2, "USD") == {:ok, 3}
        assert ExBanking.deposit("Pit", 0.01, "EUR") == {:ok, 0.01}
        assert ExBanking.deposit("Pit", 0.99, "EUR") == {:ok, 1.0}
    end

    test "withdraw" do
        assert ExBanking.create_user("Bill") == :ok
        assert ExBanking.withdraw(1, 1, "USD") == {:error, :wrong_arguments}
        assert ExBanking.withdraw("Bill", 1, 1) == {:error, :wrong_arguments}
        assert ExBanking.withdraw("Bill", -1, "USD") == {:error, :wrong_arguments}
        assert ExBanking.withdraw("Bill", 1, "USD") == {:error, :not_enough_money}
        assert ExBanking.deposit("Bill", 3, "USD") == {:ok, 3}
        assert ExBanking.withdraw("Bill", 1, "USD") == {:ok, 2}
        assert ExBanking.withdraw("Bill", 3, "USD") == {:error, :not_enough_money}
        assert ExBanking.withdraw("Bill", 2, "USD") == {:ok, 0}
        assert ExBanking.withdraw("Bill", 1, "USD") == {:error, :not_enough_money}
    end

    test "get_balance" do
        assert ExBanking.create_user("Kolyan") == :ok
        assert ExBanking.get_balance(1, "USD") == {:error, :wrong_arguments}
        assert ExBanking.get_balance("Kolyan", 1) == {:error, :wrong_arguments}
        assert ExBanking.get_balance("Kolyan", "USD") == {:ok, 0}
        assert ExBanking.deposit("Kolyan", 3, "USD") == {:ok, 3}
        assert ExBanking.get_balance("Kolyan", "USD") == {:ok, 3}
        assert ExBanking.withdraw("Kolyan", 1, "USD") == {:ok, 2}
        assert ExBanking.get_balance("Kolyan", "USD") == {:ok, 2}
    end    

end
