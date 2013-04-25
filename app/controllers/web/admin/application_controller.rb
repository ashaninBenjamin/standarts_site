class Web::Admin::ApplicationController < Web::ApplicationController
  before_filter :authorized_admin!
end
