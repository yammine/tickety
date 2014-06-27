require 'rails_helper'

feature "Campaigns", :type => :feature do

  let(:user) { create(:user) }

  describe "Listing Tickets" do 

    it "displays a tickety h1 title" do 
      visit tickets_path
      expect(page).to have_text "Tickety"
    end

    it "displays page title" do 
      visit root_path
      expect(page).to have_title "Tickety"
    end

    context "with tickets" do 
      let!(:ticket) { create(:ticket) }
      let!(:ticket1) { create(:ticket) }

      it "displays tickets titles" do 
        visit tickets_path
        expect(page).to have_text /#{ticket.title}/i
      end

      it "puts page titles in h2" do 
        visit tickets_path
        expect(page).to have_selector("h2")
      end
    end

  end

end