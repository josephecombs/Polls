class Question < ActiveRecord::Base
  validates :question_text, :poll_id, presence: true
  
  belongs_to(
    :poll,
    class_name: "Poll",
    foreign_key: :poll_id,
    primary_key: :id
  )
  
  has_many(
    :answer_choices,
    class_name: "AnswerChoice",
    foreign_key: :question_id,
    primary_key: :id
  )
  
  #through association to responses
  has_many(
    :responses,
    through: :answer_choices,
    source: :responses
  )
  
  def results
    #TODO: REWORK USING JOIN
    ht = Hash.new(0)
    answer_choices.each do |answer_choice|
      ht[answer_choice.answer] = answer_choice.responses.length
    end
    
    ht
  end
end
