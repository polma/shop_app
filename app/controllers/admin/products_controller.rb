class Admin::ProductsController < Admin::AdminController
  def index
    @categories = Category.all
    @products = Product.all
  end  
  def new
    @product = Product.new
  end
  def create
  @product = Product.new(params[:product])
 
  respond_to do |format|
    if @product.save
      format.html  { redirect_to(admin_products_path,
                    :notice => 'Zapisano nowy produkt.') }
      format.json  { render :json => @product,
                    :status => :created, :location => @product }
    else
      format.html  { render :action => "new" }
      format.json  { render :json => @product.errors,
                    :status => :unprocessable_entity }
    end
  end
end
  def destroy
    Product.delete(params[:id])
    redirect_to admin_products_path
  end
  def edit
    @product = Product.find(params[:id])
  end
  def update
    p = Product.find(params[:id])
    if p.update_attributes(params[:product])
      redirect_to admin_products_path
    else
      render "edit"
    end
  end
end
