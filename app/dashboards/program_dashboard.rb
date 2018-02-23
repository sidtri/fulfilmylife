require "administrate/base_dashboard"

class ProgramDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    cards: Field::HasMany,
    id: Field::Number,
    name: Field::String,
    period: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    users: Field::HasMany,
    card_templates: Field::HasMany,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :cards,
    :card_templates,
    :id,
    :name,
    :period
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :cards,
    :card_templates,
    :id,
    :name,
    :period,
    :created_at,
    :updated_at,
    :users
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :name,
    :period,
    :users,
    :card_templates
  ].freeze

  # Overwrite this method to customize how programs are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(program)
    "#{program.name}"
  end
end
