class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :update_status]

  def index
    @ticket_types = TicketType.all
    @ticket_statuses = TicketStatus.all
    @tickets = policy_scope(Ticket)
    @tickets = @tickets.where(ticket_type_id: params[:ticket_type_id]) if params[:ticket_type_id].present?
    @tickets = @tickets.where(ticket_status_id: params[:ticket_status_id]) if params[:ticket_status_id].present?
    @tickets = @tickets.where("opened_at >= ?", params[:date_from].to_date.beginning_of_day) if params[:date_from].present?
    @tickets = @tickets.where("opened_at <= ?", params[:date_to].to_date.end_of_day) if params[:date_to].present?
    @tickets = @tickets.order(opened_at: :desc)
  end

  def show
    authorize @ticket
    @comments = @ticket.comments.order(created_at: :asc)  # além de autorizar e exibir o chamado, também exibe os comentários em ordem cronológica e os anexos
    @attachments = @ticket.attachments
    @comment = Comment.new  # Cria um objeto vazio para o formulário de novos comentários na página de detalhes do chamado
  end

  def new
    @ticket = Ticket.new
    authorize @ticket
    # Carrega as unidades e os tipos de chamados para popular os selects do formulário
    @units = current_user.resident? ? current_user.units : Unit.all  # Se for um morador, ver apenas as suas unidades
    @ticket_types = TicketType.all
  end

  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.user = current_user
    authorize @ticket

    if @ticket.save
      if params[:attachments].present?
        params[:attachments].each do |file|
          next unless file.is_a?(ActionDispatch::Http::UploadedFile)

          attachment = Attachment.new(ticket: @ticket)
          attachment.file.attach(file)

          unless attachment.save
            flash[:alert] = "Erro ao salvar anexo"
          end
        end
      end
      redirect_to ticket_path(@ticket), notice: "Chamado aberto com sucesso!"
    else
      # Recarregar units e ticket_types antes de renderizar o formulário novamente
      @units = current_user.resident? ? current_user.units : Unit.all
      @ticket_types = TicketType.all
      render :new, status: :unprocessable_entity
    end
  end

  #restante da lógica está no model
  def update_status
    authorize @ticket

    if @ticket.update(ticket_status_id: params[:ticket_status_id])
      redirect_to ticket_path(@ticket), notice: "Status atualizado com sucesso!"
    else
      redirect_to ticket_path(@ticket), alert: "Erro ao atualizar status."
    end
  end

  private

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(:unit_id, :ticket_type_id, :description)
  end
end