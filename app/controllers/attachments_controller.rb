class AttachmentsController < ApplicationController
  before_action :set_ticket

  def create
    @attachment = Attachment.new
    @attachment.ticket = @ticket
    if params[:attachment] && params[:attachment][:file].present?
      @attachment.file.attach(params[:attachment][:file])
    end
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
    @attachment.file.purge  # Remove o arquivo do Active Storage
    @attachment.destroy
    redirect_to ticket_path(@ticket), notice: "Anexo removido com sucesso!"
  end

  private

  def set_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end
end