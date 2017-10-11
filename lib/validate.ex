defmodule Validate do

    def amount(x) do
        is_number(x) and not_negative(x) and two_decimal_precision(x)
    end

    def name(s) do
        is_binary(s)
    end

    def currency(s) do
        is_binary(s)
    end

    defp not_negative(money) do
        money >= 0
    end

    defp two_decimal_precision(money) do
        precision = 100
        money * precision == round(money * precision)
    end

end
