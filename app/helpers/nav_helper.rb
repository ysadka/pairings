module NavHelper

  def condesnse_by_uniqueness
    @sub_categories.each do |k, v|
      v.uniq!
    end
  end

  def create_sub_category(type)
    @sub_categories[type] = []
  end

  def sub_exists?(type)
    @sub_categories.has_key?(type)
  end

  def new_sub_needed?(type)
    create_sub_category(type) unless sub_exists?(type)
  end

  def wine_sub_segments
    nav_grapes = Grape.all
    @sub_categories = {}
    nav_grapes.each do |grape|
      unless grape.varietal.empty?
        grape.wines.limit(10).each do |wine|
          unless wine.category_type.empty?
            new_sub_needed?("#{wine.category_type}")
            @sub_categories["#{wine.category_type}"] << grape.varietal
          end
        end
      end
    end
    condesnse_by_uniqueness
    @sub_categories
  end
end
