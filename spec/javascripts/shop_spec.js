describe("Shop SPA", function(){

  it("downloads initial category list", function(){

    waitsFor(function(){
      return useCase.categories.length > 0;},
      'Should download categories', 1500);

    runs(function(){
      console.log(useCase.categories);
      expect(useCase.categories.length).toBeGreaterThan(0);
    });
  });
  
  it("downloads initial products list", function(){

    waitsFor(function(){
      return useCase.products.length > 0;},
      'Should download products', 1500);

    runs(function(){
      console.log(useCase.products);
      expect(useCase.products.length).toBeGreaterThan(0);
    });
  });

  it("updates the cart on product addition", function(){
   
    useCase.cart = [];

    runs(function(){
      useCase.addToCart(1);
    });

    waitsFor(function(){
      return useCase.cart.length == 1;},
      'Should update cart', 1500);

    runs(function(){
      console.log(useCase.cart);
      expect(useCase.cart.length).toEqual(1);
    });
  });

  it("clears the cart when order submitted", function(){
    useCase.cart = [];

    runs(function(){
      useCase.addToCart(1);
    });

    waitsFor(function(){
      return useCase.cart.length == 1;},
      'Should update cart', 1500);

    runs(function(){
      console.log(useCase.cart);
      useCase.confirmCart();
    });

    waitsFor(function(){
      return useCase.cart.length == 0; },
      "Cart should've been emptied", 1500);

    runs(function(){
      expect(useCase.cart.length).toEqual(0);
    });
  });
 
  it("finds products for a category", function(){
    waitsFor(function(){
      return useCase.products.length > 0;},
      'Should download products', 1500);

    runs(function(){
      pr = useCase.findProdsForCat(1);
      console.log(pr);
      expect(pr.length).toBeGreaterThan(0);
      for(var i=0; i<pr.length; i++){
        expect(pr[i].category_id).toEqual(1);
      }
    });
  });

  it("updates cart's sum on product addition", function(){
   
    useCase.cart = [];
    var sum, length;
    runs(function(){
      sum = useCase.cartSum();
      length = useCase.cart.length;
      useCase.addToCart(1);
    });

    waitsFor(function(){
      return useCase.cart.length != length;},
      'Should update cart', 1500);

    runs(function(){
      expect(sum).not.toEqual(useCase.cartSum);
    });
  });

});
