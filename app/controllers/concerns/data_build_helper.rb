# 200 code 返回 data 构建规则
# 203 表示 token 有更新, 检查 response header Authorization, 得到新的token, 此时应该更新客户端的 token
# 结构说明 {meta: {*payload, path: '/', version: '1'}, data: {id: '1', type: 'User', attributes: {}}/[]}
module DataBuildHelper
  def data!(data)
    meta = default_meta

    if data.is_a?(String)
      meta[:message] = data
      data           = nil
    elsif data[:meta]
      meta.merge!(data.delete(:meta))
    end

    { meta: meta, data: data }
  end

  def data_paginate!(records, entities_class, meta = {})
    opts                   = meta.delete(:opts) || {}
    opts[:current_user_id] = current_user_id
    base_num               = (records.current_page - 1) * records.limit_value

    {
      meta: default_meta.merge(pagination(records)).merge(meta),
      data: records.map.each_with_index { |record, index| entities_record(record, entities_class, opts.merge(rank: base_num + index + 1)) }
    }
  end

  def data_record!(record, entities_class, meta = {})
    opts                   = meta.delete(:opts) || {}
    opts[:current_user_id] = current_user_id

    {
      meta: default_meta.merge(meta),
      data: entities_record(record, entities_class, opts)
    }
  end

  private

  def entities_record(record, entities_class, opts)
    opts ||= {}
    Entities::RecordBase.represent record, opts.merge(glass: entities_class)
  end

  def default_meta
    request = Grape::Request.new(env)
    meta    = {
      message: '请求成功',
      path:    request.path,
      status:  200,
      version: request.path.match(%r{\/v(\d+)\/}).try(:[], 1)
    }

    meta[:payload] = @payload || {}
    meta
  end

  def pagination(records)
    {
      pagination: {
        total_pages:   records.total_pages,
        current_page:  records.current_page,
        current_count: records.length,
        limit_value:   records.limit_value
      }
    }
  end
end
