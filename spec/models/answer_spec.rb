require 'rails_helper'
require_relative 'concerns/attachable'

RSpec.describe Answer, type: :model do

  it { should belong_to(:question) }
  it { should belong_to(:user) }
  it { should validate_presence_of :body }

  it_behaves_like 'attachable'

end
