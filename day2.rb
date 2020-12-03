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

    def solve_part_two
        file_data = File.read(@filename).split("\n")

        valid_count = 0

        file_data.each do |line|
            policy = parse_policy_part_two(line)
            password = parse_password(line)

            if validate_part_two(password, policy)
                valid_count += 1
                puts "Success! Currently at #{valid_count}"
            end
        end

        return valid_count
    end

    def parse_policy_part_two(line)
        policy = line.split(": ")[0]
        {
            character: policy.split(" ")[1],
            pos1: policy.split("-")[0].to_i,
            pos2: policy.split(" ")[0].split("-")[1].to_i
        } 
    end

    def validate_part_two(password, policy)
        (password[policy[:pos1]-1] == policy[:character]) ^ (password[policy[:pos2]-1] == policy[:character])
    end

end

solver = PasswordPolicyCop.new("day2input.txt")
puts solver.solve_part_one
puts solver.solve_part_two