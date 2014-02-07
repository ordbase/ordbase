# encoding: utf-8

##########################
# page helpers


def render_country( country, opts={} )
  tmpl       = File.read_utf8( '_templates/country.md' )
  text = ''
  text << opts[:frontmatter]  if opts[:frontmatter]
  text << render_erb_template( tmpl, binding )
  text
end

def render_toc( opts={} )
  tmpl = File.read_utf8( '_templates/toc.md' )
  text = ''
  text << opts[:frontmatter]  if opts[:frontmatter]
  text << render_erb_template( tmpl, binding )
  text
end


def render_cities_idx( opts={} )
  tmpl = File.read_utf8( '_templates/cities-idx.md' )
  text = ''
  text << opts[:frontmatter]  if opts[:frontmatter]
  text << render_erb_template( tmpl, binding )
  text
end

