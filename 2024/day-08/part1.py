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
            
            #calculate antinodes
            first_x = frequencies[frequency][i][0]
            first_y = frequencies[frequency][i][1]
            second_x = frequencies[frequency][j][0]
            second_y = frequencies[frequency][j][1]
            x_diff = second_x - first_x
            y_diff = second_y - first_y

            first_antinode_x = first_x - x_diff if x_diff > 0 else first_x - x_diff
            first_antinode_y = first_y - y_diff if y_diff > 0 else first_y - y_diff
            second_antinode_x = second_x + x_diff if x_diff > 0 else second_x + x_diff
            second_antinode_y = second_y + y_diff if y_diff > 0 else second_y + y_diff

            #check if antinode is in bounds
            if first_antinode_x >=0 and first_antinode_x < len(map) and first_antinode_y >= 0 and first_antinode_y < len(map):
                if [first_antinode_x, first_antinode_y] not in final_antinodes:
                    final_antinodes += [[first_antinode_x, first_antinode_y]]
            if second_antinode_x >=0 and second_antinode_x < len(map[0]) and second_antinode_y >= 0 and second_antinode_y < len(map[0]):
                if [second_antinode_x, second_antinode_y] not in final_antinodes:
                    final_antinodes += [[second_antinode_x, second_antinode_y]]
        
print('part 1: ', len(final_antinodes))