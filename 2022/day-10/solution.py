import math

file = open("data.txt", "r")
file_data = file.read()
moves = file_data.splitlines()

#initialize
x = 1
cycle_num = 0
cycles = []
signals = {}
CRT = [['.' for i in range(40)] for j in range(6)]

#visulizer
def printCRT():
    for line in CRT:
        for pix in line:
            print(pix,end='')
        print()

#part 2 - calculate row and column and change CRT if sprite location matches
def draw_CRT(cycle_num):
    current_CRT_row = (math.floor(cycle_num / 40))
    if abs(x - (cycle_num % 40 - 1)) < 2:
        CRT[current_CRT_row][cycle_num % 40 - 1] = "#"

for m in moves:
    if m[0:4] == 'addx':
        #addx
        instr, value = m.split(' ')
        print(instr, value)

        #first cycle
        cycles.append(x)
        cycle_num+=1
        if (cycle_num - 20) % 40 == 0:
            signals[cycle_num] = cycle_num * x
        draw_CRT(cycle_num)
        # printCRT()

        #second cycle
        cycles.append(x)
        cycle_num+=1
        if (cycle_num - 20) % 40 == 0:
            signals[cycle_num] = cycle_num * x
        draw_CRT(cycle_num)
        x+=int(value)
        # printCRT()
    else:
        #noop
        cycle_num+=1
        if (cycle_num - 20) % 40 == 0:
            signals[cycle_num] = cycle_num * x
        draw_CRT(cycle_num)
        # printCRT()
    
print(signals)

#filtering for keys <= 180
signals_to_sum = dict(filter(lambda strength: strength[0] <= 220, signals.items()))
print("solution to part 1: ",sum(signals_to_sum.values()))

print("solution for part 2:")
printCRT()