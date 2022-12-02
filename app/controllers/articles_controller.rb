class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]

  # GET /articles or /articles.json
  def index
    @articles = Article.all
  end

  def search
    input = params[:title_search]
    @results = Article.filtered_title(input).first
    record = ArticleRecord.filtered_record(@results.title) if @results.present? && @results.title.include?(input)
    # @path = Article.where(title: record.key_word)
    # p "ARTICLE WITH SAME RECORD TITLE", @path
    respond_to do |format|
      format.turbo_stream do
          render turbo_stream: turbo_stream.update("search_result", partial: "articles/result", locals: { articles: @results})
          # render turbo_stream: turbo_stream.update("cache_result", partial: "caches/output" , locals: { results: @path}) # and return
      end
    end
    return record.update(searched_record: record.first.searched_record + 1) if record.present? # && record.include?(input)
    return ArticleRecord.create(key_word: @results.title, searched_record: 1, user_id: current_user.id) if @results.present? # && @results.title.include?(input)
    # @results = Cach.where('created_at >= ?', Time.now - 1.seconds)

    # # p "tis is tjdjd", @results.length.zero?

    # if @results.length.zero?
    #   @results = Article.filtered_title(input).first
    #   if @results.present?
    #     # Cach.create(searched_record: @results.length)
    #     record = ArticleRecord.where(key_word: @results.title).first
    #     record.update(searched_record: record.searched_record + 1) if record.present?
    #     # ArticleRecrod.create(key_word: @results.title, searched_record: 1) if !record.present?
    #     # if record.present?
    #   # else
    #   # end
    #   end
    # end
    # # binding.pry
    # save_the_input
    # search_by_cache
  end

  # Save the user rearch input if it not in the Article table
  def save_the_input
   r = Cach.find_or_create_by(title: params[:title_search]) if Article.where(title: params[:title_search]).length.zero?
   p "INPUT", r.title
  end

  def search_by_cache
    all = Cach.all.count
    @result = Cach.count # where(title: params[:title_search]).includes?(params[:title_search])
    p "ALL THE CACHE", all
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update("cache_result", partial: "caches/output", locals: { results: @result}) # and return
      end
    end
  end

  # GET /articles/1 or /articles/1.json
  def show
  end

  # GET /articles/new
  # def new
  #   @article = Article.new
  # end

  # # GET /articles/1/edit
  # def edit
  # end

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
