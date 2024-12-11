file = open('data.txt')
file_data = file.read()

map = file_data.splitlines()

frequencies = {}

for x, line in enumerate(map):
    map[x] = list(line)
    for y, char in enumerate(line):
        if char != ".":
            if char not in frequencies:
                frequencies[char] = [[x,y]]
            else:
                frequencies[char] += [[x,y]]

final_antinodes = []

# run thru all permutations of same char, then place antinodes
for frequency in frequencies:
    for i in range(len(frequencies[frequency])):
        for j in range(i+1,len(frequencies[frequency])):
            loop_while = True
            counter = 1
            #calculate antinode distance
            first_x = frequencies[frequency][i][0]
            first_y = frequencies[frequency][i][1]
            second_x = frequencies[frequency][j][0]
            second_y = frequencies[frequency][j][1]
            x_diff = second_x - first_x
            y_diff = second_y - first_y

            if [first_x, first_y] not in final_antinodes:
                final_antinodes += [[first_x, first_y]]
            if [second_x, second_y] not in final_antinodes:
                final_antinodes += [[second_x, second_y]]
            
            while loop_while:
                # calculdate antinodes
                first_antinode_x = first_x - (x_diff * counter) if x_diff > 0 else first_x - (x_diff * counter)
                first_antinode_y = first_y - (y_diff * counter) if y_diff > 0 else first_y - (y_diff * counter)
                second_antinode_x = second_x + (x_diff * counter) if x_diff > 0 else second_x + (x_diff * counter)
                second_antinode_y = second_y + (y_diff * counter) if y_diff > 0 else second_y + (y_diff * counter)

                #check if antinode is in bounds
                first_antinode_valid = first_antinode_x >=0 and first_antinode_x < len(map) and first_antinode_y >= 0 and first_antinode_y < len(map)
                second_antinode_valid = second_antinode_x >=0 and second_antinode_x < len(map[0]) and second_antinode_y >= 0 and second_antinode_y < len(map[0])
                if first_antinode_valid:
                    if [first_antinode_x, first_antinode_y] not in final_antinodes:
                        final_antinodes += [[first_antinode_x, first_antinode_y]]
                if second_antinode_valid:
                    if [second_antinode_x, second_antinode_y] not in final_antinodes:
                        final_antinodes += [[second_antinode_x, second_antinode_y]]
                if not first_antinode_valid and not second_antinode_valid:
                    loop_while = False
                counter += 1

print('part 2: ', len(final_antinodes))