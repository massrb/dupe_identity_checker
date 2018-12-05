require 'phonetic'
require 'csv'

InFile = '/mnt/shared/validity/normal.csv'


class CheckerController < ApplicationController
  
  def index
  	@links = [txt: 'Upload', path: '#', class: 'upload-csv']
  end

  def upload_csv


	# puts 'bob'.metaphone

	map = {}

	CSV.foreach(InFile, :headers => true) do |row|
	  puts 'row:' + row.inspect
	  puts '1'
	  ky = row['first_name'].metaphone + row['last_name'].metaphone
	  puts '2'
	  map[ky] = map[ky] ? map[ky].push(row) : [row]  
	  puts 'end of loop'
	end

	map.keys.each do |element|
	  if map[element].length > 1
	    puts 'dupes:' + map[element].inspect + "\n\n"
	  end
	end

  end

end
