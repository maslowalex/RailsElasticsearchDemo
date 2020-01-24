require 'json'
require 'net/http'

task import_chars: :environment do
  Character.__elasticsearch__.create_index!

  16.times do |counter|
    response = Net::HTTP.get(URI("https://rickandmortyapi.com/api/character/?page=#{counter}"))
    parsed = JSON.parse(response)
  
    parsed.dig('results').each do |char|
      Character.create(
        name: char.dig('name'),
        gender: char.dig('gender'),
        origin: char.dig('origin', 'name')
      )
    end

    puts 'Batch processed' + " #{counter}" 
  end

  Character.import

  puts "#{Character.count} chars imported!"
end
