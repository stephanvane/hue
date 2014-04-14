require 'spec_helper'

describe LightsController do

  describe 'GET #index' do
    it 'should succeed' do
      get :index
      should respond_with 200
    end
  end

end
