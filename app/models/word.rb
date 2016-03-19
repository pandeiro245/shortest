require 'open-uri'
class Word < ActiveRecord::Base
  def tweets
    Tweet.where("text like ?", "%#{title}%").order('retweet_count desc, favorite_count desc')
  end

  def wp
    html = wikipedia || fetch_wikipedia
    Nokogiri::HTML.parse(html).search('#mw-content-text p:first').to_s.gsub(/href="\/wiki/, 'href="/words')
  end

  def wp_img
    html = wikipedia || fetch_wikipedia
    return '' if html == ''
    begin
      Nokogiri::HTML.parse(html).search('#mw-content-text img').first[:src]
    rescue
      ''
    end
  end

  def fetch_wikipedia
    begin
      charset = nil
      url = "https://en.wikipedia.org/wiki/#{title}"
      url = URI.escape(url)
      html = open(url) do |f|
        charset = f.charset
        f.read
      end
    rescue
      html = ''
    end
    self.wikipedia = html
    self.save!
    Nokogiri::HTML.parse(html, nil, charset)
  end
end
