class PassportChecker

    def initialize
        @data = File.read("day4input.txt").split("\n\n")
        @passports = []
        @alex = 0
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
        puts "Validating #{@passports.length} passports..."
        @passports.each do |passport|
            count += 1 if validate_passport(passport)
        end
        puts count
    end

    def validate_passport(passport)
        required_keys = ["byr","iyr","eyr","hgt","hcl","ecl","pid"]
        required_keys.each do |key|
            return false unless passport.key?(key.to_sym)
        end
        return true
    end

end

class PassportCheckerV2 < PassportChecker
    def validate_passport(passport)

        # pp passport

        # validate presence
        required_keys = ["byr","iyr","eyr","hgt","hcl","ecl","pid"]
        required_keys.each do |key|
            return false unless passport.key?(key.to_sym)
        end

        # pp "keys validated"

        return false unless ((passport[:byr].to_i >= 1920) and (passport[:byr].to_i <= 2002))
        return false unless ((passport[:iyr].to_i >= 2010) and (passport[:iyr].to_i <= 2020))
        return false unless ((passport[:eyr].to_i >= 2020) and (passport[:eyr].to_i <= 2030))

        # pp "numeric checks passed"
        return false unless validate_height(passport[:hgt])
        return false unless validate_hair_color(passport[:hcl])

        # pp "half of custom checks passed"
        return false unless validate_eye_color(passport[:ecl])

        # pp "only passport number remains!"
        return false unless validate_passport_number(passport[:pid])

        # pp "all checks passed"

        # pp passport

        return true

    end

    def validate_height(hgt)
        unit = hgt[-2..-1]
        dimension = hgt[0..-3].to_i

        # puts "#{unit}, #{dimension}"

        if unit == "cm"
            return false unless ((dimension >= 150) and (dimension <= 193))
        elsif unit == "in"
            return false unless ((dimension >= 59) and (dimension <= 76))
        else
            return false
        end

        # puts "#{unit}, #{dimension}"

        return true
    end

    def validate_hair_color(hcl)
        return false unless hcl.length == 7
        return false unless hcl[0] == "#"
        return !hcl[1..-1][/\H/] #https://stackoverflow.com/questions/20403636/how-to-validate-that-a-string-is-a-proper-hexadecimal-value-in-ruby
    end

    def validate_eye_color(ecl)
        ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].include?(ecl)
    end

    def validate_passport_number(pid)
        return false unless pid.length == 9
        return !!pid[/\d{9}/]
    end

end

pp "PART 1"

solver = PassportChecker.new()
solver.solve

pp "PART 2"
solver2 = PassportCheckerV2.new()
solver2.solve