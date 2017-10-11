defmodule ExBanking do
    @type banking_error :: {:error,
        :wrong_arguments                |
        :user_already_exists            |
        :user_does_not_exist            |
        :not_enough_money               |
        :sender_does_not_exist          |
        :receiver_does_not_exist        |
        :too_many_requests_to_user      |
        :too_many_requests_to_sender    |
        :too_many_requests_to_receiver
    }

    @spec create_user(user :: String.t) :: :ok | banking_error
    def create_user(name) do
        case Validate.name(name) do
            false -> {:error, :wrong_arguments}
            true ->
                pid = Users.agent()
                case Users.create(pid, name) do
                    :error -> {:error, :user_already_exists}
                    :ok -> :ok
                end
        end
    end


    @spec deposit(user :: String.t, amount :: number, currency :: String.t) :: {:ok, new_balance :: number} | banking_error
    def deposit(name, amount, currency) do
        case Validate.name(name) and Validate.amount(amount) and Validate.currency(currency) do
            false -> {:error, :wrong_arguments}
            true ->
                pid = Users.agent()
                case Users.read(pid, name) do
                    :error -> {:error, :user_does_not_exist}
                    user ->
                        case Perfomance.check(user) do
                            :error -> {:error, :too_many_requests_to_user}
                            _ ->
                                account = Session.create(pid, name)
                                new_balance = Account.deposit(account, amount, currency)
                                Session.delete(pid, name)
                                {:ok, new_balance}
                        end
                end
        end
    end

    @spec withdraw(user :: String.t, amount :: number, currency :: String.t) :: {:ok, new_balance :: number} | banking_error
    def withdraw(name, amount, currency) do
        case Validate.name(name) and Validate.amount(amount) and Validate.currency(currency) do
            false -> {:error, :wrong_arguments}
            true ->
                pid = Users.agent()
                case Users.read(pid, name) do
                    :error -> {:error, :user_does_not_exist}
                    user ->
                        case Perfomance.check(user) do
                            :error -> {:error, :too_many_requests_to_user}
                            _ ->
                                account = Session.create(pid, name)
                                new_balance =  Account.withdraw(account, amount, currency)
                                Session.delete(pid, name)
                                case new_balance do
                                    :error -> {:error, :not_enough_money}
                                    new_balance -> {:ok, new_balance}
                                end
                        end
                end
        end
    end
"""
    @spec get_balance(user :: String.t, currency :: String.t) :: {:ok, balance :: number} | banking_error
    def get_balance do

    end

    @spec send(from_user :: String.t, to_user :: String.t, amount :: number, currency :: String.t) :: {:ok, from_user_balance :: number, to_user_balance :: number} | banking_error
    def send do

    end
"""
end
