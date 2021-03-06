require "administrate/base_dashboard"

class CardDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    title: Field::String,
    sub_title: Field::String,
    total_time: Field::String,
    days: Field::Number,
    category: Field::BelongsTo,
    program: Field::BelongsTo,
    content: Field::Text,
    parsed_content: Field::Hidden,
    tag: Field::EnumField,
    references: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    card_templates: Field::NestedHasMany.with_options(skip: :name)
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :id,
    :title,
    :days,
    :tag,
    :program,
    :category,
    :total_time,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :title,
    :sub_title,
    :total_time,
    :program,
    :category,
    :days,
    :tag,
    :content,
    :card_templates,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :title,
    :sub_title,
    :total_time,
    :days,
    :program,
    :category,
    :tag,
    :content,
    :parsed_content,
    :card_templates
  ].freeze

  # Overwrite this method to customize how cards are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(card)
    "#{card.title}"
  end
end
