class Api::UsersController < ApplicationController
  before_action :set_user, only: %I[show update destroy]

  def index
    @users = User.all
                 .map { |user| to_json(user) }
    if @users.empty?
      render_error(RecordsNotFoundError.new)
    else
      render json: @users,
             status: 200,
             root: 'data'
    end
  end

  def show
    render json: to_json(@user),
           status: 200,
           root: 'data'
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: { message: 'User created', user: to_json(@user) },
             status: 200,
             root: 'data'
    else
      render_error(InsufficientParamsError.new)
    end
  end

  def update
    if @user.update(user_params)
      render json: { message: 'User updated', user: to_json(@user) },
             status: 200,
             root: 'data'
    else
      render_error(InsufficientParamsError.new)
    end
  end

  def destroy
    @user.destroy
    render json: { message: 'Record deleted' },
           status: 200
  end

  private

  def set_user
    @user = User.find(params[:id])
    @user.nil? ? render_error(RecordNotFoundError.new) : @user
  end

  def render_error(error)
    render json: { message: error.message, code: error.code },
           status: error.code
  end

  def user_params
    params.permit(:first_name, :last_name, :email, :password)
  end

  def to_json(user)
    encrypted_password = user.password.crypt(user.password)
    {
      id: user.id,
      first_name: user.first_name,
      last_name: user.last_name,
      email: user.email,
      password: "ENCRIPTED PASSWORD: #{encrypted_password}"
    }
  end

  # RECORD NOT FOUND ERROR
  class RecordNotFoundError < ActiveModel::Errors
    attr_reader :message, :code
    def initialize
      @message = 'Record not found'
      @code = 404
    end
  end

  # RECORDS NOT FOUND ERROR
  class RecordsNotFoundError < ActiveModel::Errors
    attr_reader :message, :code
    def initialize
      @message = 'Records not found'
      @code = 404
    end
  end

  # INVALID PARAMS OR INSUFFICIENT ERROR
  class InsufficientParamsError < ActiveModel::Errors
    attr_reader :message, :code
    def initialize
      @message = 'Insufficient params'
      @code = 401
    end
  end
end
