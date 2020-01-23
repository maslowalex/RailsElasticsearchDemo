module Searchable
  extend ActiveSupport::Concern

  FILTER = { type: 'nGram', min_gram: 2, max_gram: 3 }
  ANALYZER = {
    type: 'custom',
    tokenizer: 'standard',
    filter: %w[lowercase asciifolding ngram_filter]
  }
  WS_ANALYZER = {
    type: 'custom',
    tokenizer: 'whitespace',
    filter: %w[lowercase asciifolding]
  }

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    settings analysis: {
      filter: {
        ngram_filter: FILTER
      },
      analyzer: {
        ngram_analyzer: ANALYZER,
        whitespace_analyzer: WS_ANALYZER
      }
    }

    def self.mapped_search(q:, except: [])
      results = self.search(q).results

      return if results.empty?

      results.map do |r|
        if except&.empty?
          r._source.to_hash
        else
          return r._source.to_hash unless except.is_a?(Array)

          r._source.to_hash.except(*except.map(&:to_s))
        end
      end
    end
  end
end
