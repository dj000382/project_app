require 'spec_helper'

describe "Publication pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "publication creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a publication" do
        expect { click_button "Post" }.not_to change(Publication, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') } 
      end
    end

    describe "with valid information" do

      before { fill_in 'publication_content', with: "Lorem ipsum"
							 fill_in 'publication_year', with: "2011" 
							 fill_in 'publication_title', with: "Fake title"  }
      it "should create a publication" do
        expect { click_button "Post" }.to change(Publication, :count).by(1)
      end
    end
  end
end
