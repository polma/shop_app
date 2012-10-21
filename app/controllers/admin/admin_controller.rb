class Admin::AdminController < ApplicationController
  before_filter :authenticate_admin!
  @categories = Category.all
end
