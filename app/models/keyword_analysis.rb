class KeywordAnalysis
  def self.morphological_analysis(words)
    result = {}
    natto_mecab = Natto::MeCab.new

    words.each do |word|
      natto_mecab.parse(word) do |n|
        next if n.feature.split(",")[-1] !~ /wikipedia|hatena/

        if result["#{n.surface}"]
          result["#{n.surface}"] += 1
        else
          result["#{n.surface}"] = 1
        end
      end
    end

    return result
  end
end
