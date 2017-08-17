require 'rails_helper'

RSpec.describe Vote do
  it { should belong_to(:votable) }
  it { should belong_to(:user) }
end
