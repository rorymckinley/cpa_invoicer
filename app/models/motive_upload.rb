class MotiveUpload
  include ActiveModel::Model

  def process(io)
    CSV.parse(io.read, headers: true) do |rec|
      motive = Motive.where(number: rec["NUMBER,N,6,0"].to_i).first
      if motive
        motive.update_attributes(number: rec["NUMBER,N,6,0"].to_i, description: rec["DESCRIP,C,25"])
      else
        Motive.create(number: rec["NUMBER,N,6,0"], description: rec["DESCRIP,C,25"])
      end
    end
  end
end
