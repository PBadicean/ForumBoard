module PublicShowAndIndex
  extend ActiveSupport::Concern

  included do
    skip_before_action :authenticate_user!, only: [:index, :show]
    skip_before_action :ensure_signup_complete, only: [:index, :show]

  end
end
