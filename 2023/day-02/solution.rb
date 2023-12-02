# declare variable to hold max counts
@cubes = {'red' => 12, 'green' => 13, 'blue' => 14}

def solution
    file = File.read('data.txt').split("\n")

    # storing solutions
    possible_games = []
    impossible_games = []
    sum_of_powers = 0

    #iterate through each game
    file.each do |line|
        #grab data for each handful
        game = line.split(': ')
        handfuls = game[1].split('; ')

        #set counter variables for part 1 and 2
        possible = true
        fewest_cube_count = {'red' => 0, 'green' => 0, 'blue' => 0}

        #iterate through handfuls
        handfuls.each do |handful|
            #set starting val to count cubes in each handful
            cube_counts = handful.split(', ')
            current_game_counts = {'red' => 0, 'green' => 0, 'blue' => 0}

            #iterate through each type of cube in a handful
            cube_counts.each do |count|
                #grab each color count
                color_num = count.split(' ')

                #part1 - add cube counts to total for the current handful
                current_game_counts[color_num[1]] += color_num[0].to_i
                #part2 - store the necessary cubes needed for each handful to track fewest needed in a game
                if (fewest_cube_count[color_num[1]] < color_num[0].to_i)
                    fewest_cube_count[color_num[1]] = color_num[0].to_i
                end
            end

            #part1 - check if total is possible
            if (current_game_counts["red"] > @cubes["red"] ||
                current_game_counts["green"] > @cubes["green"] ||
                current_game_counts["blue"] > @cubes["blue"])
                possible = false
            end
        end

        #part1 - push to array if game was possible
        game_number = game[0].split(' ')
        if (possible)
            possible_games.push(game_number[1].to_i)
        elsif
            impossible_games.push(game_number[1].to_i)
        end

        #part2 - add the powers of the game together
        sum_of_powers += (fewest_cube_count["red"] * fewest_cube_count["green"] * fewest_cube_count["blue"])
    end

    #part1 - add possible game ids together
    part1_solution = possible_games.reduce(0) { |sum, curr_num| sum + curr_num }

    #print solutions
    p 'part1: ' + part1_solution.to_s
    p 'part2: ' + sum_of_powers.to_s

end

solution