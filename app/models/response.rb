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
    # self.question.responses.where(self.user_id != user_id)
    if !self.id.nil?
      # self.question.responses#.where('user_id != ?', self.user_id)
      self.question.responses.where('responses.id != ?', self.id)
    else
      puts "record has not been written to db yet"
      # TODO: Use this.
      #self.question.responses.where('responses.id != ?', self.id)
    end
  end
  
  private
  
  def is_not_the_author?
    # TODO: Rework to use joins
    if self.user_id == self.question.poll.author_id
      errors.add(:author, "response cant be submitted by poll author")
    end
  end
  
  def respondent_has_already_answered_question
    # TODO: Add .where responses.user_id is our user_id, then check exists?
    array_of_user_id = self.sibling_responses.to_a.map { |resp| resp.user_id }
    array_of_user_id.include? self.user_id
    # TODO: Add errors here.
    #.includes(:user_id).where('user_id = ?', self.user_id)
  end
  
  
end
