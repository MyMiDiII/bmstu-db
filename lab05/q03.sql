-- 3
-- таблица с атрибутом типа json
-- заполнить атрибут правдоподобными данными

CREATE TABLE IF NOT EXISTS players
(
    info jsonb
);

INSERT INTO players
VALUES
('{ "nickname" : "MyMiDi",
    "league" : "begginers",
    "fio"    : "Маслова Марина",
    "activity" :
    [
     {
        "game"   : "Bang!",
        "num"    :  10,
        "rating" :  3
     },
     {
         "game"   : "Red 7",
         "num"    :  3,
         "rating" :  3
     }
    ]
 }'
),
('{ "nickname" : "amunra2",
    "league" : "top",
    "activity" :
    [
     {
        "game"   : "Bang!",
        "num"    :  100,
        "rating" :  76
     },
     {
         "game"   : "Red 7",
         "num"    :  40,
         "rating" :  23
     }
    ]
 }'
),
('{ "nickname" : "hamzreg",
    "league" : "top",
    "activity" :
    [
     {
        "game"   : "Manchkin",
        "num"    :  154,
        "rating" :  100
     },
     {
         "game"   : "What?",
         "num"    :  4,
         "rating" :  2
     }
    ]
 }'
)

SELECT *
FROM players;

DROP TABLE players;
