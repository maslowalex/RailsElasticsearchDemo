class Character < ApplicationRecord
  include Searchable

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :name, type: 'text', analyzer: 'ngram_analyzer', search_analyzer: 'whitespace_analyzer'
      indexes :origin, type: 'text', analyzer: 'ngram_analyzer', search_analyzer: 'whitespace_analyzer'
      indexes :suggest, type: 'completion'
    end
  end
end
