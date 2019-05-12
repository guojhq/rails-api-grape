# global helpers
module ApplicationHelper
  def verify_params!
    Svc::ParamsSignature.verify!(request)
  end

  def save_with_version(parent, *sons)
    ActiveRecord::Base.transaction do
      version = parent.release + 1

      parent.paper_trail_event = version
      sons.map { |son| son.paper_trail_event = version }

      yield if block_given?

      parent.release = version
      parent.save
    end
  end

  def update_or_create(glass, primary_key, params_array, foreign_key = nil, foreign_value = nil)
    primary_values =
      params_array.map do |params|
        primary_value            = params[primary_key.to_s] || params[primary_key.to_sym]
        record                   = glass.find_or_initialize_by(primary_key => primary_value)

        record.update!(params)
        primary_value
      end

    return if foreign_key.blank?

    glass.where(foreign_key => foreign_value).each do |record|
      record.destroy unless primary_values.include?(record.send(primary_key))
    end
  end
end
