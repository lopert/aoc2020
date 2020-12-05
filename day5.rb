class BoardingPassDecoder

    def initialize
        @passes = File.read("day5input.txt").split("\n")
    end

    def solve
        highest_id_seat = {id: 0}
        @passes.each do |pass|
            seat = decode(pass)
            highest_id_seat = seat if seat[:id] > highest_id_seat[:id]
        end

        pp highest_id_seat[:id]
    end

    def decode(pass)

        row = pass.split('')[0..6].each.inject("") do |acc, digit|
            acc << convert_to_binary(digit)
        end

        column = pass.split('')[7..-1].each.inject("") do |acc, digit|
            acc << convert_to_binary(digit)
        end

        int_row = row.to_i(2)
        int_col = column.to_i(2)

        {
            row: int_row, 
            column: int_col,
            id: (int_row * 8 + int_col)
        }
    end

    def convert_to_binary(digit)
        if (digit == "F") or (digit == "L")
            "0"
        elsif (digit == "B") or (digit == "R")
            "1"
        end
    end

end

solver = BoardingPassDecoder.new()
solver.solve