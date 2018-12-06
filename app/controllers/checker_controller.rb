require 'phonetic'
require 'csv'

InFile = '/mnt/shared/validity/normal.csv'


class CheckerController < ApplicationController
  
  def index
  	@links = [txt: 'Upload', path: '#', class: 'upload-csv']
  end

  def upload_csv
  	puts params.keys.inspect
  	puts '---------------'
    csv_file = params[:csv_file]
    tmp_file = csv_file.tempfile
    pub_path = Rails.root.join('public', 'uploads', csv_file.original_filename)
    File.delete(pub_path) if File.exist?(pub_path)	

	File.open(pub_path, 'wb') do |file|
	  file.write(tmp_file.read)
	end
    out = ''
	# puts 'bob'.metaphone

	map = {}

	CSV.foreach(pub_path, :headers => true) do |row|
	  out << 'row:' + row.inspect
	  ky = row['first_name'].metaphone + row['last_name'].metaphone
	  map[ky] = map[ky] ? map[ky].push(row) : [row]  
	end

	map.keys.each do |element|
	  if map[element].length > 1
	    out << 'dupes:' + map[element].inspect + "\n\n"
	  end
	end

	render json: map.to_json

  end

end
