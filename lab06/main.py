from db import BoardGamesDB

MENU = """
\t\tМЕНЮ
1  -- выполнить скалярный запрос;
2  -- выполнить запрос с несколькими соединениями;
3  -- выполнить запрос с ОТВ и оконными функциями;
4  -- выполнить запрос к метаданным;
5  -- вызвать скалярную функцию;
6  -- вызвать табличную функцию;
7  -- вызвать хранимую процедуру;
8  -- вызвать системную функцию;
9  -- создать таблицу;
10 -- выполнить вставку данных;
11 -- добавление игротеки.
0  -- выход.

Выбор: """

def readCMD():
    try:
        cmd = int(input())

        if not 0 <= cmd <= 11:
            raise ValueError
    except:
        print("Нет такого пункта меню!")
        cmd = None

    return cmd

def menu():
    myDB = BoardGamesDB()
    cmd = None
    queries = [myDB.avgPrice,
               myDB.getContacts,
               myDB.venueTypesRating,
               myDB.getMeta,
               myDB.getAvgDuration,
               myDB.getGameCities,
               myDB.giveDiscount,
               myDB.getVersion,
               myDB.createTable,
               myDB.insertShops,
               myDB.addEvent]
    params = [[], [], [], [],
              ['0b693d99-d6ba-45d8-9b6e-5e58b02f1c05'],
              ['Munchkin'],
              ['a5c92b76-8870-46f6-b898-7c54e44a0e23', 5],
              [], [], [], []
             ]

    while cmd != 0:
        print(MENU)
        cmd = readCMD()

        if cmd:
            queries[cmd - 1](*params[cmd - 1])
            myDB.printRes()

if __name__ == '__main__':
    menu()
