require 'test_helper'

describe MerchantsController do

  let(:merchant){
    Merchant.create!(
        username: 'Aya Lynn',
        email: 'ap@somewhere.com'
    )
  }

  let (:merchant_hash) {
    {
      merchant: {
          username: 'Allen Petter',
          email: 'ap@somewhere.com'
      }
    }
  }

  describe 'Index' do
    it 'should get index' do
      get '/merchants'
      must_respond_with :success
    end
  end

  describe 'Show' do

    it 'can get a valid merchant' do
      get merchant_path(merchant.id)
      must_respond_with :success
    end

    it 'will redirect for an invalid merchant' do
      get merchant_path(-1)
      must_respond_with :redirect
    end
  end

  describe 'Create' do
    it 'cannot create a new merchant if the form data violates the validations for merchant' do
      # this can be checked after making the validations
      new_merchant = Merchant.new(username: nil)
      expect{
        perform_login(new_merchant)
      }.wont_change 'Merchant.count'

      must_redirect_to root_path
    end
  end

  describe 'Edit' do
    before do
      perform_login
    end

    it 'responds with success when getting the edit page for an existing, valid merchant' do

      merchant_id = merchant.id
      get edit_merchant_path(merchant_id)
      must_respond_with :success
    end
  end

  describe 'Update' do

    before do
      perform_login
    end

    it 'can updates an existing merchant with valid data accurately and redirect' do
      new_merchant = merchant

      expect {
        patch merchant_path(new_merchant.id), params: merchant_hash
      }.wont_change 'Merchant.count'

      new_merchant.reload

      expect(new_merchant.username).must_equal merchant_hash[:merchant][:username]
      expect(new_merchant.email).must_equal merchant_hash[:merchant][:email]

      must_respond_with :redirect
      must_redirect_to merchants_path
    end

    it 'does not update any merchant if given an invalid id and redirect to merchants path' do
      expect {
        get edit_merchant_path(-1), params: merchant_hash
      }.wont_change "Merchant.count"
      must_respond_with :redirect
    end
  end

  describe "auth_callback" do
    it "logs in an existing merchant and redirects to the root route" do
      # Count the users, to make sure we're not (for example) creating
      # a new user every time we get a login request
      start_count = Merchant.count
      merchant = Merchant.find_by(username: 'Jello Porcini')

      perform_login(merchant)

      must_redirect_to root_path
      expect(session[:merchant_id]).must_equal  merchant.id

      # Should *not* have created a new user
      expect(Merchant.count).must_equal start_count
    end

    it "creates an account for a new merchant and redirects to the root route" do
      start_count = Merchant.count
      merchant = Merchant.new(provider: "github", uid: 99999, name: "test_user", email: "test@user.com")

      perform_login(merchant)

      must_redirect_to root_path

      # Should have created a new user
      expect(Merchant.count).must_equal start_count + 1

      # The new user's ID should be set in the session
      expect(session[:merchant_id]).must_equal Merchant.last.id
    end

    it "redirects to the login route if given invalid merchant data" do
      merchant = Merchant.find_by(username: 'Dexter Excaliber')
      merchant.username = nil

      perform_login(merchant)

      must_respond_with :redirect
      must_redirect_to root_path

    end
  end
end
