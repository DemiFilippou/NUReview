class CompaniesController < ApplicationController
  def search
    @companies = Company.search(params.require(:query))
    render json: @companies, only: [:id, :name]
  end

  private
  def company_params
    params.require(:company).permit!
  end
end
