

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

  result = IdChecker::FileReader.read(pub_path)
  puts result.out

	render json: result.data.to_json

  end

end
