import math

file = open("data.txt")
file_data = file.read()
lines = file_data.splitlines()

# store rules + updates
rules = []
updates = []
for line in lines:
    if line != '':
        if line[2] == "|":
            rules += [line.split("|")]
        elif line[2] == ",":
            updates += [line.split(",")]

incorrect_update_indices = []
incorrect_updates = []

# iterate through rules
for rule in rules:
    # iterate through updates to check for correct order
    for index, update in enumerate(updates):
        if rule[0] in update and rule[1] in update:
            if update.index(rule[0]) > update.index(rule[1]):
                # store for part 2
                if index+1 not in incorrect_update_indices:
                    incorrect_updates += [update]
                # store all incorrect indices
                incorrect_update_indices += [index+1]   

correct_updates = []
part_1_solution = 0

# iterate through updates and remove incorrect updates to create clean update list
for index, update in enumerate(updates):
    if (index+1) not in incorrect_update_indices:
        correct_updates += update
        part_1_solution += int(update[math.floor(len(update)/2)])

print('part 1: ', part_1_solution)

# part 2
rule_map = {}

for rule in rules:
    if rule[0] in rule_map:
        rule_map[rule[0]] += [rule[1]]
    else:
        rule_map[rule[0]] = [rule[1]]

# create sorting function based on rule map
def compare_values(first_val, second_val, rule_map):
    if first_val in rule_map and second_val in rule_map[first_val]:
        return -1
    elif second_val in rule_map and first_val in rule_map[second_val]:
        return 1
    else:
        return 0

# create sort key
def create_sort_key(page1, update, rule_map):
    sort_key = []
    for page2 in update:
        comparison_result = compare_values(page1, page2, rule_map)
        sort_key.append(comparison_result)
    return sort_key

# iterate over and sort incorrect updates using rule map
for i, update in enumerate(incorrect_updates):
    incorrect_updates[i] = sorted(update, key=lambda page1: create_sort_key(page1, update, rule_map))
                     
part_2_solution = 0

# calcaluate solution
for update in incorrect_updates:
    part_2_solution += int(update[math.floor(len(update)/2)])

print('part 2: ', part_2_solution)