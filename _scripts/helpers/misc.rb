# encoding: utf-8


### todo:
##  add to textutils ?? why? why not??
def number_with_delimiter( num )
  delimiter = '.'
  num.to_s.reverse.gsub( /(\d{3})(?=\d)/, "\\1#{delimiter}").reverse
end



def country_to_md_path( country )

  country_title = country.title.downcase
  country_title = country_title.gsub( /\[[^\]]+\]/, '' ) ## e.g. remove [Mexico] etc.
  country_title = country_title.gsub( 'é', 'e' )  ## todo/fix: use a generic version for accents
  country_title = country_title.strip
  country_title = country_title.gsub(' ', '-')
  country_title = country_title.gsub('-and-', '-n-')

  country_path = ""
  country_path << country.key
  country_path << '-'
  country_path << country_title

  ### quick hack: patch Asia & Australia to => Asia
  # fix: do NOT use sport.db.admin e.g. FIFA continents for beerdb
  if country.key == 'au'
    path = "pacific/#{country_path}.md"
  elsif country.key == 'de'
    # use deutschland NOT germany (same as domain country code)
    path = "europe/de-deutschland.md"  # deutsch/german (de)
  elsif country.key == 'es'
    # use espana NOT spain (same as domain country code)
    path = "europe/es-espana.md"   # spanish/espanol (es)
  elsif country.key == 'ch'
    # use confoederatio helvetica NOT switzerland (same as domain country code)
    path = "europe/ch-confoederatio-helvetica.md" # latin
  elsif country.continent.title == 'Asia & Australia'
    path = "asia/#{country_path}.md"
  else
    path = "#{country.continent.title.downcase.gsub(' ', '-')}/#{country_path}.md"
  end

  path
end
