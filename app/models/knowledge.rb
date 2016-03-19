class Knowledge < ActiveRecord::Base
  belongs_to :word
  belongs_to :tweet
end
