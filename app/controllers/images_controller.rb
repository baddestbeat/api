class ImagesController < ApplicationController
  permits :file

  def new
    @image = Image.new
  end

  def upload(image)
    @image = Image.new(image)
    @image.save
    @result = Gcv.new.request(@image.file.path)
  end
end
