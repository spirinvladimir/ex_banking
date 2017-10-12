defmodule Perfomance do

    @max 10

    def check(load) do
        if load < @max do
            :ok
        else
            :error
        end
    end

end
