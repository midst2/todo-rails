module TodosHelper
  # app/helpers/todos_helper.rb
  def todo_params(overrides = {})
    {
      folder: @selected_folder,
      view: @selected_view,
      month: params[:month],
      year: params[:year]
    }.merge(overrides)
  end
end
