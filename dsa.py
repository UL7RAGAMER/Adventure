import random
import Data
from itertools import permutations

    

def globals_Chef():
    
    print('There are 3 dishes \n','1: Fish and  Chips \n', '2: Lasagna \n', '3: Ramen' )   
    dishes = ['Ramen'] * 10 + ['Lasagna'] * 20 + ['Fish and Chips'] * 70
    print('🐖 = Pork, 🐟 = Fish \n🐄 = Beef, 🐏 = Lamb \n🧅 = Onion, 🥬 = Lettuce \n🥕 = Carrot, 🍄 = Mushroom')
    dish = random.choice(dishes)

    if dish == 'Fish and Chips': 
        print(f'You have to make {dish} \n', 'It costs 700')
        Data.coins -= 700
        fish = ['🐟']
        perm = permutations(['🐖', '🍗', '🐏'],2)
        x = random.randint(1,6)
         
        count = 1
        for i in list(perm):            
            if count == x:
                for n in i:
                    pz = random.randint(0,2)
                    fish.insert(pz,n)
                    
            count += 1
            
        
        
        print(fish) 
        ch = input("Select the correct ingredient \n")
        if ch == 'fish':
            profit = (700 * 1/10 ) + 700
            print(f'Great job u earnt {profit} coins')
            Data.coins += profit
        else:
            chance = 0 
            while chance < 1:
                ch = input("Try again \n")
                ch = ch.lower()
                if ch == 'fish':
                    profit = (700 * 1/20 ) + 700
                    print(f'Great job u earnt {profit}')
                    Data.coins+=profit
                else:
                    print('You lost 700 coins')
                    Data.coins -= 700
                chance = 1
                    
            
    
    if dish == 'Lasagna':
        print(f'You have to make {dish} \n', 'It costs 1500')
        Data.coins -= 1500
        
        Tom = ['🍅']
        perm = permutations(['🧅', '🥬', '🥕', '🍄'],2)
        x = random.randint(1,12)
        count = 1
        for i in list(perm):            
            if count == x:
                for n in i:
                    pz = random.randint(0,2)
                    Tom.insert(pz,n)
                    
            count += 1
        print(Tom)
        ch = input("Select the correct ingredient \n")
        if ch == 'tomato':
            profit = (1500 * 1/10 )          
        else:
            chance = 0 
            while chance < 1:
                ch = input("Try again \n")
                if ch == 'tomato':
                    profit = (1500 * 1/20 ) 
                else:
                    print('You lose 300')
                    Data.coins -= 300   
                chance = 1
                    
        Bef = ['🐄']        
        perm = permutations(['🐖', '🍗', '🐏'],2)
        x = random.randint(1,6)         
        count = 1
        for i in list(perm):            
            if count == x:
                for n in i:
                    pz = random.randint(0,2)
                    Bef.insert(pz,n)
                    
            count += 1 
        print(Bef)
        ch = input("Select the correct ingredient")
        if ch == 'beef':
            profit2 = (1500 * 1/10 ) + profit + 1500
            print(f'Great job u earnt {profit2}')
        else:
            chance = 0 
            while chance < 1:
                ch = input("Try again /n")
                if ch == 'beef':
                    profit2 = (1500 * 1/50 ) + profit + 1500
                    print(f'Great job u earnt {profit2}')
                    Data.coins+=profit2
                else:
                    print('You lost 1200 coins')
                    Data.coins -= 1200       
                chance = 1
                    
    if dish == 'Ramen':
        print(f'You have to make {dish} \n', 'It costs 3000')
        Data.coins -= 3000
        Pork = ['']
        perm = permutations(['🐄', '🍗', '🐏'],2)
        x = random.randint(1,6)         
        count = 1
        for i in list(perm):            
            if count == x:
                for n in i:
                    pz = random.randint(0,2)
                    Pork.insert(pz,n)                    
            count += 1       
        
        print(Pork)
        ch = input("Select the correct ingredient  \n")
        if ch == 'pork':
            profit = (3000 * 1/10 ) 
            
        else:
            chance = 0 
            while chance < 1:
                ch = input("Try again \n")
                if ch == 'pork':
                    profit = (3000 * 1/50 ) 
                chance = 1
                            

        Carrot=['🥕']
        perm = permutations(['🍅', '🧅', '🥬', '🍄'],2)
        x = random.randint(1,12)
        count = 1
        for i in list(perm):            
            if count == x:
                for n in i:
                    pz = random.randint(0,2)
                    Carrot.insert(pz,n)
            count += 1        
        print(Carrot)
        ch = input("Select the correct ingredient \n")
        if ch == 'carrot':
            profit2 = (3000 * 1/10 ) + 3000 + profit
            print(f'Great job u earnt {profit2}')
        else:
            chance = 0 
            while chance < 1:
                ch = input("Try again \n")
                if ch == 'carrot':
                    profit2 = (3000 * 1/100 ) + 3000 + profit
                    print(f'Great job u earnt {profit2}')
                    Data.coins += profit2
                else:                    
                    print('You lost 1500 coins')
                    Data.coins -= 3000 
                chance = 1
              
    print(Data.coins)     
    
    
globals_Chef()