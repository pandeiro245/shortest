require 'open-uri'
class Word < ActiveRecord::Base

  def self.sync
    self.all.each do |word|
      user = User.actives.random.first
      Tweet.sync_word(user, word.title)
      Tweet.sync_word(user, word.title, 'recent')
      sleep 5
    end
    self.update
  end

  def tweets refresh=false
    res = Tweet.where("text like ?", "%#{title}%").order('retweet_count desc, favorite_count desc').limit(30)
    #if res.blank?
    #if refresh
    if false
      Tweet.sync_word nil, title, 'recent'
      res = Tweet.where("text like ?", "%#{title}%").order('retweet_count desc, favorite_count desc').limit(30)
    end
    res
  end

  def wp
    html = wikipedia || fetch_wikipedia
    Nokogiri::HTML.parse(html).search('#mw-content-text p:first').to_s.gsub(/href="\/wiki/, 'href="/words').gsub(/http:\/\/[a-z]*.wikipedia.org\/wiki/, '/words')
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
      begin
        charset = nil
        url = "https://ja.wikipedia.org/wiki/#{title}"
        url = URI.escape(url)
        html = open(url) do |f|
          charset = f.charset
          f.read
        end
      rescue
        html = ''
      end
    end
    self.wikipedia = html
    self.save!
    Nokogiri::HTML.parse(html, nil, charset)
  end
end
