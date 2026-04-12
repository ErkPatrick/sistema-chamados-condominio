class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = policy_scope(User)  # equivalente => UserPolicy::Scope.new(current_user, User.all).resolve
  end

  def show
    authorize @user  # Já temos o usuário pelo set_user, então só precisamos autorizar o acesso a ele usando o Pundit
  end

  def new
    @user = User.new  # Objeto user vazio necessário para a view criar um formulário de criação de usuário
    authorize @user  # Verifica se o usuário atual tem permissão para criar um novo usuário, usando o pundit.
  end

  def create
    @user = User.new(user_params)
    authorize @user

    if @user.save
      redirect_to users_path, notice: "Usuário criado com sucesso!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @user
  end

  def update
    authorize @user

    if @user.update(user_params)
      redirect_to users_path, notice: "Usuário atualizado com sucesso!"
    else
      render :edit, status: :unprocessable_entity  # Se falhar reexibe o formulário com os erros
    end
  end

  def destroy
    authorize @user
    @user.destroy
    redirect_to users_path, notice: "Usuário removido com sucesso!"
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
  end
end