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
    opts = meta.delete(:opts)

    {
      meta: default_meta.merge(pagination(records)).merge(meta),
      data: records.map { |record| entities_record(record, entities_class, opts) }
    }
  end

  def data_record!(record, entities_class, meta = {})
    opts = meta.delete(:opts)

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

    if sign_grape?
      meta[:payload] = @payload || {}
      meta[:menu]    = page_menu
    end

    meta
  end

  def sign_grape?
    defined? current_user
  end

  # rubocop:disable Metrics/AbcSize
  def page_menu
    return [] unless current_user

    menu = [{ name: '借款申请预审', level: 0, detail: [] }, { name: '借款申请复审', level: 0, detail: [] }]

    if current_user.bs?
      menu[0][:detail].push(name: '业务审核', level: 1, url: '/v1/apply_mains', badge: ApplyMain.status_not_review.count)
      menu[1][:detail].push(name: '业务审核', level: 1, url: '/v1/apply_mains/check', badge: ApplyMain.scope_need_bs_check.count)
    end

    if current_user.rc?
      menu[0][:detail].push(name: '风控审核', level: 1, url: '/v1/apply_mains/rc', badge: ApplyMain.status_bs_review_accept.count)
      menu[1][:detail].push(name: '风控审核', level: 1, url: '/v1/apply_mains/check/rc', badge: ApplyMain.status_bs_check_accept.count)
    end

    menu
  end

  # rubocop:enable Metrics/AbcSize

  def pagination(records)
    {
      pagination: {
        total_pages:   records.total_pages,
        current_page:  records.current_page,
        current_count: records.length,
        # total_count: records.total_count,
        # prev_page:  records.prev_page,
        # next_page:  records.next_page
      }
    }
  end
end
