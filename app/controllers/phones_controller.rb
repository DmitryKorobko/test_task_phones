class PhonesController < ApplicationController
  respond_to :json

  def new
    @phone_number = GeneratePhoneService.call(phone_params)

    respond_to do |format|
      format.json do
        render json: { user_name: phone_number.user_name, phone: Phone.stringified(phone_number.phone) }
      end
    end
  end

  private

  attr_reader :phone_number

  def phone_params
    params.permit(:phone, :user_name)
  end
end
