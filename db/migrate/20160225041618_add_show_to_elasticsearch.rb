class AddShowToElasticsearch < ActiveRecord::Migration
  def change
    # Show.import
    Show.__elasticsearch__.create_index! force: true
    Show.__elasticsearch__.refresh_index!
  end
end
