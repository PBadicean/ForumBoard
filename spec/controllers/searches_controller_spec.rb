require 'rails_helper'

RSpec.describe SearchesController, type: :controller do
  describe 'GET #index' do
    let(:query)    { 'Запрос'  }
    let(:division) { 'Question' }

    it 'Assign search attributes to model' do
      expect(Search).to receive(:find).with(query, division)
      get :index, params: { query: query, division: division }
    end

    it 'renders show template' do
      get :index
      expect(response).to render_template :index
    end
  end
end
