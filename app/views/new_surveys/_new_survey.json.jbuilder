json.extract! new_survey, :id, :card_id, :question_id, :answer, :created_at, :updated_at
json.url new_survey_url(new_survey, format: :json)
