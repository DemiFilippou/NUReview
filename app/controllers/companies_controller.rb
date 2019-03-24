class CompaniesController < ApplicationController

  def show
    @company = Company.find(params[:id]) 
    if @company.nil?
      return render json: {
        message: "Can't find company with id #{company_params[:id]}"
      }, status: 404
    end

    @company_json = @company.as_json(:current_user => current_user,
      include: {:reviews => {include: {:user => {:only => [:name, :email, :id, :total_upvotes]}, :tags => {:only => [:tag, :id]}, :position => {:only => [:title, :id]}}}}, except: [:created_at, :updated_at]
    )

    render json: @company_json
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
