# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  nom        :string(255)
#  prenom     :string(255)
#  labo       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#



require 'spec_helper'

describe User do

  before { @user = User.new(nom: "Dupont", prenom: "Michel" , labo: "laboExemple" , password: "coucouhibou", password_confirmation: "coucouhibou" , email: "exemple@email.com") }

  subject { @user }

  it { should respond_to(:nom) }
  it { should respond_to(:prenom) }
	it { should respond_to(:labo) }

	it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

	it { should respond_to(:email) }

	it { should be_valid }

	it { should respond_to(:authenticate) }
	
  describe "when name is not present" do
    before { @user.nom = " " }
    it { should_not be_valid }
  end

	  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = " " }
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "when password confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end
  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }

    describe "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
	end

end


