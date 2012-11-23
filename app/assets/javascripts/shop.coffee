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
    
  add_to_cart: (id) ->
    $.ajax({
      url: "/cart/add/"+id,
      data: {id: id},
      type: 'POST',
      async: false,
      success: (d,s,x)=>
        console.log(s);
    })

  download_cart: =>
    $.getJSON '/cart/get', (d, s) => @save_cart(d)
  save_cart: (json_table) =>
    if json_table
      useCase.cart = json_table.map (e) -> new Product(e.id, e.name, e.description, e.price, e.category_id)
    else
      useCase.cart = []

  confirm_cart: =>
    if useCase.cart.length > 0
      console.log("confirming cart")
      $.ajax({
        url: "/order/confirm_json",
        type: 'POST',
        async: false,
        success: (d,s,x) =>
          console.log(d)
          console.log(s)
      })
      useCase.cart_was_empty = false
    else
      useCase.cart_was_empty = true

class ShopUseCase
  constructor: ->
    @categories = []
    @products = []
    @search_results = []
    @cart = []
    @show_cart = false
    @cart_was_empty = false
  
  showCats: ->
  showProds: ->
  showCartMin: ->
  showCart: ->
    @show_cart = true
  confirmCart: ->
  showCat: (id) ->
  showProd: (id) ->

  findProd: (id) ->
    for p in @products
      if p.id == id
        return p
  findCat: (id) ->
    for c in @categories
      if c.id == id
        return c
  findProdsForCat: (id) ->
    return @products.filter (p) -> p.category_id == id

  search: () =>
    $("#product_search").submit( (e) -> return false )
    name = $("#q_name_cont").val()
    desc = $("#q_description_cont").val()
    price_lteq = $("#q_price_lteq").val() * 100.0
    price_gteq = $("#q_price_gteq").val() * 100.0

    @search_results = @products
    if name
      @search_results = @products.filter (p) -> p.name.has(name)
    if desc
      @search_results = @search_results.filter (p) -> p.description.has(desc)
    if price_lteq
      @search_results = @search_results.filter (p) -> p.price <= price_lteq
    if price_gteq
      @search_results = @search_results.filter (p) -> p.price >= price_gteq
    console.log(@search_results)

  cartSum: =>
    # sum = (@cart.reduce (x, y) -> x.price + y.price) / 100.0 #this doesnt work
    sum = 0.0
    for p in @cart
      sum += p.price
    sum /= 100.0
    console.log(sum)
    return sum
  addToCart: (id) =>

class GUI
  constructor: ->
    @fields = []
  
  show_categories: =>
    source = $("#category-list-template").html()
    template = Handlebars.compile(source)
    for c in useCase.categories
      $("#menu").append(template(c))
  
  show_products: =>
    $("#prod-header").html("Wszystkie produkty")
    $("#products-div").html("")
    source = $("#product-list-template").html()
    template = Handlebars.compile(source)
    for c in useCase.products
      $("#products-div").append(template(c))
  
  show_product: (p) =>
    $("#prod-header").html("Strona produktu")
    pcat = useCase.findCat(p.category_id)
    p.catname = pcat.name
    p.price = p.price / 100
    source = $("#product-template").html()
    template = Handlebars.compile(source)
    $("#products-div").html(template(p))
    p.price = p.price * 100
  
  show_category: (id)=>
    $("#prod-header").html("Strona kategori")
    pcs = useCase.findProdsForCat(id)
    source = $("#product-list-template").html()
    $("#products-div").html("")
    template = Handlebars.compile(source)
    for p in pcs
      $("#products-div").append(template(p))
  
  show_cart_min: () =>
    source = $("#cart-min-template").html()
    $("#cart-min").html("")
    $("#cart-sum").html(useCase.cartSum())
    template = Handlebars.compile(source)
    for e in useCase.cart
      e.price = e.price / 100.0
      $("#cart-min").append(template(e))
      e.price = e.price * 100.0
  
  show_cart: () =>
    if useCase.show_cart is false then return
    $("#prod-header").html("Twój koszyk")
    $("#products-div").html("")
    source = $("#product-list-template").html()
    template = Handlebars.compile(source)
    for c in useCase.cart
      $("#products-div").append(template(c))
    $("#products-div").append('<a href="#" onclick="useCase.confirmCart()">Potwierdź zamówienie</a>')
    useCase.show_cart = false
  
  show_search_results: () =>
    $("#prod-header").html("Wyniki wyszukiwania")
    $("#products-div").html("")
    source = $("#product-list-template").html()
    template = Handlebars.compile(source)
    for c in useCase.search_results
      $("#products-div").append(template(c))

  notice: (notice_text) =>
    if notice_text == "Potwierdzono koszyk." and useCase.cart_was_empty
      alert("Nie potwierdzam pustego koszyka.")
      return

    $("p.notice").html(notice_text)
    $("p.notice").show()
    $("p.notice").hide(4000)
    if notice_text == "Potwierdzono koszyk."
      useCase.showProds()
      useCase.showCartMin()


class WebGlue
  constructor: (@useCase, @gui, @mem) ->
    Before(@useCase, 'showCats', => @mem.download_categories())
    After(@mem, 'save_categories', => @gui.show_categories())
    
    Before(@useCase, 'showProds', => @mem.download_products())
    After(@mem, 'save_products', => @gui.show_products())
    
    Before(@useCase, 'showCartMin', => @mem.download_cart())
    After(@mem, 'save_cart', => @gui.show_cart_min())

    Before(@useCase, 'showCart', => @mem.download_cart())
    After(@mem, 'save_cart', => @gui.show_cart())
    
    After(@useCase, 'showProd', (id) => @gui.show_product(useCase.findProd(id)))
    After(@useCase, 'showCat', (id) => @gui.show_category(id))
    
    Before(@useCase, 'addToCart', (id) => @mem.add_to_cart(id))
    After(@mem, 'add_to_cart', (id) => @mem.download_cart())
    After(@mem, 'add_to_cart', => @gui.notice("Dodano produkt do koszyka."))

    Before(@useCase, 'confirmCart', => @mem.download_cart())
    Before(@useCase, 'confirmCart', => @mem.confirm_cart())
    After(@mem, 'confirm_cart', => @gui.notice("Potwierdzono koszyk."))

    After(@useCase, 'search', => @gui.show_search_results())
    

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
    useCase.showCartMin()

class Category
  constructor: (@id, @name) ->

class Product
  constructor: (@id, @name, @description, @price, @category_id, @catname = "") ->
  
$(-> new Main())
