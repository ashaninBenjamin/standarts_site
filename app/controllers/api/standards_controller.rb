class Api::StandardsController < Api::ApplicationController
  def numbers
    @array_of_numbers = Standard.find(params[:id]).node_numbers
    if (params[:native_number].present?)
      @array_of_numbers << params[:native_number].to_i
      @array_of_numbers.sort!
    end
    @hash_of_numbers = []
    @array_of_numbers.each do |one|
      @hash_of_numbers << {number: one}
    end
    respond_with @hash_of_numbers
  end
end