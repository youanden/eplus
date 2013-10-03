require 'httpclient/include_client'
# http ||= http || HTTPClient.new
module QuizletApiHelper
  extend HTTPClient::IncludeClient
  @@root_path  = 'https://quizlet.com'
  @@api_path   = 'https://api.quizlet.com'
  @@api_ver    = '2.0'
  @@client_id  = Rails.application.config.quizlet_client_id
  @@secret_key = Rails.application.config.quizlet_secret_key

  def self.get_response(path, admin)
    http = HTTPClient.new
    # Admin.includes(:api_authorizations).where('api_authorizations.admin_id = ?', 4).pluck(:username, :value)
    quizlet_auth = ApiAuthorization.where(
      admin_id: admin.id,
      name: 'quizlet'
    ).pluck(:value).first
    return false unless quizlet_auth
    get_res = http.get "#{@@api_path}/#{path}", nil, "Authorization" => "Bearer #{quizlet_auth}"
    return JSON.parse get_res.content
  end

  def self.authorization_redirect
    authorization_url = "#{@@root_path}/authorize/"
    state = gen_state(20)
    params = {
      :response_type => 'code',
      :client_id     => @@client_id,
      :scope         => 'read',
      :state         => state
    }
    params = stringify(params)
    return {
      :state    => state,
      :redirect => "#{authorization_url}?#{params}"
    }
  end

  def self.stringify(params)
    return params.collect { |k,v| "#{k}=#{CGI::escape(v.to_s)}" }.join('&')
  end

  def self.gen_state(length)
    o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
    return (0...length).map{ o[rand(o.length)] }.join
  end

  def self.request_token(quizlet_code, admin_id)
    http = HTTPClient.new
    post_data = {
      :grant_type => 'authorization_code',
      :code       => quizlet_code
    }
    authorization_code = Base64.strict_encode64("#{@@client_id}:#{@@secret_key}")

    post_res = http.post "#{@@api_path}/oauth/token", post_data,
      "Authorization" => "Basic #{authorization_code}",
      "Content-Type"  => "application/x-www-form-urlencoded; charset=UTF-8"

    post_res = JSON.parse post_res.content
    access_token = post_res[:access_token]
    aa = ApiAuthorization.where(:admin_id => admin_id, :name => 'quizlet').first
    if aa
      aa.value = access_token
    else
      ApiAuthorization.create!(
        :admin_id => admin_id,
        :name     => 'quizlet',
        :value    => access_token
      )
    end
  end

end
