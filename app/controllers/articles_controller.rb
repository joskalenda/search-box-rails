class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]

  # GET /articles or /articles.json
  def index
    @articles = Article.all
  end

  def search
    input = params[:title_search]
    @results = Cach.where('created_at >= ?', Time.now - 2.seconds)
    # p "tis is tjdjd", @results.length.zero?

    if @results.length.zero?
      #simlink
      @results = Article.filtered_title(input)
      # p "tis is tjdjd", @results.title
    end
    respond_to do |format|
      format.turbo_stream do
          render turbo_stream: turbo_stream.update("search_result", partial: "articles/result", locals: { articles: @results})
      end
    end
    save_the_input
  end

  # Save the user rearch input if it not in the Article table
  def save_the_input
   Cach.find_or_create_by(title: params[:title_search]) if Article.all.where(title: params[:title_search]).length.zero?    
  end

  def search_by_cache
    @results = Article.filtered_title(params[:title_search])
    respond_to do |format|
      format.turbo_stream do
          render turbo_stream: turbo_stream.update("search_result", partial: "articles/result", locals: { articles: @results})
      end
    end
  end

  # GET /articles/1 or /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles or /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to article_url(@article), notice: "Article was successfully created." }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to article_url(@article), notice: "Article was successfully updated." }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url, notice: "Article was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title)
    end
end
