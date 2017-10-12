defmodule ArgumentsTest do
    use ExUnit.Case

    test "create new user" do
        assert ExBanking.create_user(1) == {:error, :wrong_arguments}
    end

    test "deposit" do
        assert ExBanking.deposit(1, 1, "USD") == {:error, :wrong_arguments}
        assert ExBanking.deposit("Pit", 1, 1) == {:error, :wrong_arguments}
        assert ExBanking.deposit("Pit", -1, "USD") == {:error, :wrong_arguments}
    end

    test "withdraw" do
        assert ExBanking.withdraw(1, 1, "USD") == {:error, :wrong_arguments}
        assert ExBanking.withdraw("Bill", 1, 1) == {:error, :wrong_arguments}
        assert ExBanking.withdraw("Bill", -1, "USD") == {:error, :wrong_arguments}
    end

    test "get_balance" do
        assert ExBanking.get_balance(1, "USD") == {:error, :wrong_arguments}
        assert ExBanking.get_balance("Kolyan", 1) == {:error, :wrong_arguments}
    end

    test "send" do
        assert ExBanking.send(1, "To", 3, "USD") == {:error, :wrong_arguments}
        assert ExBanking.send("From", 1, 3, "USD") == {:error, :wrong_arguments}
        assert ExBanking.send("From", "To", -3, "USD") == {:error, :wrong_arguments}
        assert ExBanking.send("From", "To", 3, 1) == {:error, :wrong_arguments}
    end

end
