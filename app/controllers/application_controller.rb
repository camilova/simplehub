class ApplicationController < ActionController::Base

  private

    def send_date(data, options = {})
      if options[:range] == true
        send_data_with_range(data, options)
      else
        super(data, options)
      end
    end

    def send_data_with_range(data, options = {})
      Tempfile.create do |f|
        f.binmode
        f << data
        f.rewind
        if File.exist?(f.path)
          size = File.size(path)
          if !request.headers["Range"]
            status_code = 200 # 200 OK
            offset = 0
            length = File.size(path)
          else
            status_code = 206 # 206 Partial Content
            bytes = Rack::Utils.byte_ranges(request.headers, size)[0]
            offset = bytes.begin
            length = bytes.end - bytes.begin
          end
          response.header["Accept-Ranges"] = "bytes"
          response.header["Content-Range"] = "bytes #{bytes.begin}-#{bytes.end}/#{size}" if bytes
  
          send_data IO.binread(path, length, offset), options
        else
          raise ActionController::MissingFile, "Cannot read file #{path}."
        end
      end
    end
end
