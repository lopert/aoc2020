class DockingData

    def initialize
        @mask = ""
        @mem = {}
        @input = File.read("day14input.txt").split("\n")
    end

    def solve
        @input.each do |line|
            parse_instruction(line)
        end

        p @mem.values.inject(:+)

    end

    def parse_instruction(line)

        type = line.split(" = ")[0]
        value = line.split(" = ")[1]

        if type.include?("mask")
            @mask = value
        else
            address = type.split("[")[1][0..-2]
            @mem[address] = apply_mask(value)
        end
    end


    def apply_mask(num)

        # convert to binary
        bin_num = "%036b" % num

        # apply mask
        @mask.split('').each_with_index do |mask, index|
            if mask == "0"
                bin_num[index] = "0"
            elsif mask == "1"
                bin_num[index] = "1"
            end
        end

        # convert back to decimal and return
        bin_num.to_i(2)
    end


end

solver = DockingData.new
solver.solve

