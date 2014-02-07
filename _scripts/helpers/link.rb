###############################
# link helpers


def link_to_country( country, opts={} )
  if opts[:inline].nil?
    # multi-page version
    link_to "#{country.title} (#{country.code})", "#{country.key}.html"
  else
    # all-in-one page version
    link_to "#{country.title} (#{country.code})", "##{country.key}"
  end
end


