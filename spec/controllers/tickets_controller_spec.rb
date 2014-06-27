require 'rails_helper'

RSpec.describe TicketsController, :type => :controller do

  let!(:ticket) { create(:ticket) }
  let(:user)   { create(:user) }

  describe "#index" do 
    it "includes all of the tickets created" do
      ticket
      ticket1 = create(:ticket)
      get :index
      expect(assigns(:tickets)).to include(ticket1)
    end

    it "renders the index template" do 
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "#new" do 
    before { sign_in user }
    it "assigns a new ticket variable" do 
      get :new
      expect(assigns(:ticket)).to be_a_new(Ticket)
    end

    it "renders a new template" do 
      get :new
      expect(response).to render_template(:new)
    end

  end

  describe "#create" do
    before { sign_in user }
    context "with a valid request" do 
      def valid_request
        post :create, ticket: { title: "A ticket title",
                                description: "A Ticket description",
                              }
      end

      it "creates a new record in the database" do 
        expect{valid_request}.to change{Ticket.count}.by(1)
      end

      it "redirects to the show page" do 
        valid_request
        expect(response).to redirect_to ticket_path(Ticket.last)
      end

      it "sets a flash message" do 
        valid_request
        expect(flash[:notice]).to be
      end

    end

    context "with invalid request" do 
      def invalid_request
        post :create, ticket: { title: "",
                                description: "A Ticket description",
                              }
      end

      it "doesn't create a new record in the database" do 
        expect{invalid_request}.to_not change{Ticket.count}
      end
      
      it "renders the new page" do 
        invalid_request
        expect(response).to render_template(:new)
      end

      it "sets a flash message" do 
        invalid_request
        expect(flash[:alert]).to be
      end

    end
  end

  describe "#show" do 

    it "assigns a ticket instance variable with a passed id" do 
      get :show, id: ticket.id
      expect(assigns(:ticket)).to eq(ticket)
    end

    it "renders a show template" do 
      get :show, id: ticket.id
      expect(response).to render_template(:show)
    end

    it "raises an error if trying to access a non-existing campaign" do 
      expect{get :show, id: (ticket.id+1)}.to raise_error
    end
  end

  describe "#edit" do 
    before { sign_in user }
    it "sets a ticket instance variable with id" do 
      get :edit, id: ticket.id
      expect(assigns(:ticket)).to eq(ticket)
    end

    it "renders the edit template" do 
      get :edit, id: ticket.id
      expect(response).to render_template(:edit)
    end
  end

  describe "#update" do 

    before { sign_in user }

    context "valid request" do 
      def valid_request
        patch :update, id: ticket.id, ticket: { title: "An updated title" }
      end

      it "updates the campaign record with a new title" do 
        valid_request
        ticket.reload
        expect(ticket.title).to match /An updated title/i
      end

      it "redirects to the index page" do 
        valid_request
        expect(response).to redirect_to ticket_path(Ticket.last)
      end

      it "sets flash message" do 
        valid_request
        expect(flash[:notice]).to be
      end

    end

    context "invalid request" do 
      def invalid_request
        patch :update, id: ticket.id, ticket: { title: "" }
      end

      it "doesn't update to the empty title" do 
        invalid_request
        ticket.reload
        expect(ticket.title).to_not eq("")
      end

      it "renders the edit template" do 
        invalid_request
        expect(response).to render_template(:edit)
      end

      it "sets a flash message" do 
        invalid_request
        expect(flash[:alert]).to be
      end

    end
  end

  describe "#destroy" do 

    before { sign_in user }

    def destroyer
      delete :destroy, id: ticket.id
    end

    it "removes the ticket record from the database" do 
      ticket
      expect{destroyer}.to change {Ticket.count}.by(-1)
    end

    it "redirects to the ticket index" do 
      destroyer
      expect(response).to redirect_to root_path
    end

    it "sets a flash message" do 
      destroyer
      expect(flash[:notice]).to be
    end
  end







end
