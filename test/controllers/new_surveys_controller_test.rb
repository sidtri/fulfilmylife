require 'test_helper'

class NewSurveysControllerTest < ActionDispatch::IntegrationTest
  setup do
    @new_survey = new_surveys(:one)
  end

  test "should get index" do
    get new_surveys_url
    assert_response :success
  end

  test "should get new" do
    get new_new_survey_url
    assert_response :success
  end

  test "should create new_survey" do
    assert_difference('NewSurvey.count') do
      post new_surveys_url, params: { new_survey: { answer: @new_survey.answer, card_id: @new_survey.card_id, question_id: @new_survey.question_id } }
    end

    assert_redirected_to new_survey_url(NewSurvey.last)
  end

  test "should show new_survey" do
    get new_survey_url(@new_survey)
    assert_response :success
  end

  test "should get edit" do
    get edit_new_survey_url(@new_survey)
    assert_response :success
  end

  test "should update new_survey" do
    patch new_survey_url(@new_survey), params: { new_survey: { answer: @new_survey.answer, card_id: @new_survey.card_id, question_id: @new_survey.question_id } }
    assert_redirected_to new_survey_url(@new_survey)
  end

  test "should destroy new_survey" do
    assert_difference('NewSurvey.count', -1) do
      delete new_survey_url(@new_survey)
    end

    assert_redirected_to new_surveys_url
  end
end
