require 'test_helper'

describe MerchantsController do

  describe 'Index' do
    it 'should get index' do
      get '/merchants'
      must_respond_with :success
    end
  end

  describe 'Show' do
    let(:merchant){
        Merchant.create!(
          username: 'Aya Lynn',
          email: 'ap@somewhere.com',
          mailing_address: '1111 3rd Ave NE Seattle WA 98000',
          credit_last_four: '1111',
          credit_expire: '12/23'
      )
    }

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
    it 'can create a new merchant' do
      merchant_hash = {
        merchant: {
          username: 'Allen Petter',
          email: 'ap@somewhere.com',
          mailing_address: '1111 3rd Ave NE Seattle WA 98000',
          credit_last_four: '1111',
          credit_expire: '12/23'
        },
      }

      expect{
        post merchants_path, params: merchant_hash
      }.must_change 'Merchant.count', 1

    end

    it 'cannot create a new merchant if the form data violates the validations for merchant' do
      # this can be checked after making the validations
        merchant_hash = {
          merchant: {
            email: 'ap@somewhere.com',
            mailing_address: '1111 3rd Ave NE Seattle WA 98000',
            credit_last_four: '1111',
            credit_expire: '12/23'
          },
        }

        expect{
          post merchants_path, params: merchant_hash
        }.wont_change 'Merchant.count'

      end
  end
  
  describe 'Edit' do
    it 'responds with success when getting the edit page for an existing, valid merchant' do
      merchant = Merchant.create!(
        username: 'Aya Lynn',
        email: 'ap@somewhere.com',
        mailing_address: '1111 3rd Ave NE Seattle WA 98000',
        credit_last_four: '1111',
        credit_expire: '12/23'
      )

      merchant_id = merchant.id
      get edit_merchant_path(merchant_id)
      must_respond_with :success
    end
  end

  describe 'Update' do
    before do
      @merchant = Merchant.create!(
        username: 'Aya Lynn',
        email: 'ap@somewhere.com',
        mailing_address: '1111 3rd Ave NE Seattle WA 98000',
        credit_last_four: '1111',
        credit_expire: '12/23'
      )
      @update_merchant_hash =
        {
          merchant: {
            username: 'Ayaan Loid',
            email: 'ap@somewhere.com',
            mailing_address: '1111 3rd Ave NE Seattle WA 98000',
            credit_last_four: '1111',
            credit_expire: '12/23'
          }
        }
    end


    it 'can updates an existing merchant with valid data accurately and redirect' do
      merchant_id = @merchant.id
      expect {
        patch merchant_path(merchant_id), params: @update_merchant_hash
      }.wont_change 'Merchant.count'

      must_respond_with :redirect
      merchant = Merchant.find_by(id: merchant_id)
      expect(merchant.username).must_equal @update_merchant_hash[:merchant][:username]
      expect(merchant.email).must_equal @update_merchant_hash[:merchant][:email]
      expect(merchant.mailing_address).must_equal @update_merchant_hash[:merchant][:mailing_address]
      expect(merchant.credit_last_four).must_equal @update_merchant_hash[:merchant][:credit_last_four]
      expect(merchant.credit_expire).must_equal @update_merchant_hash[:merchant][:credit_expire]

    end

    it 'does not update any merchant if given an invalid id and redirect to merchants path' do
      expect {
        get edit_merchant_path(-1), params: @update_merchant_hash
      }.wont_change "Merchant.count"
      must_redirect_to merchants_path
    end
  end

  describe 'Destroy' do
    before do
      @merchant = Merchant.create!(
        username: 'Ama Poll',
        email: 'apo@somewhere.com',
        mailing_address: '1111 3rd Ave NE Seattle WA 98000',
        credit_last_four: '1111',
        credit_expire: '12/23'
      )
    end
    
    it 'destroys the merchant instance in database when the merchant exists, then redirect' do
      id = @merchant.id

      expect {
        delete merchant_path(id)
      }.must_change 'Merchant.count', -1
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
