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

        @mem.values.inject(:+)

    end

    def parse_instruction(line)
        type, value = line.split(" = ")

        if type.include?("mask")
            @mask = value
        else
            parse_memory_instruction(type, value)
        end
    end

    def parse_memory_instruction(type, value)
        address = type.split("[")[1][0..-2]
        @mem[address] = apply_mask(value)
    end

    def apply_mask(num)

        # convert to binary
        bin_num = "%036b" % num

        # apply mask
        @mask.split('').each_with_index do |mask, index|
            bin_num[index] = mask unless mask == "X"
        end

        # convert back to decimal and return
        bin_num.to_i(2)
    end

end

class DockingDataV2 < DockingData

    def parse_memory_instruction(type, value)
        address = type.split("[")[1][0..-2]

        masked_addresses = apply_mask(address)
        # puts "Mask leads to #{masked_addresses.length} addresses"
        # puts "Applying value of #{value}"
        masked_addresses.each do |address|
            @mem[address] = value.to_i
        end
    end

    def apply_mask(num)

        # convert to binary
        bin_num = "%036b" % num

        floating_indexes = []

        # apply mask
        @mask.split('').each_with_index do |mask, index|
            bin_num[index] = mask unless mask == "0"
            floating_indexes << index if mask == "X"
        end

        # create array of addresses to be expanded
        result = Array.new(2**floating_indexes.length) {bin_num.dup} #wtf why do I need .dup here, strings are shallow?!

        # treat all Xs as a binary number, to be incremented as we iterate over addresses
        current_float_bin = "%0#{floating_indexes.length}b" % 0

        # iterate over every address and sub X for 0s and 1s
        result.each do |num|
            floating_indexes.each_with_index do |char_index, float_bin_position|
                num[char_index] = current_float_bin[float_bin_position]
            end
            
            # increment binary number
            current_float_bin = "%0#{floating_indexes.length}b" % (current_float_bin.to_i(2).next)
        end

        # return decimal list of addresses to modify
        result.map {|e| e.to_i(2)}
    end


end

solver = DockingData.new
puts solver.solve #== 10050490168421

solver_two = DockingDataV2.new
puts solver_two.solve #== 2173858456958