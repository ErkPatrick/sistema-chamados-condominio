class DashboardController < ApplicationController
  def index
    @total_tickets = Ticket.count
    @open_tickets = Ticket.joins(:ticket_status).where(ticket_statuses: { is_final: false }).count
    @closed_tickets = Ticket.joins(:ticket_status).where(ticket_statuses: { is_final: true }).count
    @total_blocks = Block.count
    @total_units = Unit.count
    @recent_tickets = policy_scope(Ticket).order(created_at: :desc).limit(5)
  end
end