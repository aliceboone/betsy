require 'test_helper'

describe MerchantsController do

  let(:merchant){
    Merchant.create!(
      username: 'Jane Do',
      email: 'jdo@somewhere.com',
      mailing_address: '1111 3rd Ave NE Seattle WA 98000',
      credit_last_four: 1111,
      credit_expire: '12/23' )
  }

  describe 'Index' do
    
    it 'should get index' do
      get '/merchants'
      must_respond_with :success
    end
  end

  describe 'Show' do
    it 'can get a valid trip' do
      get merchant_path trip_path(trip.id)

      must_respond_with :success
    end

    it 'will redirect for an invalid trip' do

      # Act
      get trip_path(-1)

      # Assert
      must_respond_with :redirect
    end
  end

end
