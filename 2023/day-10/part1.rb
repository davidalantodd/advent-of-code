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
    north_steps = path_find(grid, north_path, "north", 0)
    east_steps = path_find(grid, east_path, "east", 0)
    south_steps = path_find(grid, south_path, "south", 0)
    west_steps = path_find(grid, west_path, "west", 0)

    #check which paths found the loop (should be two)
    if east_steps > 0
        steps = (east_steps / 2) + (east_steps % 2)
    elsif north_steps > 0
        steps = (north_steps / 2) + (north_steps % 2)
    elsif south_steps > 0
        steps = (south_steps / 2) + (south_steps % 2)
    elsif west_steps > 0
        steps = (west_steps / 2) + (west_steps % 2)
    end

    # part 1
    p 'part1: ' + steps.to_s

end


def path_find(grid, location, direction, steps)
    found = 0
    while found == 0
        #iterate steps
        steps += 1
        #check if went out of bounds
        if (location[0] < 0 || location[0] >= grid.length || location[1] < 0 || location[1] >= grid[0].length)
            steps = 0
            break
        #check if found animal
        elsif grid[location[0]][location[1]] == "S"
            found = 1
            break
        #check for each symbol, and depending on direction, take another step... (rinse and repeat for other symbols)
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
            #if no symbol was found
            steps = 0
            break
        end
    end
    return steps
end

solution