# 当 400 错误时(404 除外), 返回信息的构建规则
# 1. 应该优先根据 HTTP status code 来判断请求状态,
# 2. response 的格式为, {meta: {status: <code>}, errors: []/{}}
# 3. meta 中会返回字段 status, 只有当需要显示 message 时, 才需要根据该字段确认 errors 的格式
#
# 说明:
# - 401 验证错误 example {meta: {staus: 401},
#                        errors: {type: 'Svc::ParamsSignature::SignError', message: 'incomplete parameters'}}
# - 422 验证错误 example {meta: {status: 406, type: 'ActiveModel::Errors', base_object: {type: 'User', id: '1'}},
#                        errors: [{filed: 'email', message: '格式不正确'}, {field: 'passwd', message: '密码格式不正确'}]}
# - 422 其他错误 example {meta: {staus: 422}, errors: {message: 'incomplete parameters'}}, 可以通过 meta[:type] 来区分
# rubocop:disable Lint/Void, Naming/UncommunicativeMethodParamName
module ErrorHelper
  def auth_error!(e, meta = {})
    meta[:status] ||= 401
    error!(error_message(e, meta), meta[:status])
  end

  def permit_error!(e, meta = {})
    meta[:status] ||= 403
    error!(error_message(e, meta), meta[:status])
  end

  def valid_error!(e, meta = {})
    meta[:status] ||= 406
    error!(error_message(e, meta), meta[:status])
  end

  def error_422!(message, meta = {})
    meta[:status] ||= 422
    error!(error_message(message, meta), meta[:status])
  end

  private

  def error_desc(e)
    e.is_a?(Hash) ? {} : { type: e.class.to_s, message: e.message }
  end

  def error_meta(e)
    meta               = default_meta
    base_object        = e.instance_variable_get(:@base)
    meta[:base_object] = { type: base_object.class, id: base_object.id } if base_object
    meta[:message]     = meta_error_message(e)
    meta[:type]        = e.class.to_s
    meta
  end

  def meta_error_message(e)
    message =
      if e.respond_to?(:full_messages)
        e.send(:full_messages)
      elsif e.respond_to?(:message)
        e.message
      else
        e
      end

    message.is_a?(Array) ? message.join(', ') : message
  end

  def error_message(e, meta)
    errors =
      case e
      when ActiveModel::Errors
        e.messages.map.each { |key, message| { field: key, message: message } }
      when Grape::Exceptions::ValidationErrors
        e.errors.map.each { |field, messages| { field: field.first, message: messages.map(&:message).join(',') } }
      end

    { meta: error_meta(e).merge!(meta), errors: errors }
  end
end
# rubocop:enable Lint/Void, Naming/UncommunicativeMethodParamName
