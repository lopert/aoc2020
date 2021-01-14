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

class ShipV2 < Ship
    
    def initialize
        super
        @waypoint = Waypoint.new
    end

    def perform(instruction)
        # puts "Performing #{instruction} from #{@position} #{@heading}"
        @waypoint.perform(instruction) unless instruction[:action] == "F"

        if instruction[:action] == "F"
            @position[0] += @waypoint.position[0] * instruction[:value]
            @position[1] += @waypoint.position[1] * instruction[:value]
        end

    end

end

class Waypoint

    attr_accessor :position
    def initialize
        @position = [10,1]
    end

    def perform(instruction)
        @rotation = 0
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
            @rotation -= instruction[:value]
        elsif instruction[:action] == "R"
            @rotation += instruction[:value]
        end

        if @rotation == 90 or @rotation == -270
            tmp = @position[0]
            @position[0] = @position[1]
            @position[1] = -tmp
        elsif @rotation == 180 or @rotation == -180
            @position[0] = -@position[0]
            @position[1] = -@position[1]
        elsif @rotation == 270 or @rotation == -90
            tmp = @position[0]
            @position[0] = -@position[1]
            @position[1] = tmp
        end
    end
end

class RainRisk
    def initialize(ship)
        @instructions = File.read("day12input.txt").split("\n").map do |elem|
            { action: elem[0], value: elem[1..-1].to_i}
        end
        @ship = ship
    end

    def solve
        @instructions.each do |ins|
            @ship.perform(ins)
        end

        puts @ship.distance
    end

end

solver = RainRisk.new(Ship.new)
puts "Part 1:"
solver.solve

# Part 1 attempts
#1318 too high
#569 too low

solver_two = RainRisk.new(ShipV2.new)
puts "Part 2:"
solver_two.solve