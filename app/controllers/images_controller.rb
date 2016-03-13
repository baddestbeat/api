class ImagesController < ApplicationController
  permits :file
  require 'time'
  require "tinify"
  Tinify.key = ENV["TINTPNG_API_KEY"]

  def new
    @image = Image.new
  end

  def upload(image)
    path= Time.parse(Time.now.to_s).to_i.to_s + "/" + image["file"].original_filename.to_s
    #File.open("public/upload-images/#{path}", 'wb')
    @image=Image.create!(file: path)
    save_light_img_s3(image["file"].tempfile, path)
    @result = Gcv.new.request(image["file"].tempfile)
  end


  def save_light_img_s3(img, path)
    source = Tinify.from_file(img)
    resized = source.resize(
      method: "fit",
      width: 300,
      height: 300
    )
    resized.store(
      service: "s3",
      aws_access_key_id: ENV["AWS_ACCESS_KEY_ID"],
      aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
      region: "ap-northeast-1",
      path: ENV["S3_BUCKET_PATH"] + path
    )
  end
end
