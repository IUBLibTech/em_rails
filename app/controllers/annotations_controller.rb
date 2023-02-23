class AnnotationsController < ApplicationController
  before_action :logged_in?, except: [:sample]

  # GET /annotations/1 or /annotations/1.json
  def show
    @annotation = Annotation.find(params[:id])
  end

  def sample
    @annotation = Annotation.find(params[:id])
    unless @annotation.sample
      flash[:warning] = "You must be signed in to view this content"
      redirect_to signin_path
    else
      render 'show'
    end
  end

  def purl
    # the incoming route with params looks like: /media.html?aid=Alajaji/910339 so we need to split to get
    # just the annotation id
    aid = params[:aid].split('/').last
    redirect_to annotation_path(aid)
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_annotation
      @annotation = Annotation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def annotation_params
      params.fetch(:annotation, {})
    end
end
