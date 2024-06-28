from array import *

# Array
# 'b'	signed char	int	1
# 'B'	unsigned char	int	1
# 'u'	wchar_t	Unicode character	2
# 'h'	signed short	int	2
# 'H'	unsigned short	int	2
# 'i'	signed int	int	2
# 'I'	unsigned int	int	2
# 'l'	signed long	int	4
# 'L'	unsigned long	int	4
# 'q'	signed long long	int	8
# 'Q'	unsigned long long	int	8
# 'f'	float	float	4
# 'd'	double	float	8

# 1 ************************* create an array
arr = array('i', [1, 2, 3])
# print(arr)
# print(len(arr))
# print(arr[-1])

# # 2 ************************* search in array - if multiple of same values in array - return first
# print(arr.index(4))

# # 3 ************************* Loop through array
# # 3-1
# for i in arr:
#     print(i)

# # 3-2 
# for i in arr[1:3]:
#     print(i)

# # 3-3
# for i in range(len(arr)):
#     print(arr[i])     

# 4 ************************* slise (СРЕЗЫ) - 
# [1:2:3] - 1 - индекс начала среза (включается в срез, 2 - индекс - конца среза - не включается в срез, м.б. больше чем длинна массива, 4 - шаг)
# print(arr[:])
# print(arr[::])

# #5 ************************* change array item value
# arr[0] = 100
# print(arr)

# # 6 ************************* add new item in array
# arr.append(100)
# print(arr)

# # 7 ************************* add more than one value in array
# arr.extend([40,50,60])
# print(arr)

# # 8 ************************* add item in array by index
# arr.insert(1,300)
# print(arr)

# # 9-1 ************************* remove an item from an array by value - if multiple of same values in array - remove first
# arr.remove(4)
# print(arr)

# # 9-2 ************************* remove an item from an array by index
# arr.pop(1)
# print(arr)


# # 10 ************************* concatenate 2 arrays
# arr2 = array('i', [4, 5, 6])
# arr3 = arr + arr2
# print(arr3)