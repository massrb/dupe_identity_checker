require 'phonetic'
require 'csv'

InFile = '/mnt/shared/validity/normal.csv'


class CheckerController < ApplicationController
  
  def index
  	@links = [txt: 'Upload', path: '#', class: 'upload-csv']
  end

  def upload_csv
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
	result = {uniq: [], dup: []}

	CSV.foreach(pub_path, :headers => true) do |row|
	  ky = row['first_name'].metaphone + row['last_name'].metaphone
	  row_el = {} 
	  row.headers.each{|fld| row_el[fld] = row[fld]}
	  puts row_el.inspect
	  map[ky] = map[ky] ? map[ky].push(row_el) : [row_el]  
	end

	map.keys.each do |element|
	  if map[element].length > 1
	  	result[:dup] << map[element]
	    out << 'dupes:' + map[element].inspect + "\n\n"
	  else
	    result[:uniq] << map[element][0]    
	  end
	end

    out << "UNIQUE:\n\n" + result[:uniq].join("\n\n")
    out << "\n\n=============================\n\n"
    out << "DUPLICATES:\n\n" + result[:dup].join("\n\n")
    # puts out

	render json: result.to_json

  end

end
