class Payload < ActiveRecord::Base

  attr_accessible :address, :date, :login, :message, :password_hash, :title
end
