import peewee as pw
from prettytable import from_db_cursor
from prettytable import PrettyTable

from connection import CON
import queries as q
from tables import *

class RK03:
    def __init__(self):
        try:
            self.__con = CON
            self.__cur = self.__con.cursor()
            self.__res = None
            print('Подключено!')
        except:
            print("Ошибка подключения!")


    def __del__(self):
        if self.__con:
            self.__cur.close()
            self.__con.close()
            print('Отключено!')


    def __saveRes(self):
        self.__res = from_db_cursor(self.__cur)


    def printRes(self):
        print("Не было запросов!" if self.__res == None else self.__res)

    def printPW(self, query):
        t = PrettyTable()

        t.field_names = query.dicts()[0].keys()

        for elem in query.tuples():
            t.add_row(elem)

        print(t)

    def q1(self):
        query = q.Q1

        self.__cur.execute(query)
        self.__saveRes()
        self.printRes()

    def q2(self):
        query = q.Q2

        self.__cur.execute(query)
        self.__saveRes()
        self.printRes()

    def q3(self):
        query = q.Q3

        self.__cur.execute(query)
        self.__saveRes()
        self.printRes()

    def ql1(self):
        query1 = None

        predicate = None # для вложенных select

        query = None # для вложенных select

        self.printPW(query)

    def ql2(self):
        query1 = None

        predicate = None # для вложенных select

        query = None # для вложенных select

        self.printPW(query)

    def ql3(self):
        query1 = None

        predicate = None # для вложенных select

        query = None

        self.printPW(query)

# !!! Отправка в таблицу
#     def createTable(self):
#         print("Создание таблицы")
# 
#         query = """
#                 """
# 
#         self.__cur.execute(query)
#         self.__con.commit()

