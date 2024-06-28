# 1. Formatted String
# print(f'({x}, {y} )')
#------------------------------------

# 2. Complex typex
# print(type(5))
# print(type(range(5)))
#------------------------------------

# 3.Iterable
# for x in 'World':
# for x in [1, 2, 3, 4]:
# for x in [{}, {}, {}]:
# for x in [[], 1, {}, 'a']:
# for x in {1: 'a'}:
    # print(x)
#------------------------------------

# 4.Optional parameter
# def increment(number, by=1):
#     return number * by
# print(increment(2))
#------------------------------------

# 5.Named parameters
# def increment(number, by):
#     return number * by
# print(increment(number=10, by=3.3))
#------------------------------------
# def miltiply(*numbers):
#     print(numbers)
# miltiply([2, 8, 5])
#------------------------------------

#------------------------------------

#------------------------------------

#------------------------------------

#------------------------------------

#------------------------------------

#------------------------------------

#------------------------------------

#------------------------------------

#------------------------------------


#-------------------------------------------- EX 1 (START)-----------------------------------
# num = 0

# for x in range(1, 10):
#     if x % 2 == 0:
#         print(x)
#         num += 1

# print(f'We have {num} even numbers')        
#-------------------------------------------- EX 1 (END) -----------------------------------

# name = input('Как тебя зовут? ')
# print('Привет,', name)

# x1, x2, x3 = input('X1: '), input('X2: '), input('X3: ')
# print(f'x1: {x1}, x2: {x2}')


# a = dict(color='red', model='VC6', dimensions='30x50')
# print(type(a))


#*****************************************************   1. Basic type & Input + Cast
# name, surname, age = input('name: '), input('surname: '), input('age: ')
# print(f'Name: {name}\nSurname: {surname}\nAge: {age}')

# 6 
# width, length = float(input('Input the width: ')), float(input('Input the length: '))
# print('Square S =  ', width * length)
# print('Perimetr P = ', 2 * (width + length))

# 7
# shift = 0
# while not int(shift) in range(420,541):
#     shift = int(input("Please enter your shift (420 - 540) : "))#choose a shift
# print(f'Set alarm clock on {shift // 60}:{shift % 60}')

#8
# daysQuantity = int(input('Enter days quantity: '))
# years = daysQuantity // 365
# months = (daysQuantity % 365) // 30
# days = (daysQuantity % 365) % 30
# print(f'Years: {years} Months: {months}  Days: {days}')


# 9
# secondsQuantity = int(input('Enter seconds: '))
# hours = secondsQuantity // 3600
# minutes = (secondsQuantity % 3600) // 60
# seconds = (secondsQuantity % 3600) % 60
# print(f'Hours: {hours} Minutes: {minutes} Seconds: {seconds}')

#*****************************************************   2 Strings

# str = 'Pythonthebest'
# str2 = '213123123'
# str3 = '-5.55'
# str4 = '-2'
# print(str.isalpha())
# print(str2.isdigit())
# print(str3.isnumeric())
# print(str4.isnumeric())


# obj = ['1', 4, {}]
# st = str(obj)

# text = 'Python - простой и понятный язык и что-нибудь другое'
# kort = text.partition('и')
# tuple состоит из 3 елементов ('Python - простой ', 'и', ' понятный язык и что-нибудь другое')

#1
# text = input('Enter the string: ')
# print(len(text))
# print(text.isalnum())

#2
# text = input('Enter the string: ').lower()
# print(text == text[::-1])

#3
# text = input('Enter the string: ')
# print(text.title())

#4
# text = '12361573928167047230472012'
# print(text.replace('1', 'one'))

#5
# name, surname, fatherName, jobPosition = input('Name: '), input('Surname: '), input('Father name: '), input('Job position: ')
# print(f'{name[0]}. {surname[0]}. {fatherName}, {jobPosition}')

#6
# text, letter = input('Enter the string: ').lower(), input('Enter the letter: ').lower()
# print(letter in text)

