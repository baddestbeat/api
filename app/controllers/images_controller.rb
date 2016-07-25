#
class ImagesController < ApplicationController
  permits :file
  require 'time'
  require "tinify"

  def new
    @image = Image.new
  end

  def upload
    if(params[:image])
      @image = Image.new(file: params[:image][:file])
    else
      @image = Image.new
    end
    if @image.save
      env_prefix = get_env
      resized_path = "#{env_prefix}/uploads/image/file/#{@image.id}/300/#{params[:image][:file].original_filename}"
      @image.path = resized_path
      @image.save
      save_light_img_s3(params[:image][:file].tempfile, @image.id, resized_path)
      @result = GoogleApi.new.request(params[:image][:file].tempfile)
    else
      render :action => 'new'
    end
  end

  def list
    @images = Image.order("created_at DESC").page params[:page]
  end

  def about
  end

  def trans
    EasyTranslate.api_key = ENV['TRANS_SERVER_KEY']
    @translated = EasyTranslate.translate(params.delete_if{|p| p !~ /^word/ }.sort.collect!{ |k, v| v }.join(" "), :to => :ja)
  end

  def save_light_img_s3(img, id, path)
    Tinify.key = ENV["TINTPNG_API_KEY"]
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
