module Authorizations::MedicationAuthorization
  extend ActiveSupport::Concern

  included do
    before_action :authorize_medication_resource, if: :medications_controller?
  end

  def authorize_medication_resource
    authorize :medication
  end

  def medications_controller?
    params[:controller].include? "medications"
  end
end