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

class BoardingPassFinder < BoardingPassDecoder
    def solve
        all_ids = []
        @passes.each do |pass|
            all_ids << decode(pass)[:id]
        end
        
        pp find_missing_id(all_ids)
    end

    def find_missing_id(ids)
        ids = ids.sort
        missing_ids = []
        ids.each_with_index do |id, index|
            prev_id = ids[index-1]

            # avoid the first id - there must be a better way to do this
            next if prev_id == ids[-1]

            # pp "Comparing #{id} to #{prev_id} + 1... #{id == (prev_id+1)}"
            return id - 1 unless id == (prev_id+1)

        end

        missing_ids
    end

end

puts "Part One"
solver = BoardingPassDecoder.new()
solver.solve

puts "Part Two"
solver2 = BoardingPassFinder.new()
solver2.solve
# 563 too high