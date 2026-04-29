class TodosController < ApplicationController
  before_action :set_todo, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /todos or /todos.json
  def index
  @selected_folder = params[:folder].presence || "all"
  @selected_view   = params[:view].presence || "list"

  @folders = Todo.where(created_by: current_user.id).distinct.pluck(:folder)

  # ===== BASE SCOPE =====
  scope = Todo.where(created_by: current_user.id)
  scope = scope.where(folder: @selected_folder) unless @selected_folder == "all"

  # ===== LIST VIEW =====
  @undone = scope.where(status: 0)
  @done   = scope.where(status: 1)

  # ===== CALENDAR DATE RANGE =====
  current_date =
    if params[:year] && params[:month]
      Date.new(params[:year].to_i, params[:month].to_i, 1)
    else
      Date.today.beginning_of_month
    end

  start_date = current_date.beginning_of_month
  end_date   = current_date.end_of_month

  # ===== CALENDAR DATA =====
  @todos_by_date = scope
    .where(due_date: start_date..end_date)
    .group_by(&:due_date)

  @current_date = current_date
  end

  # GET /todos/1 or /todos/1.json
  def show
    redirect_to todos_path
  end

  # GET /todos/new
  def new
    @todo = Todo.new
  end

  # GET /todos/1/edit
  def edit
  end

  # POST /todos or /todos.json
  def create
    @todo = Todo.new(todo_params)

    respond_to do |format|
      if @todo.save
        format.html { redirect_to @todo, notice: "Todo was successfully created." }
        format.json { render :show, status: :created, location: @todo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /todos/1 or /todos/1.json
  def update
    respond_to do |format|
      if @todo.update(todo_params)
        format.html { redirect_to @todo, notice: "Todo was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @todo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todos/1 or /todos/1.json
  def destroy
    @todo.destroy!

    respond_to do |format|
      format.html { redirect_to todos_path, notice: "Todo was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo
      @todo = Todo.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def todo_params
      params.expect(todo: [ :content, :status, :created_by, :priority, :folder, :due_date ])
    end
end
