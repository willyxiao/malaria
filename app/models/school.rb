class School < ActiveRecord::Base
    has_many :communities
    has_one :admin
end
