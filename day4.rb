class PassportChecker

    def initialize
        @data = File.read("day4input.txt").split("\n\n")
        @passports = []
    end

    def solve
        generate_passport_objects
        count_valid_passports
    end

    def generate_passport_objects

        @data.each do |raw|

            current_passport = {}
            
            # each pair in the line
            raw.gsub("\n"," ").split(" ").each do |pair|
                kv = pair.split(":")
                current_passport.merge!({kv[0].to_sym => kv[1]})
            end

            @passports << current_passport
            
        end

    end

    def count_valid_passports
        count = 0
        required_keys = ["byr","iyr","eyr","hgt","hcl","ecl","pid"]
        @passports.each do |passport|
            count += 1 if validate_passport(passport, required_keys)
        end
        puts count
    end

    def validate_passport(passport, required_keys)
        required_keys.each do |key|
            return false unless passport.key?(key.to_sym)
        end
        return true
    end


end

pp "PART 1"

solver = PassportChecker.new()
solver.solve