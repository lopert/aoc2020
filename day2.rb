# https://adventofcode.com/2020/day/2

class PasswordPolicyCop

    def initialize(input)
        @filename = input
    end

    def solve_part_one
        file_data = File.read(@filename).split("\n")

        valid_count = 0

        file_data.each do |line|
            policy = parse_policy(line)
            password = parse_password(line)

            valid_count += 1 if validate(password, policy)
        end

        return valid_count
    end

    def parse_policy(line)
        policy = line.split(": ")[0]
        {
            character: policy.split(" ")[1],
            min: policy.split("-")[0].to_i,
            max: policy.split(" ")[0].split("-")[1].to_i
        }
        
    end
    
    def parse_password(line)
        line.split(": ")[1]
    end

    def validate(password, policy)
        character_count = password.count(policy[:character])
        character_count >= policy[:min] and character_count <= policy[:max]
    end

end

solver = PasswordPolicyCop.new("day2input.txt")
puts solver.solve_part_one