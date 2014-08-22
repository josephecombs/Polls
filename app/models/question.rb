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
    #old bad way
    # ht = Hash.new(0)
    # answer_choices.each do |answer_choice|
    #   ht[answer_choice.answer] = answer_choice.responses.length
    # end
    #
    # ht
    #
    #now using joins
    # a = AnswerChoice.joins(:responses).where("question_id = ?", self.id).group(:answer).count(:answer)
    result = {}
    b = AnswerChoice.select("answer_choices.*, count(responses.id) as response_count")
      .joins('LEFT OUTER JOIN responses ON answer_choices.id = responses.answer_choice_id' )
      .where("question_id = ?", self.id)
      .group(:answer)
      # .count(:answer)
    b.each do |ac|
      result[ac.title] = ac.response_count
    end
    b.each_pair { |k, v| b[k] = 0 }
    # b.merge(a)
  end
end
