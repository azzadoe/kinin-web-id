module Jekyll
  class SpeedBooster < Generator
    priority :lowest
    def generate(site)
      site.pages.each do |page|
        optimize_html(page)
      end
    end

    def optimize_html(page)
      return unless page.output_ext == ".html"
      
      # Minifikasi HTML
      page.output = minify_html(page.output)
      
      # Lazy load semua gambar
      page.output = lazy_load_images(page.output)
    end

    def minify_html(html)
      html.gsub(/\n+/, "").gsub(/\s{2,}/, " ")
    end

    def lazy_load_images(html)
      html.gsub(/<img(.*?)>/, '<img\1 loading="lazy">')
    end
  end
end
