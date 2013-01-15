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
  it { should respond_to(:remember_token) }
  it { should respond_to(:admin) }
  it { should respond_to(:authenticate) }
	it { should respond_to(:publications) }

  it { should be_valid }
  it { should_not be_admin }

  describe "with admin attribute set to 'true'" do
    before do
      @user.save!
      @user.toggle!(:admin)
    end

    it { should be_admin }
  end 

	it { should respond_to(:email) }

	it { should be_valid }
	
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

	describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end

	describe "publications associations" do

    before { @user.save }
    let!(:older_publication) do 
      FactoryGirl.create(:publication, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_publication) do
      FactoryGirl.create(:publication, user: @user, created_at: 1.hour.ago)
    end

    it "should have the right publications in the right order" do
      @user.publications.should == [newer_publication, older_publication]
    end

		it "should destroy associated publications" do
      publications = @user.publications.dup
      @user.destroy
      publications.should_not be_empty
      publications.each do |publication|
        Publication.find_by_id(publication.id).should be_nil
      end
    end
  end
end


