class ImagesController < ApplicationController
  permits :file
  require 'time'
  require "tinify"
  Tinify.key = ENV["TINTPNG_API_KEY"]

  def new
    @image = Image.new
  end

  def upload(image)
    if(image[:file].nil?)
      redirect_to root_path
    end
    env_prefix = get_env
    @image = Image.create!(file: image[:file])
    resized_path = "#{env_prefix}/uploads/image/file/#{@image.id}/300/#{image[:file].original_filename}"
    @image.path = resized_path
    @image.save
    save_light_img_s3(image[:file].tempfile, @image.id, resized_path)
    @result = Gcv.new.request(image[:file].tempfile)
  end

  def list
    @images = Image.order(:created_at).page params[:page]
  end


  def save_light_img_s3(img, id, path)
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
      path: "api-img/#{path}"
    )
  end
end
