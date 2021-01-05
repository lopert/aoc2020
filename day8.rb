class GameConsole

    def initialize
        @accumulator = 0
        @instructions = File.read("day8input.txt").split("\n")
        @current_line = 0
        @executed_lines = []
    end

    def boot

        until jackout?(@current_line)
            @executed_lines << @current_line

            ins = parse_instruction(@instructions[@current_line])

            puts "Executing #{@current_line}: #{ins[:instruction]} #{ins[:num]}"

            self.send(ins[:instruction],ins[:num])
        end

        puts "Infinite Loop detected. Accumulator value: #{@accumulator}"

    end

    def jackout?(line_number)
        @executed_lines.include?(line_number)
    end

    def acc(num)
        @accumulator += num
        @current_line += 1
    end

    def nop(num)
        # do nothing
        @current_line += 1
    end

    def jmp(num)
        @current_line += num
    end

    def parse_instruction(line)
        # parse instruction
        instruction = line.split(" ")[0]

        # parse num
        num = line.split(" ")[1].delete('+')

        {instruction: instruction, num: num.to_i}
    end
end

solver = GameConsole.new.boot