#first attempt using recursive solution, stack overflow error -- refactored in part1.rb
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

    number_north = take_step_north([current[0]-1, current[1]], grid, 1)

    number_east = take_step_east([current[0], current[1]+1], grid, 1)

    number_south = take_step_south([current[0]+1, current[1]], grid, 1)

    number_west = take_step_west([current[0], current[1]-1], grid, 1)

    p number_east
    p number_north
    p number_south
    p number_west

    if number_east > 0
        steps = (number_east / 2) + (number_east % 2)
    elsif number_north > 0
        steps = (number_north / 2) + (number_north % 2)
    elsif number_south > 0
        steps = (number_south / 2) + (number_south % 2)
    elsif number_west > 0
        steps = (number_west / 2) + (number_west % 2)
    end

    p steps
    return steps

end

def take_step_north(current, grid, steps)
    p [current[0], current[1]]
    p grid[current[0]][current[1]]
    #base case - found S, return 1
    if (current[0] < 0 || current[0] >= grid.length || current[1] < 0 || current[1] >= grid[0].length)
        return 0
    elsif grid[current[0]][current[1]] == "S"
        return steps
    elsif grid[current[0]][current[1]] == "7"
        return take_step_west([current[0], current[1]-1], grid, steps+1)
    elsif grid[current[0]][current[1]] == "F"
        return take_step_east([current[0], current[1]+1], grid, steps+1)
    elsif grid[current[0]][current[1]] == "|"
        return take_step_north([current[0]-1, current[1]], grid, steps+1)
    else
        return 0
    end
end

def take_step_east(current, grid, steps)
    p [current[0], current[1]]
    p grid[current[0]][current[1]]
    #base case - found S, return 1
    if (current[0] < 0 || current[0] >= grid.length || current[1] < 0 || current[1] >= grid[0].length)
        return 0
    elsif grid[current[0]][current[1]] == "S"
        return steps
    elsif grid[current[0]][current[1]] == "7"
        return take_step_south([current[0]+1, current[1]], grid, steps+1)
    elsif grid[current[0]][current[1]] == "J"
        return take_step_north([current[0]-1, current[1]], grid, steps+1)
    elsif grid[current[0]][current[1]] == "-"
        return take_step_east([current[0], current[1]+1], grid, steps+1)
    else
        return 0
    end
end

def take_step_south(current, grid, steps)
    p [current[0], current[1]]
    p grid[current[0]][current[1]]
    #base case - found S, return 1
    if (current[0] < 0 || current[0] >= grid.length || current[1] < 0 || current[1] >= grid[0].length)
        return 0
    elsif grid[current[0]][current[1]] == "S"
        return steps
    elsif grid[current[0]][current[1]] == "L"
        return take_step_east([current[0], current[1]+1], grid, steps+1)
    elsif grid[current[0]][current[1]] == "J"
        return take_step_west([current[0], current[1]-1], grid, steps+1)
    elsif grid[current[0]][current[1]] == "|"
        return take_step_south([current[0]+1, current[1]], grid, steps+1)
    else
        return 0
    end
end

def take_step_west(current, grid, steps)
    p [current[0], current[1]]
    p grid[current[0]][current[1]]
    #base case - found S, return 1
    if (current[0] < 0 || current[0] >= grid.length || current[1] < 0 || current[1] >= grid[0].length)
        return 0
    elsif grid[current[0]][current[1]] == "S"
        return steps
    elsif grid[current[0]][current[1]] == "L"
        return take_step_north([current[0]-1, current[1]], grid, steps+1)
    elsif grid[current[0]][current[1]] == "F"
        return take_step_south([current[0]+1, current[1]], grid, steps+1)
    elsif grid[current[0]][current[1]] == "-"
        return take_step_west([current[0], current[1]-1], grid, steps+1)
    else
        return 0
    end
end

solution