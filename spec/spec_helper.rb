RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  # Elasticsearch configuration

  # config.before :all, elasticsearch: true do
  #   Elasticsearch::Extensions::Test::Cluster.start() unless
  #     Elasticsearch::Extensions::Test::Cluster.running?(port: 9200)
  # end
  # It will create all the indexes and load the documents if exists.
  config.before :each do
    [Character].each do |model|
      if model.respond_to?(:__elasticsearch__)
        begin
          model.__elasticsearch__.create_index!
          model.__elasticsearch__.refresh_index!
        rescue Elasticsearch::Transport::Transport::Errors::NotFound => e
          puts "There was an error creating the elasticsearch index
                for #{model.name}: #{e.inspect}"
        end
      end
    end
  end
  # After all the tests were done it will stop the ES instance if it's # still running
  # config.after :suite do
  #   Elasticsearch::Extensions::Test::Cluster.stop if
  #     Elasticsearch::Extensions::Test::Cluster.running?(port: 9200)
  # end
  # It will delete the indexes after each test.
  config.after :each do
    [Character].each do |model|
      if model.respond_to?(:__elasticsearch__)
        begin
          model.__elasticsearch__.delete_index!
        rescue Elasticsearch::Transport::Transport::Errors::NotFound => e
          puts "There was an error removing the elasticsearch index
                for #{model.name}: #{e.inspect}"
        end
      end
    end
  end
end
