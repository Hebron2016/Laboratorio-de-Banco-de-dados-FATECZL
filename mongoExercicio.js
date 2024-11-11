use('exsqlmongo');
db.createCollection('carro')

use('exsqlmongo');
db.exsqlmongo.insertMany([
    {"carro":{"placa":"AFT9087","marca":"VW","modelo":"Gol","cor":"Preto","ano":2007},"nome":"Paula Rocha","logradouro":"R. Anhaia","numero":548,"bairro":"Barra Funda","telefone":"69582548"},
    {"carro":{"placa":"BCD7521","marca":"Ford","modelo":"Fiesta","cor":"Preto","ano":1999},"nome":"José Simões","logradouro":"R. XV de Novembro","numero":36,"bairro":"Água Branca","telefone":"78952459"},
    {"carro":{"placa":"DXO9876","marca":"Ford","modelo":"Ka","cor":"Azul","ano":2000},"nome":"João Alves","logradouro":"R. Pereira Barreto","numero":1258,"bairro":"Jd. Oliveiras","telefone":"21549658"},
    {"carro":{"placa":"EGT4631","marca":"Renault","modelo":"Clio","cor":"Verde","ano":2004},"nome":"Clara Oliveira","logradouro":"Av. Nações Unidas","numero":10254,"bairro":"Pinheiros","telefone":"24589658"},
    {"carro":{"placa":"LKM7380","marca":"Fiat","modelo":"Palio","cor":"Prata","ano":1997},"nome":"Ana Maria","logradouro":"R. 7 de Setembro","numero":259,"bairro":"Centro","telefone":"96588541"}
])

use('exsqlmongo');
db.exsqlmongo.find({})

use('exsqlmongo');
db.exsqlmongo.updateOne({"nome":/Ana/}, {$set:{"telefone" : "54329087"}} )

use('exsqlmongo');
db.exsqlmongo.find({"carro.ano":{$lt:2000}}).count()

use('exsqlmongo');
db.exsqlmongo.find({$and:[{"carro.ano":{$lt:2000}},{"carro.marca":"Fiat"}]})

use('exsqlmongo');
db.exsqlmongo.find({$and:[{"bairro":"Centro"}, {"numero":{$lt:100}}]}).count()

use('exsqlmongo');
db.exsqlmongo.find({"bairro":"Água Branca"})

use('exsqlmongo');
db.exsqlmongo.find({$or:[{"carro.marca":"Renault"},{"carro.marca":"Fiat"}]})

use('exsqlmongo');
db.exsqlmongo.deleteMany({})