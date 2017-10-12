defmodule PerfomanceTest do
    use ExUnit.Case, async: true

    import Perfomance

    def job([{:ok, pid} | pids]) do
        Agent.cast(pid, fn state ->
            ExBanking.deposit("Pobre", 1, "USD")
            state
        end)
        job(pids)
    end

    def job([]) do
        true
    end

    def create_pids(n, pids) when n == 0 do
        pids
    end

    def create_pids(n, pids) do
        create_pids(n - 1, [Agent.start(fn -> nil end)] ++ pids)
    end

    test "create new user" do
        ExBanking.create_user("Pobre")

        count_pids = 100

        create_pids(count_pids, []) |> job

        :timer.sleep(1000)

        {:ok, balance} = ExBanking.get_balance("Pobre", "USD")
        assert balance >= get_max_load() and balance <= count_pids
    end

end
