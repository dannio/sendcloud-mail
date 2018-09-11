require 'digest'
require 'rest-client'
require 'json'
require 'yaml'

module SendCloud
  class Mail

    def self.load!(file, environment)
      config = YAML.load_file(file)
      self.auth(config[environment.to_s]['mail_api_user'], config[environment.to_s]['mail_api_key'])
    end

    def self.auth(mail_api_user, mail_api_key)
      @mail_api_user = mail_api_user
      @mail_api_key = mail_api_key
    end

    def self.send(from, fromName, subject, xsmtpapi, content, summary=nil)
      # xsmtpapi comes in the following format:
      #{
      #  "to": ["d@163.com",'i@163.com'],
      #  "sub": {
      #      "%content%": ['nihao0', 'nihao1']
      #  }
      #}
      response = RestClient.post 'https://api.sendcloud.net/apiv2/mail/send?',
                                 apiUser: @mail_api_user,
                                 apiKey: @mail_api_key,
                                 from: from,
                                 fromName: fromName,
                                 xsmtpapi: xsmtpapi.to_json,
                                 subject: subject,
                                 html: content,
                                 contentSummary: summary
      JSON.parse(response.to_s)['statusCode']
    end

    def self.send_template(invokeName, from, fromName, subject, xsmtpapi, summary=nil)
      # xsmtpapi comes in the following format:
      #{
      #  "to": ["d@163.com",'i@163.com'],
      #  "sub": {
      #      "%content%": ['nihao0', 'nihao1']
      #  }
      #}
      response = RestClient.post 'https://api.sendcloud.net/apiv2/mail/sendtemplate?',
                                 apiUser: @mail_api_user,
                                 apiKey: @mail_api_key,
                                 from: from,
                                 fromName: fromName,
                                 xsmtpapi: xsmtpapi.to_json,
                                 subject: subject,
                                 templateInvokeName: invokeName,
                                 contentSummary: summary
      JSON.parse(response.to_s)['statusCode']
    end

    def self.get(invokeName)
      params = {
        apiUser: @mail_api_user,
        apiKey: @mail_api_key,
        invokeName: invokeName,
      }
      response = RestClient.get 'https://api.sendcloud.net/apiv2/template/get?', params: params
      JSON.parse(response.to_s)
    end

    def self.list
      params = {
        apiUser: @mail_api_user,
        apiKey: @mail_api_key
      }
      response = RestClient.get 'https://api.sendcloud.net/apiv2/template/list?', params: params
      JSON.parse(response.to_s)
    end

    def self.create(invokeName, name, html, subject, templateType)
      response = RestClient.post 'http://api.sendcloud.net/apiv2/template/add?',
                                  apiUser: @mail_api_user,
                                  apiKey: @mail_api_key,
                                  invokeName: invokeName,
                                  name: name,
                                  html: html,
                                  subject: subject,
                                  templateType: templateType

      JSON.parse(response.to_s)
    end

    def self.update(invokeName, name, html, subject, templateType)
      response = RestClient.post 'https://api.sendcloud.net/apiv2/template/update?',
                                  apiUser: @mail_api_user,
                                  apiKey: @mail_api_key,
                                  invokeName: invokeName,
                                  name: name,
                                  html: html,
                                  subject: subject,
                                  templateType: templateType
      JSON.parse(response.to_s)['statusCode']
    end

    def self.delete(invokeName)
      response = RestClient.post 'https://api.sendcloud.net/apiv2/template/delete?',
                                  apiUser: @mail_api_user,
                                  apiKey: @mail_api_key,
                                  invokeName: invokeName
      JSON.parse(response.to_s)['statusCode']
    end

  end
end