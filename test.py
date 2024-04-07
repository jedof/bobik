# import psycopg2

# con=psycopg2.connect(database="bobikdb",
#                      user="bobik",
#                      POSTGRES_PASSWORD="12345",
#                      port=5432,
#                      host="localhost")
# cur = con.cursor()
# cur.execute("sele()
# print(test)

# def is_prime(n):
#     if n <= 1:
#         return False
#     for i in range(2,):
#         if n % i == 0:
#             return False
#     return True

# num = int(input("Введите число: "))

# if is_prime(num):
#     print("yes")
# else:
#     print("no")
# test = cur.fetchall


# def is_palindrome(word):
#     word = word.lower()
#     return word == word[::-1]

# word = input()
# if is_palindrome(word):
#     print(f"Yes")
# else:
#     print(f"No")

def is_prime(num):
    if num <= 1:
        return False
    for i in range(2, num):
        if num % i == 0:
            return False
    return True

number = int(input("Введите число для проверки: "))
if is_prime(number):
    print(f"{number} - простое число")
else:
    print(f"{number} - не простое число")