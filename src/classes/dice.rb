class Dice

    attr_reader :value

    def initialize
        roll
    end

    def roll
        @value = rand(1..6)
    end

end