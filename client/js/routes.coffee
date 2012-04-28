define ["routes/connect", "routes/home", "routes/collection", "routes/delete"], (connect, home, collection, del) ->
  '/': connect
  '/connect': connect
  '/home': home
  '/new': home
  '/collection/:name': collection
  '/delete/:name/:id': del