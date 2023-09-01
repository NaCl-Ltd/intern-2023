def add_query_params(url)
  uri = URI.parse(url)
  params = [["locale", "en"]]
  query = URI.decode_www_form(uri.query || '') + params
  uri.query = URI.encode_www_form(query)
  uri.to_s
end
