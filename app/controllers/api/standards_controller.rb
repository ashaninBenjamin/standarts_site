class Api::StandardsController < Api::ApplicationController
  def numbers
    @array_of_numbers = Standard.find(params[:id]).node_numbers
    if (params[:native_number].present?)
      @array_of_numbers << params[:native_number].to_i
      @array_of_numbers.sort!
    end
    respond_with @array_of_numbers
  end
end