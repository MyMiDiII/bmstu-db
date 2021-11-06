import csv
import random

from faker import Faker

DATADIR       = 'data/'
EXT           = '.csv'
GAMESFILE     = DATADIR + 'board_games' + EXT
VENUESFILE    = DATADIR + 'venues' + EXT
ORGFILE       = DATADIR + 'organizers' + EXT
EVETNSFILE    = DATADIR + 'boart_game_events' + EXT
GAMEEVENTFILE = DATADIR + 'game_event' + EXT

ROWNUM = 1500
LINKNUM = 4500

def generateGames(faker):
    with open(GAMESFILE, "w", newline='') as file:
        writer = csv.writer(file, delimiter=',')

        for i in range(ROWNUM):
            id = faker.unique.uuid4()
            ages = sorted([random.randint(0, 21), random.randint(0,30)])
            ages[1] = 99 if ages[1] > 21 else ages[1]
            nums = sorted([random.randint(1, 15) for i in range(2)])
            times = sorted(random.sample([x for x in range(5, 240, 5)], 2))
            writer.writerow(
                [
                    id,
                    faker.text(max_nb_chars=30)[:-1],
                    faker.company(),
                    faker.year(),
                    random.randint(0, 15000),
                    ages[0],
                    ages[1],
                    nums[0],
                    nums[1],
                    times[0],
                    times[1],
                ]
            )

if __name__ == '__main__':
    faker = Faker()
    generateGames(faker)
