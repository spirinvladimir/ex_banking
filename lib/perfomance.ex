defmodule Perfomance do

    @max 10

    def check(user) do
        if user[:load] < @max do
            :ok
        else
            :error
        end
    end

end
