define ->
  create: (selector, {data, columns, options}) ->
    grid = new Slick.Grid selector, data, columns, options
    return grid