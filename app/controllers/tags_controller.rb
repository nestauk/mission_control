class TagsController < ApplicationController
  before_action :load_tag, except: %i[index new create]

  def index
    @tags = Tag.order(:title)
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(form_params)

    if @tag.save
      redirect_to tags_path(@tag), notice: 'Tag created'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @tag.update(form_params)
      redirect_to tags_path(@objective), notice: 'Tag updated'
    else
      render :edit
    end
  end

  private

  def form_params
    params.require(:tag).permit(:title, :description)
  end

  def load_tag
    @tag = Tag.find_by(id: params[:id])
  end
end
