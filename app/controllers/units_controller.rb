class UnitsController < ApplicationController
  before_action :set_unit, only: [:show]

  def index
    @units = policy_scope(Unit)
  end

  def show
    authorize @unit
  end

  private

  def set_unit
    @unit = Unit.find(params[:id])
  end
end