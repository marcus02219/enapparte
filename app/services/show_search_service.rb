class ShowSearchService
  def initialize(params)
    @shows = get_shows(params[:query])
    filter_price(params[:price_min], params[:price_max])
  end

  def get_shows(query)
    if query.present?
      filter_by_query(query)
    else
      Show.where(active: true).order('rating desc')
    end
  end

  def filter_by_query(query)
    @shows = Show.__elasticsearch__
                 .search(query: { query_string: { query: query } })
                 .records.where(active: true).order('rating desc')
  end

  def filter_price(price_min, price_max)
    return @shows if price_min.blank? || price_max.blank?
    @shows = @shows.where(price: price_min..price_max)
  end

  def results
    @shows
  end
end
