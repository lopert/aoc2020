# https://adventofcode.com/2020/day/2

class PasswordPolicyCop

    def initialize(input)
        @filename = input
    end

    def solve
        valid_count = 0

        read_file_from_disk.each do |line|
            policy = parse_policy(line)
            password = parse_password(line)

            valid_count += 1 if validate(password, policy)
        end

        return valid_count
    end

    def read_file_from_disk
        File.read(@filename).split("\n")
    end

    def parse_policy(line)
        policy = line.split(": ")[0]
        {
            character: policy.split(" ")[1],
            first: policy.split("-")[0].to_i,
            second: policy.split(" ")[0].split("-")[1].to_i
        } 
    end
    
    def parse_password(line)
        line.split(": ")[1]
    end

    def validate(password, policy)
        character_count = password.count(policy[:character])
        character_count >= policy[:first] and character_count <= policy[:second]
    end

end

class PasswordPolicyCopV2 < PasswordPolicyCop
    def validate(password, policy)
        (password[policy[:first]-1] == policy[:character]) ^ (password[policy[:second]-1] == policy[:character])
    end
end

solver = PasswordPolicyCop.new("day2input.txt")
puts solver.solve
solver2 = PasswordPolicyCopV2.new("day2input.txt")
puts solver2.solve