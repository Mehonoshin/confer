class NewsArticlesController < BaseProjectController
  load_and_authorize_resource

  def index
    @news_articles = NewsArticle.where(conference_id: @conference.id)
    @title = "Feed title"
    @updated = @news_articles.first.updated_at unless @news_articles.empty?

    respond_to do |format|
      format.html
      format.atom { render layout: false }
      format.rss { redirect_to news_articles_path(format: :atom), status: :moved_permanently }
    end
  end

  def show
    @news_article = @conference.news_articles.where(id: params[:id]).last
  end

  def new
    @news_article = NewsArticle.new
  end

  def create
    attrs = params[:news_article].dup
    attrs[:participant_id] = @current_participant.id
    @news_article = @conference.news_articles.create!(attrs)
    redirect_to news_article_path(@news_article), notice: t('projects.news.notices.created')
  end

  def edit
    @news_article = @conference.news_articles.where(id: params[:id]).last
  end

  def update
    @news_article = @conference.news_articles.where(id: params[:id]).last
    @news_article.update_attributes(params[:news_article])
    redirect_to news_article_path(@news_article), notice: t('projects.news.notices.updated')
  end

  def destroy
    @news_article = @conference.news_articles.where(id: params[:id]).last
    @news_article.destroy
    redirect_to news_articles_path, notice: t('projects.news.notices.destroyed')
  end
end
