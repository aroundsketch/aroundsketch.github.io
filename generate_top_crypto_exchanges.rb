require "fileutils"

source_dir = File.join(__dir__, "assets/img/top-crypto-exchanges")
data_dir = File.join(__dir__, "_data/top-crypto-exchanges")
pages_dir = File.join(__dir__, "pages/top-crypto-exchanges")

unless Dir.exist?(source_dir)
  abort "Source directory not found: #{source_dir}"
end

FileUtils.mkdir_p(data_dir)
FileUtils.mkdir_p(pages_dir)

svg_files = Dir.children(source_dir)
               .select { |file| File.extname(file).downcase == ".svg" }
               .sort

svg_files.each do |file|
  url = File.basename(file, ".svg")
  name = {
    "crypto.com" => "Crypto.com"
  }.fetch(url, url.split(".").first.to_s.capitalize)
  yml_path = File.join(data_dir, "#{url}.yml")
  html_path = File.join(pages_dir, "#{url}.html")
  ser = url.delete(".")

  File.write(yml_path, "- name: #{name}\n  url: #{url}\n")
  puts "+ #{File.basename(yml_path)}"

  File.write(html_path, <<~HTML)
    ---
    layout: cover
    title: #{name}
    description: #{name} Crypto Exchange logo download
    permalink: /top-crypto-exchanges/#{url}/
    ser: #{ser}
    ---
    <div class="container">{% include exchange.html %}</div>
  HTML
  puts "++ #{File.basename(html_path)}"
end

puts "Generated #{svg_files.length} exchange data file#{svg_files.length == 1 ? '' : 's'} and page#{svg_files.length == 1 ? '' : 's'}."
