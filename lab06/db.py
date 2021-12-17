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

    def addEvent(self):
        print("Создание игротеки")

        query = """
                CREATE TEMP TABLE IF NOT EXISTS json_tab(json_t json);
                """

        self.__cur.execute(query)
        self.__con.commit()

        query = """
                COPY json_tab FROM '/var/lib/postgres/data/event.json';
                """

        self.__cur.execute(query)
        self.__con.commit()

        query = """
        CREATE TEMP TABLE IF NOT EXISTS bge_type (
            event_id UUID PRIMARY KEY,
            venue_id UUID,
            org_id UUID,
            title TEXT,
            event_date DATE,
            start_time TIME,
            duration INT,
            players_num INT,
            games_num INT,
            purchase BOOLEAN,
            games json
        );
        """

        self.__cur.execute(query)
        self.__con.commit()

        query = """
                INSERT INTO board_game_events (venue_id, org_id, title,
                        event_date, start_time, duration, players_num,
                        games_num, purchase)
                SELECT j.venue_id, j.org_id, j.title, j.event_date,
                       j.start_time, j.duration, j.players_num, j.games_num,
                       j.purchase
                FROM json_tab CROSS JOIN LATERAL
                     json_populate_record(null::bge_type, json_t) as j
                """

        self.__cur.execute(query)
        self.__con.commit()

        query = """
                INSERT INTO game_event (event_id, game_id)
                SELECT (SELECT event_id
                        FROM board_game_events
                        WHERE title = (SELECT json_t->>'title'
                                       FROM json_tab)
                        LIMIT 1
                        ),
                        (p->>'game_id')::uuid
                FROM json_tab
                CROSS JOIN
                LATERAL
                json_array_elements(json_t->'games') as p
                """

        self.__cur.execute(query)
        self.__con.commit()
