class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]

  # GET /articles or /articles.json
  def index
    @articles = Article.all
  end

  def search
    input = params[:title_search].downcase
    @results = Article.filtered_title(input).first
    record = ArticleRecord.filtered_record(@results.title.downcase) if @results.present? && @results.title.downcase.include?(input)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update('search_result', partial: 'articles/result',
                                                                  locals: { articles: @results })
      end
    end
    return record.update(searched_record: record.first.searched_record + 1) if record.present?

    ArticleRecord.create(key_word: @results.title, searched_record: 1, user_id: current_user.id) if @results.present?
  end

  def show; end

  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to article_url(@article), notice: 'Article was successfully created.' }
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
        format.html { redirect_to article_url(@article), notice: 'Article was successfully updated.' }
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
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
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
