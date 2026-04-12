class TicketStatusesController < ApplicationController
  before_action :set_ticket_status, only: [:edit, :update, :destroy]

  def index
    @ticket_statuses = policy_scope(TicketStatus)
  end

  def new
    @ticket_status = TicketStatus.new
    authorize @ticket_status
  end

  def create
    @ticket_status = TicketStatus.new(ticket_status_params)
    authorize @ticket_status

    if @ticket_status.save
      redirect_to ticket_statuses_path, notice: "Status criado com sucesso!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @ticket_status
  end

  def update
    authorize @ticket_status

    if @ticket_status.update(ticket_status_params)
      redirect_to ticket_statuses_path, notice: "Status atualizado com sucesso!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @ticket_status
    @ticket_status.destroy
    redirect_to ticket_statuses_path, notice: "Status removido com sucesso!"
  end

  private

  def set_ticket_status
    @ticket_status = TicketStatus.find(params[:id])
  end

  def ticket_status_params
    params.require(:ticket_status).permit(:name, :is_default, :is_final)
  end
end