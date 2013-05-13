class Api::StandardsController < Api::ApplicationController
  def numbers
    #FIXME! Исправить!
    @arr = Standard.find(params[:id]).node_numbers
    if (params[:native_number].present?)
      @arr << params[:native_number].to_i
    end
    @arr.sort!
    @numbers = []
    @arr.each do |one|
      @numbers << {number: one}
    end
    respond_with @numbers
  end
end