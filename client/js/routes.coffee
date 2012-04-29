define ["routes/connect",
 "routes/disconnect",
 "routes/home",
 "routes/collection",
 "routes/copy"
 "routes/delete"], 
 (connect, disconnect, home, collection, copy, del) ->
  '/': connect
  '/connect': connect
  '/disconnect': disconnect
  '/home': home
  '/new': home
  '/collection/:name': collection
  '/copy/:name/:id': copy
  '/delete/:name/:id': del