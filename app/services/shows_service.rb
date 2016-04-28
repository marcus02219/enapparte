class ShowsService
  def search query, price0, price1, arts
    if query.present?
      response = Show.__elasticsearch__.search(query: { query_string: { query: query } })
      @shows = response.records.where(active: true).order('rating desc')
    end

    if price0.present? && price1.present?
      @shows = Show.where(active: true).order('rating desc')  if @shows.nil?
      @shows = @shows.where(price: price0..price1)
    end

    if arts.present?
      art_ids = JSON.parse(arts)
      if art_ids.any?
        @shows = Show.where(active: true).order('rating desc')  if @shows.nil?
        @shows = @shows.where(art_id: art_ids)
      end
    end

    if @shows.nil?
      @shows = Show.where(active: true).order('rating desc').all
    end
    @shows
  end
end
