#parse txt file into int array
with open('day1_given-expense_report.txt','r') as f:
    content = f.read()
report = [int(i) for i in content.split()]

# Puzzle 1
def part1():
    #iterate through list, grabbing 2 unique values
    for i in range(len(report)):
        for j in range(i+1, len(report)):
            #check if their sum is equal to 2020
            if (report[i]+report[j])==2020:
                #print their product and stop searching
                print("Puzzle 1: {0} \t(product of {1} and {2})"\
                      .format((report[i]*report[j]),report[i],report[j]))
                return

# Puzzle 2
def part2():
    #iterate through list, grabbing 3 unique values
    for i in range(len(report)):
        for j in range(i+1, len(report)):
            for k in range(i+2, len(report)):
                #check if their sum is equal to 2020
                if (report[i]+report[j]+report[k])==2020:
                    #print their product and stop searching
                    print("Puzzle 2: {0} \t(product of {1}, {2}, and {3})"\
                          .format((report[i]*report[j]*report[k]),report[i],report[j],report[k]))
                    return

part1()
part2()
