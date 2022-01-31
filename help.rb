Dir.foreach("assets/img/crypto-tokens-logos/") do |file|
    if File.extname(file) == ".svg"
      new_file_name = File.basename(file, ".svg")
      new_service_name = new_file_name.capitalize.split('.').first
      File.open("_data/top-crypto-logos/#{new_file_name}.yml", "w") {|f| f.write(
"- name: #{new_service_name}
  url: #{new_file_name}
  tags: #{new_service_name} crypto token"
    )}
      end
  end

Dir.foreach("_data/top-crypto-logos/") do |filename|
    file_extension = File.extname(filename)
    if file_extension == ".yml"
      file_no_extension = File.basename(filename, ".yml")
      file_title = file_no_extension.capitalize.split('.').first
      file_ser = file_no_extension.tr('.', '')
      # puts file_ser
      File.open("pages/top-crypto-logos/#{file_no_extension}.html", "w") {|f| f.write(
"---
layout: cover
title: #{file_title}
description: #{file_title} Service page description
permalink: /top-crypto-logos/#{file_no_extension}/
ser: #{file_ser}
---
<div class="+'"container"'+">{% include token.html %}</div>
"
  )}
    end
end