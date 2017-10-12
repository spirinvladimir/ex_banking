defmodule Perfomance do

    @max 10

    def get_max_load() do
        @max
    end
    
    def check(load) do
        if load < @max do
            :ok
        else
            :error
        end
    end

end
