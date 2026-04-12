class AttachmentsController < ApplicationController
  before_action :set_ticket

  def create
    @attachment = Attachment.new
    @attachment.ticket = @ticket
    @attachment.file = params[:attachment][:file]
    authorize @attachment

    if @attachment.save
      redirect_to ticket_path(@ticket), notice: "Anexo adicionado com sucesso!"
    else
      redirect_to ticket_path(@ticket), alert: "Erro ao adicionar anexo."
    end
  end

  def destroy
    @attachment = Attachment.find(params[:id])
    authorize @attachment
    @attachment.delete
    redirect_to ticket_path(@ticket), notice: "Anexo removido com sucesso!"
  end

  private

  def set_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end
end