#7
# text = input('Enter the string: ').lower()
# vowels = 'уеыаоиюэ'
# print(text in vowels)

#8
# text, subtext = input('Enter the string: ').lower(), input('Enter the substring: ').lower()
# print(text.find(subtext), text.rfind(subtext))

#9
# text = input('Enter the string: ').lower()
# spacesCount = text.count(' ')
# noSpace = text.replace(' ', '')
# print(f'Spaces: {spacesCount}, Other symbols count: {len(noSpace)}')

#10
# text, startStr, endStr = input('Enter the string: ').lower(), input('Start: ').lower(), input('End: ').lower()
# print(text.startswith(startStr))
# print(text.endswith(endStr))

#*****************************************    LISTS    ********************************************
#1
# lst = [int(i) for i in input() if i.isdigit()]
# print(min(lst), max(lst), sum(lst), sep='\n')

#2
# st = [int(i) for i in input().split()]
# lst = [i for i in st if st.count(i) > 1]
# print(lst)
# print(*lst)

#3
# st = [int(i) for i in input().split(',')]
# lst1 = [i for i in st if i % 2 == 0]
# lst2 = [i for i in st if i % 2 != 0]
# print(*lst1)
# print(*lst2)

#5
# st = list(input())
# err = st.index('#')
# del st[err]
# sp = ''.join(st)
# word = max(sp.split(), key=len)
# print(sp, word, sep='\n')


#6
# st = list(i for i in input().split(' ') if i.isalpha())
# st.sort(key=len)
# print(*st, sep='\n')

#7
# st = list(input().split(' '))
# glas = 'уеёэоаыяию'
# st1 = [i for i in st if i[0] in glas]
# st2 = [i for i in st if i[0] not in glas]
# print(*st1)
# print(*st2)

#8




# st.sort(key=len)
# print(*st, sep='\n')


# err = st.index('#')
# del st[err]
# sp = ''.join(st)
# word = max(sp.split(), key=len)
# print(sp, word, sep='\n')



#*****************************************    TUPLES    ********************************************

# num = '312372534'
# print(tuple(str(num)))
# print(tuple(str(num).partition('7')))


# letters = ('P', 'y', 't', 'h', 'o', 'n')
# print(''.join(letters))

#1
# text = input('Enter numbers as String:  ')


#*********************************************************************************************************************************************

#*****************************************    FOR LOOP   ********************************************

##Ввод матрицы c помощью for
# n = int(input())
# lst = []
# for i in range(n):
#     lst.append(list(map(int, input().split())))
    
# #Вывод матрицы 1    
# for i in lst:
#     print(*i)

# #Вывод матрицы 2    
# for i in range(len(lst)):
#     for j in range(len(lst)):
#         print(lst[i][j], end=' ')
#     print()
# print() 

# # две переменной в цикле (работа со словарем)
# my_dict = {'цвет': 'красный', 'артикул': 'ABC123', 'цена': 650}
# for k, v in my_dict.items():
# 	print(f'{k} - {v}')

# #Если переменная не используется в теле цикла, вместо названия можно указывать символ подчеркивания _
# mydict = {}
# for _ in range(int(input())):
# 	k, v = input().split(': ')
# 	mydict[k.capitalize()] = v.title()


# ops = {'-':'a - b', '+':'a + b', '*': 'a * b', '/':'a / b'}
# a, b = int(input('Введите значение a: ')), int(input('Введите значение b: '))
# op = input('Введите знак операции: ')
# if op in ops.keys():
#     print(eval(ops[op]))
# else:
#     print('Поддерживаются операции +, -, * и /')


#  ***** Zadachi *****

#1 Elochka
# n = int(input('Number of rows:'))

# for i in range(1, n + 1):
#     print('*' * i)

#2
#    3 -5 2 4 12 7 3 4 6 9 25 -50 12 35 2 11
# input = list(map(int, input().split()))

# positCount = 0
# negArr = []

# for i in input:
#     if i > 0:
#         positCount += 1 
#     elif i < 0:
#         negArr.append(i)

