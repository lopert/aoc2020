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

class EncodingErrorV2 < EncodingError
    def solve
        error = super
        sliding_window = []

        @number_output.each do |num|
            sliding_window << num
            sliding_window.shift while sliding_window.sum > error
            return (sliding_window.min + sliding_window.max) if sliding_window.sum == error
        end

        return "No solution found"
    end
end

solver = EncodingError.new
puts "Part 1: #{solver.solve}"

solver = EncodingErrorV2.new
puts "Part 2: #{solver.solve}"