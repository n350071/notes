# dogs/index.html.erb
# <%= form_for(@serach_form, as: 'search', url: manage_dogs_path, html:{method: :get}) do |f| %>
#   <div class="form-group">
#     <div>
#       <%= f.text_field :id, placeholder: t('activerecord.attributes.dog.id'), class: 'form-control' %>
#     </div>
#     &
#     <div>
#       <%= f.text_field :name, placeholder: t('activerecord.attributes.dog.name'), class: 'form-control' %>
#     </div>
#   </div>
#   <%= f.button t('words.actions.search'), class: 'btn btn-sm btn-info' %>
# <% end %>

# dogs_controller.rb
def index
  @serach_form = DogSearchForm.new(params[:search])
  @dogs = @serach_form.search.page params[:page]
end

# forms/dogs_search_form.rb
class DogeSearchForm
  include ActiveModel::Model

  attr_accessor  :id, :name

  def search
    rel = Operation
    rel = rel.where(id: id) if id.present?
    rel = rel.where("name LIKE (?)", "%#{name}%") if name.present?
    rel = rel.newer
  end
end
