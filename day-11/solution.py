import math

file = open('data.txt', 'r')
file_data = file.read()
lines = file_data.splitlines()

class Monkey:
    def __init__(self, id, items, operation, test, true_resule, false_result):
        self.id = id
        self.items = items
        self.operation = operation
        self.test = test
        self.true_result = true_result
        self.false_result = false_result
        self.inspected = 0

monkeys = []
starting_items = []
operation = ""
test = ""
true_result = ""
false_result = ""

def worry(current_level, type, level):
    if level == "old":
        level = int(current_level)
    if type == "+":
        return int(current_level) + int(level)
    elif type == "*":
        return int(current_level) * int(level)

def relief(current_level):
    return math.floor(int(current_level) / 3)

def monkey_test(current_level, divisor):
    if int(current_level) % int(divisor) == 0:
        return True
    elif int(current_level) % int(divisor) != 0:
        return False

#organize file content
for line in lines:
    l = line.strip()
    print(l)
    if l[0:6] == "Monkey":
        monkey_num = l.split(" ")[1].strip(":")
        # monkey_num = monkey_num[1].strip(":")
    elif l[0:14] == "Starting items":
        starting_items = l.split('Starting items: ')
        starting_items = starting_items[1:][0].split(', ')
    elif l[0:9] == "Operation":
        operation = l.split('Operation: ')
        operation = operation[1].split(' ')
        operation = operation[3:]
        print(operation)
    elif l[0:4] == "Test":
        test = l.split('Test: ') 
        test = test[1].split(' ')
        test = test[2]
        print(test)
    elif l[0:7] == "If true":
        true_result = l.split('If true: ') 
        true_result = true_result[1].split(' ')
        true_result = true_result[3]
        print(true_result)
    elif l[0:8] == "If false":
        false_result = l.split('If false: ')
        false_result = false_result[1].split(' ')
        false_result = false_result[3]
        print(false_result)
        new_monkey = Monkey(monkey_num, starting_items, operation, test, true_result, false_result)
        monkeys.append(new_monkey)
        print(new_monkey.__dict__)
        print(monkeys)
    elif l == "":
        monkey_num = ''
        starting_items = ''
        operation = ''
        test= ''
        true_result = ''
        false_result = ''

#iterate for 20 rounds
for round in range(20):

    #iterate through monkeys
    for r in range(len(monkeys)):
        print(monkeys[r].__dict__)
        
        #iterate through items
        for i, item in enumerate(monkeys[r].items):
            monkeys[r].items[i] = worry(item, monkeys[r].operation[0], monkeys[r].operation[1])
            print('after worry', monkeys[r].items[i])
            monkeys[r].items[i] = relief(monkeys[r].items[i])
            print('after relief',monkeys[r].items[i])
            if (monkey_test(monkeys[r].items[i], monkeys[r].test)):
                    print('monkey test is true')
                    monkeys[int(monkeys[r].true_result)].items.append(monkeys[r].items[i])
            else:
                    print('monkey test is false')
                    monkeys[int(monkeys[r].false_result)].items.append(monkeys[r].items[i])
            monkeys[r].inspected += 1
        monkeys[r].items = []
    for m in monkeys:
            print(m.__dict__)


item_lens = {}
for i, mons in enumerate(monkeys):
    item_lens[i] = mons.inspected

sorted_monkeys = sorted(item_lens.items(), key = lambda x : x[1], reverse=True)
print(sorted_monkeys)
monkey_business = int(sorted_monkeys[0][1]) * int(sorted_monkeys[1][1])
print('solution to part 1: ', monkey_business)

#define a monkey
# items list
# operation
# who to throw to

#monkeys should go in order

#divide worry level by three each time