class Web::Admin::ApplicationController < Web::ApplicationController
  before_filter :authorize_admin!
end
