class EncodingError
    def initialize()
        @pre_length = 25
        @number_output = File.read("day11input.txt").split("\n").map!{|e| e.to_i }
    end

    def solve
        
        @number_output.each_cons(@pre_length+1) do |array|

            number = array.pop
            return number unless array.combination(2).detect { |a,b| a+b == number}

        end
    end
end

solver = EncodingError.new
puts "Part 1: #{solver.solve}"