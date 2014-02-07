# encoding: utf-8

##########################
# part helpers


#####
# todo: find a better name for ender_toc_countries ??


def render_toc_countries( countries, opts={} )
  buf = ''
  countries.each do |country|
  
    #<!-- fix: add to models -> countries_w_breweries_or_beers ?? -->
    # <!-- todo: use helper e.g. has_beers_or_breweries? or similar  ?? -->
    regions_count = country.regions.count
    cities_count  = country.cities.count
  
    buf << link_to_country( country, opts )
    buf << " - "
    buf << "_#{regions_count} Regions, #{cities_count} Cities_{:.count}"
    buf << "  <br>"
    buf << "\n"
  end
  buf
end


def render_cities( cities, opts={} )
  buf = ''
  cities.each do |city|
    buf << render_city( city, opts )
  end
  buf
end


def render_city( city, opts={} )
  tmpl       = File.read_utf8( '_templates/shared/_city.md' )
  render_erb_template( tmpl, binding )
end

def render_city_idx( city, opts={} )
  tmpl       = File.read_utf8( '_templates/shared/_city-idx.md' )
  render_erb_template( tmpl, binding )  
end

