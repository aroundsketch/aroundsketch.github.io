# create .yml files
Dir.foreach("assets/img/crypto-tokens-logos/") do |file|
  if File.extname(file) == ".svg"
    new_file_name = File.basename(file, ".svg")
    new_service_name = new_file_name.capitalize.split('.').first
    if(File.file?("_data/top-crypto-logos/#{new_file_name}.yml")) 
      puts "= #{new_file_name}.yml"
    else
      File.open("_data/top-crypto-logos/#{new_file_name}.yml", "w") {|f| f.write(
"- name: #{new_service_name}
  url: #{new_file_name}
  tags: #{new_service_name} crypto token"
            )}
      puts "+ #{new_file_name}.yml"
      end
    end
  end

# create .html files
Dir.foreach("_data/top-crypto-logos/") do |filename|
    file_extension = File.extname(filename)
    if file_extension == ".yml"
      file_no_extension = File.basename(filename, ".yml")
      file_title = file_no_extension.capitalize.split('.').first
      file_ser = file_no_extension.tr('.', '')
      # puts file_ser
      if(File.file?("pages/top-crypto-logos/#{file_no_extension}.html")) 
        puts "== #{file_no_extension}.html"
      else
      File.open("pages/top-crypto-logos/#{file_no_extension}.html", "w") {|f| f.write(
"---
layout: cover
title: #{file_title}
description: #{file_title} Service page description
permalink: /top-crypto-logos/#{file_no_extension}/
ser: #{file_ser}
---
<div class="+'"container"'+">{% include token.html %}</div>"
)}
puts "++ #{file_no_extension}.html"
      end
    end
end

# count
dir = '_data/top-crypto-logos'
total = Dir[File.join(dir, '**', '*')].count { |file| File.file?(file) }
File.open("_data/count-crypto.yml", "w") {|f| f.write(
"- name: count
  total: #{total}"
  )}
puts total