import re

file = open("data.txt")
file_data = file.read()

# DFS - find XMAS in any direction
def step(data, x, y, word, x_direction, y_direction):
    if x < 0 or x >= len(data[0]) or y < 0 or y >= len(data):     # out of bounds
        return 0
    if word == "" and data[x][y] == "X":    # if X match
        word += "X"
         # if there is an X match, keep stepping and store direction
        return step(data, x, y+1, word, 0, 1) + step(data, x, y-1, word, 0, -1) + step(data, x+1, y, word, 1, 0)+ step(data, x-1, y, word, -1, 0) + step(data, x+1, y+1, word, 1, 1) + step(data, x-1, y-1, word, -1, -1) + step(data, x+1, y-1, word, 1, -1) + step(data, x-1, y+1, word, -1, 1)
    elif word == "X" and data[x][y] == "M": # if M match
        word += "M"
    elif word == "XM" and data[x][y] == "A": # if A match
        word += "A"
    elif word == "XMA" and data[x][y] == "S": # if S match, we found one!
        return 1
    else:
        return 0    # dead end
    
    # keep stepping in the same direction
    return step(data, x + x_direction, y + y_direction, word, x_direction, y_direction)
    
# iterate
def word_search_part_1(data):
    total = 0
    lines = data.splitlines()
    for x in range(len(lines[0])):
        for y in range(len(lines)):
           total += step(lines, x, y, "", 0, 0)
    return total

# part 2

# check for possibilities
# M S     M M     S S     S M
#  A       A       A       A
# M S     S S     M M     S M
def is_valid(valid_letters):
    if (len(valid_letters) == 5):
        if valid_letters[1] == "M":
            if valid_letters[2] == "S" and valid_letters[3] == "M" and valid_letters[4] == "S":
                return 1
            elif valid_letters[2] == "M" and valid_letters[3] == "S" and valid_letters[4] == "S":
                return 1
        elif valid_letters[1] == "S":
            if valid_letters[2] == "S" and valid_letters[3] == "M" and valid_letters[4] == "M":
                return 1
            elif valid_letters[2] == "M" and valid_letters[3] == "S" and valid_letters[4] == "M":
                return 1
    else:
        return 0
    return 0

# grab the xmas letters and put them in a list
def get_x_mas(data, x, y, word):
    if x < 0 or x >= len(data[0]) or y < 0 or y >= len(data):     # out of bounds
        return []
    if word == [] and data[x][y] == "A":
        word += ["A"]
        word += get_x_mas(data, x-1, y-1, word) +  get_x_mas(data, x+1, y-1, word) + get_x_mas(data, x-1, y+1, word) + get_x_mas(data, x+1, y+1, word)
    elif word == ["A"]:
        return [data[x][y]]
    else:
        return []
    return word

# iterate through grid   
def word_search_part_2(data):
    total = 0
    lines = data.splitlines()
    for x in range(len(lines[0])):
        for y in range(len(lines)):
           output = get_x_mas(lines, x, y, [])
           total += is_valid(output)
    return total


print('part 1: ', word_search_part_1(file_data))
print('part 2: ', word_search_part_2(file_data))
