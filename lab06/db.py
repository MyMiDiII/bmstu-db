import psycopg2 as psql
from prettytable import from_db_cursor

class BoardGamesDB:
    def __init__(self):
        try:
            self.__con = psql.connect(
                user='mymidi',
                password='asdfjkl;',
                host='localhost',
                database='board_games_db'
            )
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


    def avgPrice(self):
        print("Получение средней цены игр...\n")

        query = """
                SELECT ROUND(avg(price)) as avg_price
                FROM board_games
                """

        self.__cur.execute(query)
        self.__saveRes()


    def getContacts(self):
        print("Получение телефонных контактов игротеки...\n")

        query = """
                SELECT title AS event, 
                       ve.phone AS venue_phone,
                       o.phone AS org_phone
                FROM (venues v
                      JOIN board_game_events bge
                      ON v.venue_id = bge.venue_id) AS ve
                      JOIN organizers o
                      ON ve.org_id = o.org_id;
                """

        self.__cur.execute(query)
        self.__saveRes()


    def venueTypesRating(self):
        print("Получение среднего количества игротек для каждого места"
                + " проведения по типу...\n")

        query = """
                WITH ve AS (
                    SELECT DISTINCT v.venue_id, venue_name, vanue_type,
                    avg(bge.players_num) OVER(PARTITION BY vanue_type)
                    AS avg_num
                    FROM venues v
                         LEFT JOIN
                         board_game_events bge
                         ON v.venue_id = bge.venue_id
                )
                SELECT venue_name, vanue_type, round(avg_num) as avg_num
                FROM ve
                ORDER BY vanue_type;
                """

        self.__cur.execute(query)
        self.__saveRes()


    def getMeta(self):
        print("Получение информации о типе атрибутов")

        query = """
                SELECT table_name, column_name, data_type
                FROM information_schema."columns"
                WHERE table_schema = 'public'
                """

        self.__cur.execute(query)
        self.__saveRes()


    def getAvgDuration(self, uuid):
        print("Получение средней продолжительности игротек в заданном месте"
              + " проведения")

        query = "SELECT * FROM avg_venue_duration(\'{}\')".format(uuid)

        self.__cur.execute(query)
        self.__saveRes()


    def getGameCities(self, game):
        print("Получение мест проведения, в которых играют в данную игру")

        query = "SELECT * FROM game_cities(\'{}\')".format(game)

        self.__cur.execute(query)
        self.__saveRes()


    def giveDiscount(self, game, percent):
        print("Обновление цены по скидке")

        query = """
                SELECT game_id, title, price
                FROM board_games
                WHERE game_id = '{}';
                """.format(game)
        self.__cur.execute(query)
        self.__saveRes()
        self.__res.title = "ДО"
        self.printRes()

        query = "CALL give_discount('{}', {});".format(game, percent)

        self.__cur.execute(query)

        query = """
                SELECT game_id, title, price
                FROM board_games
                WHERE game_id = '{}';
                """.format(game)
        self.__cur.execute(query)
        self.__con.commit()

        self.__saveRes()
        self.__res.title = "ПОСЛЕ"


    def getVersion(self):
        print("Получение информации о версии Postgres")

        query = """
                SELECT version();
                """

        self.__cur.execute(query)
        self.__saveRes()


    def createTable(self):
        print("Создание таблицы")

        query = """
                CREATE TABLE IF NOT EXISTS shops (
                    shop_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
                    shop_name TEXT NOT NULL,
                    sales_point_num INT CHECK (sales_point_num >= 0),
                    rating INT CHECK (rating >= 0)
                )
                """

        self.__cur.execute(query)
        self.__con.commit()

        query = """
                SELECT *
                FROM shops;
                """

        self.__cur.execute(query)
        self.__saveRes()


    def insertShops(self):
        print("Добавление нового магазина")

        try:
            name = input("Введите название: ")
            spn = int(input("Введите количество точек продаж: "))
            rating = int(input("Введите рейтинг: "))
        except:
            print("Неверные данные!")
            return

        query = """
                INSERT INTO shops (shop_name, sales_point_num, rating)
                VALUES
                ('{}', {}, {})
                """.format(name, spn, rating)

        self.__cur.execute(query)
        self.__con.commit()

        query = """
                SELECT *
                FROM shops;
                """

        self.__cur.execute(query)
        self.__saveRes()

