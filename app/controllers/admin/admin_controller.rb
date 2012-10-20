class Admin::AdminController < ApplicationController
  @categories = ::Category.all
end
