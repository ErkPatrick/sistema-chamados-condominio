class TicketTypesController < ApplicationController
  before_action :set_ticket_type, only: [:edit, :update, :destroy]

  def index
    @ticket_types = policy_scope(TicketType)
    @ticket_types = @ticket_types.where("title ILIKE ?", "%#{params[:title]}%") if params[:title].present?
  end

  def new
    @ticket_type = TicketType.new
    authorize @ticket_type
  end

  def create
    @ticket_type = TicketType.new(ticket_type_params)
    authorize @ticket_type

    if @ticket_type.save
      redirect_to ticket_types_path, notice: "Tipo de chamado criado com sucesso!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @ticket_type
  end

  def update
    authorize @ticket_type

    if @ticket_type.update(ticket_type_params)
      redirect_to ticket_types_path, notice: "Tipo de chamado atualizado com sucesso!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @ticket_type
    @ticket_type.destroy
    redirect_to ticket_types_path, notice: "Tipo de chamado removido com sucesso!"
  end

  private

  def set_ticket_type
    @ticket_type = TicketType.find(params[:id])
  end

  def ticket_type_params
    params.require(:ticket_type).permit(:title, :sla_hours)
  end
end