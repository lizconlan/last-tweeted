require 'hpricot'
require 'open-uri'

class Twitterer
  attr_reader :id
  attr_reader :name
  attr_reader :screen_name
  attr_reader :last_tweet_text
  attr_reader :last_tweeted 
    
  def initialize(screen_name)
    @screen_name = screen_name
    
    doc = get_user_info(screen_name)
    
    if @error
      @name = "ERROR: User Not Found"
      @id = nil
      @last_tweet_text = ""
      @last_tweeted = nil
    else
      @id = (doc/:user/:id).inner_html
      if (doc/:user/:protected).inner_html == "true"
        @name = "This user has protected their updates"
        @last_tweet_text = ""
        @last_tweeted = nil
      else
        @name = (doc/:user/:name).inner_html
        @last_tweet_text = (doc/:user/:status/:text).inner_html
        @last_tweeted = (doc/:user/:status/:created_at).inner_html
      end
    end
  end
  
  def moribund?
    about_three_months = 60 * 60 * 24 * 30 * 3
    
    if last_tweeted.nil?
      return nil
    end
    
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

  def to_param
    screen_name
  end
  
  private
    def get_user_info(screen_name)
      doc = open("http://twitter.com/users/show/#{screen_name}.xml") do |f|
         Hpricot.XML(f)
      end
      rescue
        @error = true
    end
end
