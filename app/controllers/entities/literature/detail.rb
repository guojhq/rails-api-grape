module Entities
  module Literature
    class Detail < Base
      expose :title, :desc, :author, :tag, :discount_price, :price, :order_count, :verified

      expose :real_price do |record, options|
        record.real_price(options[:current_user_id])
      end

      expose :download_url do |record, options|
        record.download_url(options[:current_user_id])
      end

      expose :rank do |_record, options|
        options[:rank]
      end
    end
  end
end
