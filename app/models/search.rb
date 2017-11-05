class Search
  DIVISIONS = %w(Everywhere Question Answer Comment User)

  def self.find(query, division)
    return ThinkingSphinx.search query if division == 'Everywhere'
    division.classify.constantize.search(query)
  end
end
