class DonorsController < ApplicationController
  def search_form
    @donor = Donor.new
  end

  def index
    @donor = Donor.where(donor_no: params[:donor][:donor_no]).first
  end
end
