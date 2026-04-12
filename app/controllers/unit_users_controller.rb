class UnitUsersController < ApplicationController
  before_action :set_unit

  def create
    @unit_user = UnitUser.new(unit_id: @unit.id, user_id: unit_user_params[:user_id])
    authorize @unit_user

    if @unit_user.save
      redirect_to unit_path(@unit), notice: "Morador vinculado com sucesso!"
    else
      redirect_to unit_path(@unit), alert: "Erro ao vincular morador."
    end
  end

  def destroy
    @unit_user = UnitUser.find(params[:id])
    authorize @unit_user
    @unit_user.destroy
    redirect_to unit_path(@unit), notice: "Vínculo removido com sucesso!"
  end

  private

  def set_unit
    @unit = Unit.find(params[:unit_id])
  end

  def unit_user_params
    params.require(:unit_user).permit(:user_id)
  end
end