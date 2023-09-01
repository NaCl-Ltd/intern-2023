module MicropostsHelper
    def linkify_urls(content)
        url_regex = /(http:\/\/|https:\/\/)\S+/
        content.gsub(url_regex) do |url|
            "<a href=\"#{url}\">#{url}</a>"
        end.html_safe
    end
end
