class CompaniesController < ApplicationController

  def show
    @company = Company.find(params[:id]) 
    if @company.nil?
      return render json: {
        message: "Can't find company with id #{company_params[:id]}"
      }, status: 404
    end

    @company_json = @company.as_json(
      include: {:reviews => {include: {:user => {:only => [:name, :email, :id]}}}}
    )

    # I don't like doing this but I am unaware of another way to conditionally render attributes in rails.
    # This is to protect anonymity - we only want to pass user info over the network if the review isn't anonymous
    # It'd be nice to revisit this and look for a better solution
    @company_json['reviews'].each do |review|
      if review['anonymous']
        review.delete("user_id")
        review.delete("user")
      end
    end

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
