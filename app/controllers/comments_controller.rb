class CommentsController < ApplicationController
  before_action :set_ticket

  def create
    @comment = Comment.new(comment_params)
    @comment.ticket = @ticket
    @comment.user = current_user
    authorize @comment

    if @comment.save
      redirect_to ticket_path(@ticket), notice: "Comentário adicionado com sucesso!"
    else
      redirect_to ticket_path(@ticket), alert: "Erro ao adicionar comentário."
    end
  end

  private

  def set_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end