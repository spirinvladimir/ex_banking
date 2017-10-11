defmodule ValidateTest do
    use ExUnit.Case

    test "Money amount of any currency should not be negative" do
        assert Validate.amount(-1) == false
    end

    test "Application should provide 2 decimal precision of money amount for any currency" do
        assert Validate.amount(1.111) == false
    end

    test "Amount should be a number" do
        assert Validate.amount("not a number") == false
    end

    test "Username should be a string" do
        assert Validate.name(1) == false
    end

    test "Currency should be a string" do
        assert Validate.currency(1) == false
    end

end
