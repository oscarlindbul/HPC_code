import re
from subprocess import check_output
from tabulate import tabulate

result_files=["naive_results_64.txt","opt_results_64.txt", "naive_results_1000.txt","opt_results_1000.txt"]

fields=["instructions", "cycles", "L1-dcache-load-misses", "L1-dcache-loads", "LLC-load-misses", "LLC-loads", "seconds"]

field_pattern = re.compile("\s+([\d,\s]+).*")

data = {}
for file in result_files:
    data[file] = {}
    for field in fields:
        field_string = check_output(["grep", "--text", field, file]).decode("utf-8")
        match = field_pattern.match(field_string)
        num = match.group(1).replace(" ", "")
        if "," in num:
            field_val = float(num.replace(",","."))
        else:
            field_val = int(num)
        data[file][field] = field_val
    data[file]["instructions per cycle"] = data[file]["instructions"] / data[file]["cycles"]
    data[file]["L1 miss ratio"] = data[file]["L1-dcache-load-misses"]/data[file]["L1-dcache-loads"]
    data[file]["L1 miss rate"] = data[file]["L1-dcache-load-misses"]/(data[file]["instructions"]/1000)
    data[file]["LLC miss ratio"] = data[file]["LLC-load-misses"]/data[file]["LLC-loads"]
    data[file]["LLC miss rate"] = data[file]["LLC-load-misses"]/(data[file]["instructions"]/1000)


table = [[0 for j in range(5)] for i in range(7)]
table[0][0] = "Event Name"
table[0][1] = "MSIZE=64 Naive"
table[0][2] = "MSIZE=64 Optimized"
table[0][3] = "MSIZE=1000 Naive"
table[0][4] = "MSIZE=1000 Optimized"
table[1][0] = "Elapsed time (seconds)"
table[2][0] = "Instructions per cycle"
table[3][0] = "L1 cache miss ratio"
table[4][0] = "L1 cache miss rate PTI"
table[5][0] = "LLC cache miss ratio"
table[6][0] = "LLC cache miss rate PIT"
op_order = ["seconds", "instructions per cycle", "L1 miss ratio", "L1 miss rate", "LLC miss ratio", "LLC miss rate"]
for i in range(6):
    for j in range(4):
        table[i+1][j+1] = data[result_files[j]][op_order[i]]

print(tabulate(table, tablefmt="latex"))
