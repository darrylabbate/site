require 'slim'

activate :livereload

set :livereload_css_target, 'css/style.css'

activate :autoprefixer do |prefix|
  prefix.browsers = "last 2 versions"
  prefix.inline = true
end

activate :blog do |blog|
  blog.layout = "post"
  blog.permalink = "{permalink}"
  blog.sources = "posts/{year}-{month}-{day}-{title}.html"
end

activate :directory_indexes

# Per-page layout changes
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false


configure :build do
  activate :minify_css
  activate :minify_html
  activate :minify_javascript
end

set :markdown_engine, :redcarpet
set :markdown, :fenced_code_blocks => true, :smartypants => true

activate :syntax

set :css_dir, 'css'
set :source, 'src'
