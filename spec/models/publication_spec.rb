require 'spec_helper'

describe Publication do
  let(:user) { FactoryGirl.create(:user) }
  before do
    @publication = user.publications.build(title: "Lorem ipsum",year: 2011,content: "Lorem ipsum")
  end

  subject { @publication }

	it { should respond_to(:title) }
	it { should respond_to(:year) }
  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }

	it { should be_valid }

  describe "when user_id is not present" do
    before { @publication.user_id = nil }
    it { should_not be_valid }
  end
	describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Publication.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end

  describe "with blank content" do
    before { @publication.content = " " }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { @publication.content = "a" * 1001 }
    it { should_not be_valid }
  end
end
