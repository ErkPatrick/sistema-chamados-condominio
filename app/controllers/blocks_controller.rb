class BlocksController < ApplicationController
  before_action :set_block, only: [:show, :destroy]

  def index
    @blocks = policy_scope(Block)
    @blocks = @blocks.where("identifier ILIKE ?", "%#{params[:identifier]}%") if params[:identifier].present?
  end

  def show
    authorize @block
    @units = @block.units.order(:floor, :number)
    @units = @units.where("identifier ILIKE ?", "%#{params[:identifier]}%") if params[:identifier].present?
    @units = @units.where(floor: params[:floor]) if params[:floor].present?
  end

  def new
    @block = Block.new
    authorize @block
  end

  def create
    @block = Block.new(block_params)
    authorize @block

    if @block.save
      redirect_to blocks_path, notice: "Bloco criado com sucesso!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @block
    @block.destroy
    redirect_to blocks_path, notice: "Bloco removido com sucesso!"
  end

  private

  def set_block
    @block = Block.find(params[:id])
  end

  def block_params
    params.require(:block).permit(:identifier, :floors, :units_per_floor)
  end
end