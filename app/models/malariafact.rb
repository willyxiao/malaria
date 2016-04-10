class Malariafact < ActiveRecord::Base
    has_many :malariafactviews
    
    serialize :content
    
    # TYPE
    enum fact_type: { :question => 0, :text_fact => 1, :text_narrative => 2, :video => 3, :link => 4, :graphic => 5 }
end
