import csv
import random

from faker import Faker
from faker_e164.providers import E164Provider

DATADIR       = 'data/'
EXT           = '.csv'
GAMESFILE     = DATADIR + 'board_games' + EXT
VENUESFILE    = DATADIR + 'venues' + EXT
ORGFILE       = DATADIR + 'organizers' + EXT
EVETNSFILE    = DATADIR + 'board_game_events' + EXT
GAMEEVENTFILE = DATADIR + 'game_event' + EXT

ROWNUM1 = 1000
ROWNUM2 = 2000
ROWNUM3 = 3000
LINKNUM = 6000
PRODUCERSNUM = 500

gamesIDs = []
venuesIDs = []
organizersIDs = []
eventsIDs = []


def generateGames(faker):
    with open(GAMESFILE, "w", newline='') as file:
        writer = csv.writer(file, delimiter=',')
        producers = [faker.company() for i in range(PRODUCERSNUM)]
        timesVals = [x for x in range(5, 240, 5)]

        for i in range(ROWNUM3):
            id = faker.unique.uuid4()
            ages = sorted([random.randint(0, 21), random.randint(0,30)])
            ages[1] = 99 if ages[1] > 21 else ages[1]
            nums = sorted([random.randint(1, 15) for i in range(2)])
            times = sorted(random.sample(timesVals, 2))

            writer.writerow(
                [
                    id,
                    faker.text(max_nb_chars=30)[:-1],
                    random.choice(producers),
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

            gamesIDs.append(id)


def generateVenues(faker):
    types = [
                'anti-cafe',
                'apartment',
                'studio',
                'fast food restaurant',
                'hall',
                'rent',
                'other'
            ]

    with open(VENUESFILE, "w", newline='') as file:
        writer = csv.writer(file, delimiter=',')

        for i in range(ROWNUM1):
            id = faker.unique.uuid4()

            writer.writerow(
                [
                    id,
                    faker.company(),
                    random.choice(types),
                    faker.city(),
                    faker.e164(),
                    faker.url(),
                    faker.company_email()
                ]
            )

            venuesIDs.append(id)


def generateOrganizers(faker):
    with open(ORGFILE, "w", newline='') as file:
        writer = csv.writer(file, delimiter=',')

        for i in range(ROWNUM1):
            id = faker.unique.uuid4()

            writer.writerow(
                [
                    id,
                    faker.company(),
                    faker.city(),
                    faker.year(),
                    faker.e164(),
                    faker.url(),
                    faker.company_email()
                ]
            )

            organizersIDs.append(id)


def generateEvents(faker):
    with open(EVETNSFILE, "w", newline='') as file:
        writer = csv.writer(file, delimiter=',')

        for i in range(ROWNUM2):
            id = faker.unique.uuid4()

            writer.writerow(
                [
                    id,
                    random.choice(venuesIDs),
                    random.choice(organizersIDs),
                    faker.text(max_nb_chars=30)[:-1],
                    faker.date(),
                    faker.time()[:-4] + '0:00',
                    random.randint(1, 24),
                    random.randint(0, 500),
                    bool(random.randint(0, 1))
                ]
            )

            eventsIDs.append(id)


def generateGamesEvents(faker):
    with open(GAMEEVENTFILE, "w", newline='') as file:
        writer = csv.writer(file, delimiter=',')

        for i in range(LINKNUM):
            id = faker.unique.uuid4()

            writer.writerow(
                [
                    id,
                    random.choice(eventsIDs),
                    random.choice(gamesIDs)
                ]
            )


if __name__ == '__main__':
    faker = Faker()
    generateGames(faker)
    faker.add_provider(E164Provider)
    generateVenues(faker)
    generateOrganizers(faker)
    generateEvents(faker)
    generateGamesEvents(faker)
