module Entities
  # only for data_build_helper#entities_record
  class RecordBase < Base
    expose :id
    expose(:class) { |record| record.class.to_s }
    with_options(format_with: :time_format) { expose :created_at, :updated_at }
    expose(:attributes) { |instance, options| options[:glass].represent instance, options }
  end
end
