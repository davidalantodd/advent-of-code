def solution
    file = File.read('data.txt').split("\n")
    part1_sum = 0
    game_sum_tracker = {}
    part2_sum = 0

    # iterate through each game
    file.each do |game|
        # organize numbers into arrays
        winning, numbers = game.split("| ")
        game_num, winners = winning.split(":")
        card, game_number = game_num.split(" ")

        game_sum = 0
        total_scratchcards = 0

        # part 1 - call function to calcuate the number of matches for game
        game_sum = calculate_matches(numbers, winners)
        # add to game sum tracker (hash)
        game_sum_tracker[game_number] = game_sum
        # update solution
        part1_sum += game_sum
    end

    # part 2 - calculate game numbers from sums in hash using log2(n)
    game_num_tracker = game_sum_tracker.transform_values { |sum| 
        if (Math.log2(sum).infinite? == 1 || Math.log2(sum).infinite? == -1)
            sum = 0.to_i
        elsif
            sum = Math.log2(sum).to_i + 1
        end
        sum
    }

    # part 2 - iterate through game tracker to calculate number of card copies needed
    game_num_tracker.each do |g_num, wins|
        # call function to calculate copies for each game
        part2_sum += calculate_copies(game_num_tracker, g_num, wins)
    end

    # print solutions
    p 'part 1: ' + part1_sum.to_s
    p 'part 2: ' + part2_sum.to_s
end

# part 1 - helper function to calculate matches for a game
def calculate_matches(numbers, winners)
    game_sum = 0
    # iterate through all numbers
    numbers.split(" ").each do |number|
        # check if there is a match using regex, and calculate points if a match exists
        if winners.match?(/ #{number} /)
            if (game_sum == 0)
                game_sum += 1
            else
                game_sum *= 2
            end
        end
    end
    return game_sum
end

# part 2 - recursive function to calculate card copies needed
def calculate_copies(game_num_tracker, g_num, wins)
    copies_to_add = 1
    # iterate through any additional cards if there were any winners/matches for this game
    for copy in (g_num.to_i+1)..(g_num.to_i+wins.to_i)
        # if a game has matches, calculate number of copies needed for each additional card
        if (game_num_tracker[copy.to_s] != nil)
            # call the recursive function on any cards with matches to calculate additional cards needed
            copies_to_add += (calculate_copies(game_num_tracker, copy, game_num_tracker[copy.to_s]))
        end
    end
    return copies_to_add
end

solution