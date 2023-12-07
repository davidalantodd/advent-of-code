def solution
    file = File.read('data.txt').split("\n")

    time = file[0].match(/(\w*)(\s*):(\s*)(\w*)(\s*)(\w*)(\s*)(\w*)(\s*)(\w*)/)
    distance = file[1].match(/(\w*)(\s*):(\s*)(\w*)(\s*)(\w*)(\s*)(\w*)(\s*)(\w*)/)

    times = []
    distances = []

    # put times and distances in an array
    for x in (4..time.length) do
        if x % 2 == 0 && time[x].to_i != 0
            times.append(time[x].to_i)
        end
    end
    for x in (4..distance.length) do
        if x % 2 == 0 && distance[x].to_i != 0
            distances.append(distance[x].to_i)
        end
    end

    # part 2 - create one joint time and distance
    part2_time_and_distance = [Array.new(times).join("").to_i, Array.new(distances).join("").to_i]

    ways_to_win = []
    
    # part 1 - iterate through each race
    times.each_with_index do |t, i|
        # call function to calculate number of ways to win per race
        ways_to_win.append(calculate_number_of_ways_to_win(t, distances[i]).length)
    end
    # multiply
    multiplied_ways = ways_to_win.reduce {|way, multiplied| way.to_i * multiplied}

    # part 2 - calculate the number of ways to win
    ways_to_win_part2 = calculate_number_of_ways_to_win(part2_time_and_distance[0], part2_time_and_distance[1])

    # print solutions
    p 'part 1: ' + multiplied_ways.to_s
    p 'part 2: ' + ways_to_win_part2.length.to_s
end

def calculate_number_of_ways_to_win(time, distance)
    winning_ways = []
    mm_per_ms = 0
    # iterate through every possible millisecond
    for ms in (0..time) do
        # calculate the time left after pushing the button
        time_left = time - ms
        # calculate millimeters per millisecond based on length of button press
        mm_per_ms = ms
        # caluclate distance travelled
        distance_travelled = mm_per_ms * time_left
        # check if it's a winner
        if (distance_travelled > distance)
            winning_ways.append(ms)
        end
    end
    return winning_ways
end

solution