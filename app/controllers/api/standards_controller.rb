class Api::StandardsController < Api::ApplicationController
  def numbers
    #FIXME! Исправить!
    @arr = Standard.find(params[:id]).node_numbers
    @numbers = []
    @arr.each do |one|
      @numbers << {number: one}
    end
    respond_with @numbers
  end
end