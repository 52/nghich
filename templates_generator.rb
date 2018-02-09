# Script to generate template for categories and tags
# Run this script before push to github everytime you create a new post
# or change categories, tags of a post

def generate_template_for type

  # scrape tags from YAML front matter in posts
  yaml_tag = "#{pluralize(type)}:"
  items = []

  Dir.glob("_posts/*") do |file_name|
    File.open(file_name, 'r') do |file|
      while line = file.gets
        break if line.start_with?(yaml_tag)
      end
      items += line[yaml_tag.length..-1].downcase.split(' ') unless line.nil?
    end
  end

  items.uniq!

  Dir.mkdir type unless Dir.exist? type

  # delete unused template files
  Dir.glob("#{type}/*") do |file_name|
    # look behind for "#{type}/"
    # look ahead for ".md"
    item = file_name.match /(?<=#{type}\/)[\w-]+(?=\.md)/

    File.delete file_name unless items.include? item
  end

  # create template files and polulate them with YAML front matter
  items.each do |item|
    front_matter = <<EOF
---
layout: #{type}
#{type}: #{item}
title: #{item}
---
EOF
    
    template_path = "./#{type}/#{item}.md"
    unless FileTest.exist? template_path
      File.open(template_path, 'w') do |file|
        file.puts front_matter
      end
    end
  end
end

# shitty pluralize function
def pluralize noun
  return "categories" if noun == "category"
  "#{noun}s"
end

generate_template_for "category"
generate_template_for "tag"