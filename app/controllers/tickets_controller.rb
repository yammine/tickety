class TicketsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_ticket, only: [:show, :edit, :update, :destroy]

  def index
    @tickets = Ticket.all.order("status ASC")
  end

  def show
  end

  def new
    @ticket = Ticket.new
    respond_to do |format|
      format.html { render }
      format.js   { render }
    end
  end

  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.user = current_user
    respond_to do |format|
      if @ticket.save
        format.html { redirect_to @ticket, notice: "Ticket successfully created" }
        format.js   { render }
      else
        format.html { render :new
                      flash.now[:alert] = "Oops something went wrong." }
        format.js   { render }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @ticket.update_attributes(ticket_params)
        format.html { redirect_to @ticket, notice: "Updated ticket." }
        format.js   { render }
      else
        format.html { render :edit
                      flash.now[:alert] = "Problem updating ticket." }
        format.js   { render }
      end
    end
  end

  def destroy
    @ticket.destroy
    redirect_to root_path, notice: "Ticket destroyed."
  end

  private

  def find_ticket
    @ticket = Ticket.find params[:id]
  end

  def ticket_params
    params.require(:ticket).permit(:title, :description, :status)
  end
end
