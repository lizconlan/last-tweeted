require 'hpricot'
require 'open-uri'

class Twitterer
  class << self; 
    attr_accessor :id
    attr_accessor :name
    attr_accessor :screen_name
    attr_accessor :last_tweet_text
    attr_accessor :last_tweeted 
  end
  
  def id
    @@id
  end
  
  def name
    @@name
  end
  
  def screen_name
    @@screen_name
  end
  
  def last_tweet_text
    @@last_tweet_text
  end
  
  def last_tweeted
    @@last_tweeted
  end
  
  
  def initialize(screen_name)
    @@screen_name = screen_name
    
    doc = get_user_info(screen_name)
    
    @@id = (doc/:user/:id).inner_html
    @@name = (doc/:user/:name).inner_html
    @@last_tweet_text = (doc/:user/:status/:text).inner_html
    @@last_tweeted = (doc/:user/:status/:created_at).inner_html
  end
  
  def moribund?
    about_three_months = 60 * 60 * 24 * 30 * 3
    
    if last_tweeted.blank?
      return true
    else
      last_tweet_time = Time.parse(last_tweeted)
      three_months_ago = Time.now - about_three_months
    
      if last_tweet_time < three_months_ago
        return true
      else
        return false
      end
    end
  end
  
  private
    def get_user_info(screen_name)
      doc = open("http://twitter.com/users/show/#{screen_name}.xml") do |f|
         Hpricot.XML(f)
      end
    end
end
