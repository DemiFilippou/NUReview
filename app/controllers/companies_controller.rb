class CompaniesController < ApplicationController

  def show
    @company = Company.find(params[:id]) 
    if @company.nil?
      return render json: {
        message: "Can't find company with id #{company_params[:id]}"
      }, status: 404
    end

    render json: @company, except: [:updated_at, :created_at], include: :reviews
  end

  def search
    @companies = Company.search(search_params)
    render json: @companies, only: [:id, :name]
  end

  private
  def company_params
    params.require(:company).permit!
  end

  def search_params
    params.require(:query)
  end
  
  def find_company
    @company = Company.find(company_params[:id]) 
  end
end
