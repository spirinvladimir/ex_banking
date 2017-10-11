defmodule Account do

    def create() do
        {:ok, account} = Agent.start(fn -> %{} end)
        account
    end

    defp get_balance(wallet, currency) do
        if Map.has_key?(wallet, currency) do
            wallet[currency]
        else
            0
        end
    end

    def deposit(account, amount, currency) do
        Agent.get_and_update(account, fn wallet ->
            new_balance = amount + get_balance(wallet, currency)
            wallet = Map.put(wallet, currency, new_balance)
            {new_balance, wallet}
        end)
    end

    def withdraw(account, amount, currency) do
        Agent.get_and_update(account, fn wallet ->
            case get_balance(wallet, currency) - amount do
                new_balance when new_balance < 0 ->
                    {:error, wallet}
                new_balance ->
                    {new_balance, Map.put(wallet, currency, amount)}
            end
        end)
    end

end
