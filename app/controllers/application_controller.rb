class ApplicationController < ActionController::Base
  AVAILABLE_LANGUAGES = [:en, :es]
  before_action :set_locale

  private

    def send_data(data, options = {})
      options.merge! filename: (@source.title.presence || 'covid_hub_resource')
      if options[:range]
        options[:range] = false
        send_data_with_range(data, options)
      else
        super(data, options)
      end
    end

    def send_data_with_range(data, options = {})
      require 'stringio'
      return head(:internal_server_error) if data.nil?
      io = StringIO.new(data)
      size = io.size
      if ! request.headers["Range"]
        status_code = 200 # 200 OK
        offset = 0
        length = size
      else
        status_code = 206 # 206 Partial Content
        bytes = Rack::Utils.byte_ranges(request.headers, size)[0]
        offset = bytes.begin
        length = bytes.end - bytes.begin
      end
      response.header["Accept-Ranges"] = "bytes"
      response.header["Content-Range"] = "bytes #{bytes.begin}-#{bytes.end}/#{size}" if bytes
      io.pos = offset
      send_data io.read(length), options
    end

    def set_locale
      header_language = extract_locale_from_accept_language_header
      I18n.locale = header_language || I18n.default_locale
    end

    # Extract language from request header
    def extract_locale_from_accept_language_header
      if request.env['HTTP_ACCEPT_LANGUAGE']
        lg = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first.to_sym
        lg.in?(AVAILABLE_LANGUAGES) ? lg : nil
      end
    end
end
