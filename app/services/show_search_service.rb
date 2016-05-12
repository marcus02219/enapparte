class ShowSearchService
  def initialize(params)
    @shows = get_shows(params[:query])
    filter_price(params[:price_min], params[:price_max])
    filter_by_arts(params[:arts])
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

  def filter_by_arts(arts)
    return @shows if arts.blank?
    art_ids = JSON.parse(arts)
    return unless art_ids.any?
    @shows = @shows.where(art_id: art_ids)
  end

  def results
    @shows
  end
end
