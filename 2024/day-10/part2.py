file = open("data.txt")
file_data = file.read()

map = file_data.splitlines()

queue = []

# initialize queue with trailheads
for x, line in enumerate(map):
    for y, height in enumerate(line):
        if height == '0':
            queue += [[[x, y], [x,y], str(x) + str(y)]]

# check if the option is in bounds
def out_of_bounds(x, y, map):
    return x < 0 or x >= len(map) or y < 0 or y >= len(map[0])

# take a step and return it if gradual slope
def step(map, curr, prev):
    [[x, y], trailhead, path] = curr
    if int(map[x][y]) == int(prev) + 1:
        return [curr]
    else:
        return []

trailhead_scores = {}

# BFS to iterate through path options
while len(queue) > 0:
    curr = queue.pop(0)
    [[x,y], trailhead, path] = curr
    # check if we made it to the end
    if map[x][y] == '9':
        if tuple(trailhead) in trailhead_scores: # if the starting point exists
            if path not in trailhead_scores[tuple(trailhead)]: # check if it's a unique path
                trailhead_scores[tuple(trailhead)] += [path]
        else:
            trailhead_scores[tuple(trailhead)] = [path]
    else:
        # take steps in each direction and add any options to the queue
        if not out_of_bounds(x, y+1, map): #R
            queue += step(map, [[x, y+1], trailhead, path + str(x) + str(y+1)], map[x][y])
        if not out_of_bounds(x+1, y, map): #D
            queue += step(map, [[x+1, y], trailhead, path + str(x+1) + str(y)], map[x][y])
        if not out_of_bounds(x, y-1, map): #L
            queue += step(map, [[x, y-1], trailhead, path + str(x) + str(y-1)], map[x][y])
        if not out_of_bounds(x-1, y, map): #U
            queue += step(map, [[x-1, y], trailhead, path + str(x-1) + str(y)], map[x][y])

part_2 = 0

# calcuate score
for trailhead in trailhead_scores:
    part_2 += len(trailhead_scores[trailhead])

print('part 2: ', part_2)