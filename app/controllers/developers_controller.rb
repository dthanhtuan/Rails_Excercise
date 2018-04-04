class DevelopersController < ApplicationController
  before_action :set_developer, only: [:show, :edit, :update, :destroy]


  def index
    @developers_search_form = DevelopersSearchForm.new(search_params)
    @developers = @developers_search_form.search
  end


  def show
  end


  def new
    @developer = Developer.new
  end


  def edit
  end


  def create
    @developer = Developer.new(developer_params)

    respond_to do |format|
      if @developer.save
        format.html {redirect_to @developer, notice: 'Developer was successfully created.'}
        format.json {render :show, status: :created, location: @developer}
      else
        format.html {render :new}
        format.json {render json: @developer.errors, status: :unprocessable_entity}
      end
    end
  end


  def update
    respond_to do |format|
      if @developer.update(developer_params)
        format.html {redirect_to @developer, notice: 'Developer was successfully updated.'}
        format.json {render :show, status: :ok, location: @developer}
      else
        format.html {render :edit}
        format.json {render json: @developer.errors, status: :unprocessable_entity}
      end
    end
  end


  def destroy
    @developer.destroy
    respond_to do |format|
      format.html {redirect_to developers_url, notice: 'Developer was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private
  def set_developer
    @developer = Developer.find(params[:id])
  end


  def developer_params
    params.require(:developer).permit(:email)
  end

  def search_params
    return {} if params[:developers_search_form].blank?
    params.require(:developers_search_form).permit(:email, :prog_lang, :language_code, :show_all)
  end
end
