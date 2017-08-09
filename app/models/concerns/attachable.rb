module Attachable
  extend ActiveSupport::Concern

  include do
    has_many :attachments, as: :attachable, inverse_of: :attachable, dependent: :destroy

    accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true
  end
end
