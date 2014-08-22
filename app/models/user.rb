class User < ActiveRecord::Base
  validates :user_name, presence: true, uniqueness: true
  
  has_many(
    :authored_polls,
    class_name: "Poll",
    foreign_key: :author_id,
    primary_key: :id
  )
  
  has_many(
    :responses,
    class_name: "Response",
    foreign_key: :user_id,
    primary_key: :id
  )
  
  def completed_polls
    completed_poll_count = 0
    # if user.responses in poll == poll.questions
    
    #hash of poll => num questions
    # Poll.joins(:questions).group('polls.title').count('polls.id')
    
    #questions' responses from same user per poll
    # Question.joins(:responses).where('poll_id = 1 AND user_id = ?').count
    # Poll.each
    #
    # end
    all_polls = []
    hash_tracker = Hash.new(0)
    arr_completed = []
    total_responses = 0
    
    Poll.joins(:questions).group('polls.title').count('polls.id').each_pair do |title, total_qs|
      cur_poll_id = lookup_poll_id_by_title(title)
      count_usr_answers_cur_poll = Question.joins(:responses).where('poll_id = ? AND user_id = ?', cur_poll_id, self.id).count
      if count_usr_answers_cur_poll == total_qs
        #user has answered all questions for this poll
        arr_completed << title
      end
      all_polls << title
      total_responses += count_usr_answers_cur_poll
      hash_tracker[title] = count_usr_answers_cur_poll
    end
    
    puts "grand responses hash: #{hash_tracker}"
    puts "total_responses for this user: #{total_responses}"
    puts "completed polls are: #{arr_completed.join(', ')}"
    puts "uncompleted polls are: #{(all_polls - arr_completed).join(', ')}"
  end
  
  def lookup_poll_id_by_title(title)
    Poll.where(:title => title).first.id
  end
  
end
