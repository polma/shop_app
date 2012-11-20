class Memory
  constructor: ->

  save_categories: (json_table) =>
    useCase.categories = json_table.map (e) -> new Category(e.id, e.name)
  
  download_categories: =>
    $.getJSON "/spa/get_categories.json", (d,s) => @save_categories(d)

  save_products: (json_table) =>
    useCase.products = json_table.map (e) -> new Product(e.id, e.name, e.description, e.price, e.category_id)
  
  download_products: =>
    $.getJSON "/spa/get_products.json", (d, s) => @save_products(d)

  get_categories: =>
    alert("mem get c")
    return @categories

class ShopUseCase
  constructor: ->
    @categories = []
    @products = []
    @cart = []
  
  showCats: ->
  showProds: ->
  showCat: ->
  showProd: ->

  clientAddsItem: (id) =>
    alert(id)

class GUI
  constructor: ->
    @fields = []
  
  show_categories: =>
    source = $("#category-list-template").html()
    template = Handlebars.compile(source)
    for c in useCase.categories
      $("#menu").append(template(c))
  show_products: =>
    source = $("#product-list-template").html()
    template = Handlebars.compile(source)
    for c in useCase.products
      $("#products-div").append(template(c))


class WebGlue
  constructor: (@useCase, @gui, @mem) ->
    Before(@useCase, 'showCats', => @mem.download_categories())
    After(@mem, 'save_categories', => @gui.show_categories())
    Before(@useCase, 'showProds', => @mem.download_products())
    After(@mem, 'save_products', => @gui.show_products())

class Main
  constructor: ->
    useCase = new ShopUseCase()
    window.useCase = useCase
    mem = new Memory()
    window.mem = mem
    gui = new GUI()
    window.gui = gui
    glue = new WebGlue(useCase, gui, mem)
    useCase.showCats()
    useCase.showProds()

class Category
  constructor: (@id, @name) ->

class Product
  constructor: (@id, @name, @description, @price, @category_id) ->

$(-> new Main())
