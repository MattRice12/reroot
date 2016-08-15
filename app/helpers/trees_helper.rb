module TreesHelper
  def url_with_protocol(url)
    /^http/i.match(url) ? url : "http://#{url}"
    # if /^http/i.match(url)
    #   url
    # else
    #   "http://#{url}"
  end
end
