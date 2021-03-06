class Impression < ActiveRecord::Base
  belongs_to :impressionable, polymorphic: true, counter_cache: :view_count
  #after_save :update_impressions_counter_cache

  private

  def update_impressions_counter_cache
    impressionable_class = self.impressionable_type.constantize

    if impressionable_class.impressionist_counter_cache_options
      resouce = impressionable_class.find(self.impressionable_id)
      resouce.try(:update_impressionist_counter_cache)
    end
  end
end
