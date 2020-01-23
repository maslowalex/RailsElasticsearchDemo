module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    def self.mapped_search_results(q:, except: [])
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
