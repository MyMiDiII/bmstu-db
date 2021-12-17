from db import RK03

MENU = """
\t\tМЕНЮ
1  -- ;
2  -- ;
3  -- ;
4  -- 1 (лямбда);
5  -- 2 (лямбда);
6  -- 3 (лямбда);
0  -- выход.

Выбор: """

def readCMD():
    try:
        cmd = int(input())

        if not 0 <= cmd <= 6:
            raise ValueError
    except:
        print("Нет такого пункта меню!")
        cmd = None

    return cmd

def menu():
    myDB = RK03()
    cmd = None
    queries = [myDB.q1, myDB.q2, myDB.q3,
               myDB.ql1, myDB.ql2, myDB.ql3]
    params = [[], [], [], [], [], []]

    while cmd != 0:
        print(MENU)
        cmd = readCMD()

        if cmd:
            queries[cmd - 1](*params[cmd - 1])

if __name__ == '__main__':
    menu()
