class Admin::CategoriesController < Admin::AdminController
  def index
    @admin_view = true
    @categories = Category.all
  end
  def new
    @category = Category.new
  end
  def create
    @category = Category.new(params[:category])
   
    respond_to do |format|
      if @category.save
        format.html  { redirect_to(admin_categories_path,
                      :notice => 'Zapisano nowa kategorie.') }
        format.json  { render :json => @category,
                      :status => :created, :location => @category }
      else
        format.html  { render :action => "new" }
        format.json  { render :json => @category.errors,
                      :status => :unprocessable_entity }
      end
    end
  end
  def destroy
    Category.delete(params[:id])
    redirect_to admin_categories_path
  end
  def edit
    @category = Category.find(params[:id])
  end
  def update
    p = Category.find(params[:id])
    if p.update_attributes(params[:category])
      redirect_to admin_categories_path
    else
      render "edit"
    end
  end
end
