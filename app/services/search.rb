class Search
  DIVISIONS = %w(Everywhere Question Answer Comment User)

  def self.find_object(query, division)
    query = Riddle::Query.escape(query)
    return ThinkingSphinx.search query if division == 'Everywhere'
    division.classify.constantize.search(query)
  end
end
