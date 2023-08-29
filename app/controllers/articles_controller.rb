class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show update destroy ]
  before_action :authenticate_user!, only: %i[create update]

  # GET /articles
  def index
    @articles = Article.all

    render json: @articles
  end

  # GET /articles/1
  def show
    render json: @article
  end

  # POST /articles
  def create
    @article = Article.new(article_params) 
      
    if article_params[:user_id] == current_user.id
      if @article.save
        render json: @article, status: :created, location: @article
      else
        render json: { error: "Suite à une erreur, l'article n'a pas été créé." }, status: :unprocessable_entity
      end
    else
      render json: { error: "Vous n'avez pas la permission de créer cet article." }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /articles/1
  def update
    if @article.user.id == current_user.id
      if @article.update(title: article_params[:title], content: article_params[:content], user_id: @article.user.id)
        render json: @article
      else
        render json: { error: "Suite à une erreur, l'article n'a pas été édité." }, status: :unprocessable_entity
      end
    else
      render json: { error: "Vous n'avez pas la permission de modifier cet article." }
    end
  end

  # DELETE /articles/1
  def destroy
    if @article.user.id == current_user.id
      @article.destroy
    else
      render json: { error: "Vous n'avez pas la permission de supprimer cet article." }, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :content, :user_id)
    end
end
