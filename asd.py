t = []

for i in range(2):
    x = input('Enter roll.no: ')
    y = input('Enter name: ')
    z = input('Enter percentage: ')
    x = int(x)
    t.append((x, y, z))

print(t)

roll_number_to_find = int(input('Enter roll.no to search: '))
for record in t:
    if record[0] == roll_number_to_find:
        print(f"Record found: {record[0]}")
