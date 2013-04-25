class Admin::ApplicationController < ApplicationController
  before_filter :authorized_admin!
end
