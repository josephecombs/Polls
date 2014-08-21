class Response < ActiveRecord::Base
  validates :answer_choice_id, presence: true
  validates :user_id, presence: true
  validate :is_not_the_author?
  validate :respondent_has_already_answered_question
  
  
  belongs_to(
    :answer_choice,
    class_name: "AnswerChoice",
    foreign_key: :answer_choice_id,
    primary_key: :id
  )
  
  belongs_to(
    :respondent,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )
  
  has_one(
    :question,
    through: :answer_choice,
    source: :question
  ) 
  
  def sibling_responses
    if self.id.nil?
      self.question.responses#.where('user_id != ?', self.user_id)
    else
      self.question.responses.where('responses.id != ?', self.id)
    end
  end
  
  private
  
  def is_not_the_author?
    if Question.joins(:poll).where("author_id = ?", self.user_id).pluck(:id).include?(self.question.id)
      errors.add(:author, "response cant be submitted by poll author")
    end
  end
  
  def respondent_has_already_answered_question
    if Response.joins(:question).where("question_id = ?", self.question.id).exists?(user_id: self.user_id)
      errors.add(:user_id, "User has already responded")
    end
  end
  
  
end
