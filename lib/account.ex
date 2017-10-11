defmodule Account do

    def deposit(account, amount, currency) do
        Agent.get_and_update(account, fn wallet ->
            new_balance = amount + wallet[currency]
            wallet = Map.put(wallet, currency, new_balance)
            {new_balance, wallet}
        end)
    end

    def withdraw(account, amount, currency) do
        Agent.get_and_update(account, fn wallet ->
            case wallet[currency] - amount do
                new_balance when new_balance < 0 ->
                    {:error, wallet}
                new_balance ->
                    {new_balance, Map.put(wallet, currency, amount)}
            end
        end)
    end

end
