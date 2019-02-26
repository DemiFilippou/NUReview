class CompaniesController < ApplicationController
  private
  def company_params
    params.require(:company).permit!
  end
end
