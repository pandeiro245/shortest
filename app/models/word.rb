require 'open-uri'
class Word < ActiveRecord::Base
  def tweets
    Tweet.where("text like ?", "%#{title}%")
  end

  def wp
    html = wikipedia || fetch_wikipedia
    Nokogiri::HTML.parse(html).search('#mw-content-text p:first').to_s.gsub(/href="\/wiki/, 'href="/words')
  end

  def wp_img
    html = wikipedia || fetch_wikipedia
    Nokogiri::HTML.parse(html).search('#mw-content-text img').first[:src]
  end

  def fetch_wikipedia
    charset = nil
    url = "https://en.wikipedia.org/wiki/#{title}"
    html = open(url) do |f|
      charset = f.charset
      f.read
    end
    self.wikipedia = html
    self.save!
    Nokogiri::HTML.parse(html, nil, charset)
  end
end
