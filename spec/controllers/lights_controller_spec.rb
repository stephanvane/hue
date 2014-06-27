require 'rails_helper'

describe LightsController do

  describe 'GET #index' do
    it 'should succeed' do
      get :index
      expect(response.status).to be 200
    end
  end

end