# mult = 1
# if len(negArr) > 0:
#     for i in negArr:
#         mult *= i

# print(positCount) 
# print(mult) 


#****************************************     WHILE LOOP    ***********************
# n = int(input())
# while n != 0:
#     print(n + 5)
#     n = int(input())


# import random
# lst = [i for i in range(random.randint(5, 10))]
# while True:
#     if not lst:
#         break
#     print(lst.pop())

#****************************************     FUNCTIONS   ***********************

# def my_function(*args):
#     print(type(args))
#     print(f'Минимальное число: {min(args)}, максимальное: {max(args)}')
# my_function(1, 4, 5, 2, -5, 0, 12, 11)

#**************

#Аргументы *args обрабатываются после позиционных, но до аргументов по умолчанию:
        
# def my_function(x, y, *args, kx=15, ky=15):
#     print(x, y, args, kx, ky)
# my_function(5, 6, 7, 8, 9, 0, 4)  

#**************

# **kwargs Если в функцию нужно передать произвольное количество пар ключ=значение, используют параметр **kwargs. С **kwargs работают все методы словарей
# def my_function(**kwargs):
#     print(f'Самый легкий металл - {min(kwargs, key=kwargs.get)} {min(kwargs.values())}, самый тяжелый - {max(kwargs, key=kwargs.get)} {max(kwargs.values())}')
# my_function(осмий=22.61, цинк=7.1, золото=19.3, ртуть=13.6, олово=7.0)

#**************

#Аргументы типа **kwargs обрабатываются после позиционных, *args и аргументов по умолчанию:

# def my_function(x, y, *args, kx=15, ky=15, **kwargs):
#     print(x, y, args, kx, ky, kwargs)
# my_function(7, 8, 0, 3, 4, 1, 8, 9, север=15, запад=25, восток=45, юг=10)

#Вывод:
#7 8 (0, 3, 4, 1, 8, 9) 15 15 {'север': 15, 'запад': 25, 'восток': 45, 'юг': 10}

#**************************************** LAMBDA FUNCTIONS (ANONIMOUS FUNCTIONS)  ***********************

# mydict = {'слива':5, 'папайя':6, 'лук':56, 'маракуйя':78, 'ежевика':45}

# print('До сортировки: ', mydict)
# sorted_mydict = dict(sorted(mydict.items(), key=lambda item: len(item[0])))
# print('После сортировки: ', sorted_mydict)

# test = lambda a, b : print(a) if a > b else print(b)
# test(10, 77)

# fruit = [
#     {'название':'виноград',
#      'цена': 230,
#      'количество': 412
#     },
#     {'название':'манго',
#      'цена': 350,
#      'количество': 21
#     },
#     {'название':'бананы',
#      'цена': 70,
#      'количество': 234
#     },
#     {'название':'яблоки',
#      'цена': 66,
#      'количество': 213
#     },
#     ]
# print(sorted(fruit, key=lambda item: item['цена']))
# # print(sorted(fruit, key=lambda item: item['название']))
# # print(sorted(fruit, key=lambda item: len(item['название'])))

# st = 'яжертыуиопшщасдфгчйклзхцвбнм'
# vowels = 'аиеёоуыэюя'

# result = list(map(lambda x: 'гласная' if x in vowels else 'согласная', st))

# print(result)


# def recursive():
#     recursive()
# recursive()

#////////////////////////////////     DECORATORS      ///////////////////////////////////
#1
# def debug_decorator(func):
#     def wrapper(*args, **kwargs):
#         print("Вызов функции:", func.__name__)
#         print("Аргументы:", args, kwargs)
#         result = func(*args, **kwargs)
#         print("Результат:", result)
#         return result
#     return wrapper


# @debug_decorator
# def add_numbers(x, y):
#     print("Inner function")
#     return x + y

# add_numbers(2, 7)



#2
# def uppercase(func):
#     def wrapper():
#         original_result = func()
#         modified_result = original_result.upper()
#         return modified_result
#     return wrapper

# @uppercase
# def greet():
#     return 'Hello!'

# print(greet())

#3
