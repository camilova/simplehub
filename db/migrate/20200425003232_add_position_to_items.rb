class AddPositionToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :position, :integer
    add_column :sources, :position, :integer

    Item.main.order(published_at: :desc, created_at: :desc).each.with_index(1) do |item, index|
      item.update_column :position, index
      item.sources.each.with_index(1) do |source, index|
        source.update_column :position, index
      end
      item.items.order(published_at: :desc).each.with_index(1) do |subitem, index|
        subitem.update_column :position, index
        subitem.sources.each.with_index(1) do |source, index|
          source.update_column :position, index
        end
      end
    end
  end
end
