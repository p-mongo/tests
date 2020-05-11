ext_json = '''
{
    "IdTitulo": "Jaws",
    "IdDirector": "Steven Spielberg",
    "IdNumber": 8,
    "IdDecimal": {"$numberDecimal":"2.33"}
}
'''

from bson.json_util import loads

doc = loads(ext_json)

print(doc)

# {u'IdTitulo': u'Jaws', u'IdDirector': u'Steven Spielberg', u'IdDecimal': Decimal128('2.33'), u'IdNumber': 8}

print type(doc['IdDecimal'])

# <class 'bson.decimal128.Decimal128'>

from pymongo import MongoClient
client = MongoClient('localhost', 14420)

db = client.test_database

collection = db.test_collection

collection.insert_one(doc)

print(doc)
