require 'rails_helper'

RSpec.describe User, type: :model do
  context 'factory' do
    it 'has a valid factory user model' do
      expect(create(:user)).to be_valid
    end
  end

  describe 'Validations in model' do
    it { is_expected.to validate_presence_of(:email) }

    # Remove the following line as it's not necessary
    # it { is_expected.to validate_presence_of(:encrypted_password) }
  end

  describe 'Validations' do
    context 'when has attributes' do
      it 'is valid with valid attributes' do
        user = create(:user)
        expect(user).to be_valid
      end

      it 'is valid with a unique email' do
        existing_user = create(:user)
        new_user = build(:user, email: existing_user.email)
        expect(new_user).not_to be_valid
        expect(new_user.errors[:email]).to include('has already been taken')
      end
    end

    context 'when missing attributes' do
      it 'is not valid without an email' do
        user = build(:user, email: nil)
        expect(user).not_to be_valid
      end

      it 'is not valid without a password' do
        user = build(:user, password: nil)
        expect(user).not_to be_valid
      end
    end
  end
end
