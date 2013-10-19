require 'csv'

class TitleUpload
  include ActiveModel::Model

  def process(io)
    contents = io.read
    CSV.parse(contents, headers: true) do |rec|
      if title = Title.where(number: rec['NUMBER,N,3,0']).first
        title.update_attributes(description: rec['DESCRIP,C,20'])
      else
        Title.create(number: rec['NUMBER,N,3,0'], description: rec['DESCRIP,C,20'])
      end
    end
  end
end
