class Ship
    
    def initialize
        @heading = 90
        @position = [0,0]
    end

    def perform(instruction)
        # puts "Performing #{instruction} from #{@position} #{@heading}"
        if instruction[:action] == "N"
            @position[1] += instruction[:value]
        elsif instruction[:action] == "S"
            @position[1] -= instruction[:value]
        elsif instruction[:action] == "E"
            @position[0] += instruction[:value]
        elsif instruction[:action] == "W"
            @position[0] -= instruction[:value]
        elsif instruction[:action] == "L"
            @heading -= instruction[:value]
        elsif instruction[:action] == "R"
            @heading += instruction[:value]
        elsif instruction[:action] == "F"
            if @heading == 90
                @position[0] += instruction[:value]
            elsif @heading == 180
                @position[1] -= instruction[:value]
            elsif @heading == 270
                @position[0] -= instruction[:value]
            elsif @heading == 0
                @position[1] += instruction[:value]
            end
        end

        #normalize heading
        @heading += 360 if @heading < 0
        @heading = @heading % 360

    end

    def distance
        @position[0].abs + @position[1].abs
    end

end

class RainRisk
    def initialize
        @instructions = File.read("day12input.txt").split("\n").map do |elem|
            { action: elem[0], value: elem[1..-1].to_i}
        end
        @ship = Ship.new
    end

    def solve
        @instructions.each do |ins|
            @ship.perform(ins)
        end

        puts @ship.distance
    end

end

solver = RainRisk.new
puts "Part 1:"
solver.solve

# Part 1 attempts
#1318 too high
#569 too low