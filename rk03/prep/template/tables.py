from peewee import *

from connection import CON


class BaseModel(Model):
    class Meta:
        database = CON


class Emps(BaseModel):
    id = IntegerField(column_name='id')
    fio = CharField(column_name='fio')
    birthday = DateField(column_name='birthday')
    dep= TextField(column_name='dep')

    class Meta:
        table_name = 'emps'


class InOut(BaseModel):
    io_id = IntegerField(column_name='id')
    emp_id = ForeignKeyField(Emps, backref='emp_id')
    dt = DateField(column_name='dt')
    wday = TextField(column_name='wday')
    tm = TimeField(column_name='tm')
    type12 = IntegerField(column_name='type12')

    class Meta:
        table_name = 'in_out'
