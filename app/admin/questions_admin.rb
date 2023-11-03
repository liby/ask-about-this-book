Trestle.resource(:questions) do
  menu do
    item :questions, icon: "fa fa-star"
  end

  # Customize the table columns shown on the index view.
  table do
    column :question
    column :answer
    column :context
    column :ask_count
    column :created_at, align: :center
    column :updated_at, align: :center
    actions
  end

  # Customize the form fields shown on the new/edit views.
  form do |question|
    text_field :question
    text_area :answer
    text_area :context
    number_field :ask_count  # 添加此行来显示和编辑 ask_count 字段

    row do
      col { datetime_field :updated_at }
      col { datetime_field :created_at }
    end
  end
  
  # Customize the table columns shown on the index view.
  #
  # table do
  #   column :name
  #   column :created_at, align: :center
  #   actions
  # end

  # Customize the form fields shown on the new/edit views.
  #
  # form do |question|
  #   text_field :name
  #
  #   row do
  #     col { datetime_field :updated_at }
  #     col { datetime_field :created_at }
  #   end
  # end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # params do |params|
  #   params.require(:question).permit(:name, ...)
  # end
end
