class ArticlesController < ApplicationController
  def index
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:success] = "Article has been created"
      redirect_to articles_path
    else
      #using flash.now so that the message does not persist as in the success message that carries over to the other page. 
      flash.now[:danger] = "Article has not been created"
      render :new
    end
  end
  private
    def article_params
      #:article is "top level key"
      params.require(:article).permit(:title, :body)
    end

end
