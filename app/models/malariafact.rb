class Malariafact < ActiveRecord::Base
    has_many :malariafactviews
    
    serialize :content
    
    # TYPE
    enum fact_type: { :question => 0, :text_fact => 1, :text_narrative => 2, :video => 3, :link => 4, :graphic => 5 }
    
    def get_question
        if not self.question?
            return nil
        end

        case self.content[1]
        when 'multiple_choice'
            {
                round: self.content[0],
                question_type: self.content[1],
                question_text: self.content[2],
                answers: self.content[3],
                correct: self.content[4],
                correct_text: self.content[5],
                incorrect_text: self.content[6],
            }
        when 'binary'
            {
              round: self.content[0],
              question_type: self.content[1],
              question_text: self.content[2],
              correct: self.content[3],
              correct_text: self.content[4],
              incorrect_text: self.content[5],
            }
        when 'fb_task'
            {
            round: self.content[0],
            question_type: self.content[1],
            question_text: self.content[2],
            question_api_url: self.content[3],
            completed_button: self.content[4],
            }
        end
    end
end
