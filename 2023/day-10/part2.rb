def solution
    file = File.read('data.txt').split("\n")

    grid = []
    animal = [-1,-1]

    file.each_with_index do |line, i|
        grid[i] = line.split("")
        index = grid[i].find_index {|x| x == "S"}
        if index != nil
            animal = [i,index]
        end
        
    end

    current = Array.new(animal)
    steps = 0

    #take first step for four path options
    north_path = [current[0]-1, current[1]]
    east_path = [current[0], current[1]+1]
    south_path = [current[0]+1, current[1]]
    west_path = [current[0], current[1]-1]

    #call function to find steps for each path
    north_steps, north_indexes = path_find(grid, north_path, "north", 0)
    east_steps, east_indexes = path_find(grid, east_path, "east", 0)
    south_steps, south_indexes = path_find(grid, south_path, "south", 0)
    west_steps, west_indexes = path_find(grid, west_path, "west", 0)
    
    final_path_indexes = []

    #check which paths found the loop (should be two), also capture final path indexes for part 2
    if east_steps > 0
        steps = (east_steps / 2) + (east_steps % 2)
        final_path_indexes = Array.new(east_indexes)
    elsif north_steps > 0
        steps = (north_steps / 2) + (north_steps % 2)
        final_path_indexes = Array.new(north_indexes)
    elsif south_steps > 0
        steps = (south_steps / 2) + (south_steps % 2)
        final_path_indexes = Array.new(south_indexes)
    elsif west_steps > 0
        steps = (west_steps / 2) + (west_steps % 2)
        final_path_indexes = Array.new(west_indexes)
    end

    # part 1
    p 'part1: ' + steps.to_s

    # create grid with north-facing-pipe markers to find inner tiles (e.g. point-in-polygon problem / non-zero winding rule)
    grid_part2 = Array.new(grid)
    grid_part2.each_with_index do |line, i|
        line.each_with_index do |l, j|
            # check for north-facing pipes and make sure it is actually part of the path
            if (l == "|" ||  l == "L" ||  l == "J") && final_path_indexes.include?([i, j])
                # mark these with an N
                grid_part2[i][j] = "N"
            else
                grid_part2[i][j] = "."
            end
        end
    end

    #replace the S with a north-facing pipe if needed
    if north_steps > 0
        grid_part2[current[0]][current[1]] = "N"
    end

    # create inner count to count inside tiles
    inner_counter = 0

    #iterate through each line of grid
    grid_part2.each_with_index do |row, i|
        #inner flag will let us know whether or not we are inside the loop
        inner_flag = false
        #iterate through each element of line
        row.each_with_index do |element, j|
            #check if the element is a north-facing pipe, and part of the path
            if element == "N"
                #flip inner flag so we either go from inside-to-outside, or outside-to-inside
                inner_flag = !inner_flag
            else
                #check to see if we are inside the loop
                if inner_flag == true
                    #check to make sure it's not just a path element
                    if !final_path_indexes.include?([i, j])
                        #increase the counter because we found an inner tile
                        inner_counter += 1
                    end
                end
            end
        end
    end
    p 'part2: ' + inner_counter.to_s
end


def path_find(grid, location, direction, steps)
    path_indexes = []
    found = 0
    while found == 0
        #capture path indexes
        path_indexes << [location[0], location[1]]
        steps += 1
        #check if went out of bounds
        if (location[0] < 0 || location[0] >= grid.length || location[1] < 0 || location[1] >= grid[0].length)
            steps = 0
            break
        #check if found animal
        elsif grid[location[0]][location[1]] == "S"
            found = 1
            break
        #check for each symbol, and depending on direction, take another step
        elsif grid[location[0]][location[1]] == "7"
            if direction == "east"
                # go south
                location[0] += 1 
                direction = "south"
            elsif direction == "north"
                # go west
                location[1] -= 1
                direction = "west"
            else
                steps = 0
                break
            end
        elsif grid[location[0]][location[1]] == "F"
            if direction == "north"
                # go east
                location[1] += 1
                direction = "east"
            elsif direction == "west"
                # go south
                location[0] += 1
                direction = "south"
            else
                steps = 0
                break
            end
        elsif grid[location[0]][location[1]] == "J"
            if direction == "east"
                # go north
                location[0] -= 1
                direction = "north"
            elsif direction == "south"
                # go west
                location[1] -= 1
                direction = "west"
            else
                steps = 0
                break
            end
        elsif grid[location[0]][location[1]] == "L"
            if direction == "south"
                # go east
                location[1] += 1
                direction = "east"
            elsif direction == "west"
                # go north
                location[0] -= 1
                direction = "north"
            else
                steps = 0
                break
            end
        elsif grid[location[0]][location[1]] == "|"
            if direction == "north"
                # go north
                location[0] -= 1
                direction = "north"
            elsif direction == "south"
                # go south
                location[0] += 1
                direction = "south"
            else
                steps = 0
                break
            end
        elsif grid[location[0]][location[1]] == "-"
            if direction == "east"
                # go east
                location[1] += 1
                direction = "east"
            elsif direction == "west"
                # go west
                location[1] -= 1
                direction = "west"
            else
                steps = 0
                break
            end
        else
            steps = 0
            break
        end
    end
    # p steps
    return [steps, path_indexes]
end


solution