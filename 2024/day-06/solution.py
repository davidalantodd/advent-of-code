file = open("data.txt")
file_data = file.read()

map = file_data.splitlines()

guard = []

for x, row in enumerate(map):
    map[x] = list(row)
    if "^" in row:
        guard = [x,row.index("^")]

steps = []

def in_bounds(map, location):
    return not (location[0] < 0 or location[0] >= len(map) or location[1] < 0 or location[1] >= len(map[0]))

# helper function to step through map

def step(map, location, steps):
    [x,y] = location
    if not in_bounds(map, location):
        return [map, location, steps, "done"]
    direction = map[x][y]
    map[x][y] = "X"
    if direction == "^":
        if in_bounds(map, [x-1,y]):
            if map[x-1][y] != "#":
                map[x-1][y] = "^"
                steps += [[x,y]]
                return [map, [x-1,y], steps, ""]
            else:
                map[x][y] = ">"
                return [map, [x,y], steps, ""]
        else:
            steps += [[x,y]]
            return [map, location, steps, "done"]
    elif direction == ">":
        if in_bounds(map, [x,y+1]):
            if map[x][y+1] != "#":
                map[x][y+1] = ">"
                steps += [[x,y]]
                return [map, [x,y+1], steps, ""]
            else:
                map[x][y] = "v"
                return [map, [x,y], steps, ""]
        else:
            steps += [[x,y]]
            return [map, location, steps, "done"]
    elif direction == "v":
        if in_bounds(map, [x+1,y]):
            if map[x+1][y] != "#":
                map[x+1][y] = "v"
                steps += [[x,y]]
                return [map, [x+1,y], steps, ""]
            else:
                map[x][y] = "<"
                return [map, [x,y], steps, ""]
        else:
            steps += [[x,y]]
            return [map, location, steps, "done"]
        
    elif direction == "<":
        if in_bounds(map, [x,y-1]):
            if map[x][y-1] != "#":
                map[x][y-1] = "<"
                steps += [[x,y]]
                return [map, [x,y-1], steps, ""]
            else:
                map[x][y] = "^"
                return [map, [x,y], steps, ""]
        else:
            steps += [[x,y]]
            return [map, location, steps, "done"]

# part 1

done = ""
location = guard
while done == "":
    [map, location, steps, done] = step(map, location, steps)

unique_locations = []
for step1 in steps:
    if step1 not in unique_locations:
        unique_locations += [step1]
print('part 1: ', len(unique_locations))

# part 2

infinite_loop_locations = []

for possible in unique_locations:
    file = open("data.txt")
    file_data = file.read()
    map = file_data.splitlines()
    for x, row in enumerate(map):
        map[x] = list(row)
    if possible != guard:
        map[possible[0]][possible[1]] = "#"
        done = ""
        prev_steps = 0
        loop_check = 0
        location = guard
        new_steps = []
        # try each location
        while loop_check <= 1000 and done == "":
            prev_steps = len(new_steps)
            [map, location, new_steps, done] = step(map, location, new_steps)
            if len(new_steps) == prev_steps:
                loop_check += 1
        if loop_check >= 1000:
            infinite_loop_locations += [possible]

print('part 2: ', len(infinite_loop_locations))

