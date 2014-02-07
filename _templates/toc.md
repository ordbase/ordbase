# The Free World Fact Book


## Table of Contents

[World Country Tour](#tour) • [A-Z Countries, Regions, Cities](#az)



### World Country Tour
{: #tour}

{{ continents_navbar }}


{% Continent.all.each do |continent| %}


#### {{ continent.title }}
{: #{{ urlify( continent.title ) }} }

  {{ columns_begin( columns: 2 ) }}
  {{ render_toc_countries( continent.countries.order(:title), opts ) }}
  {{ columns_end() }}

{% end %}<!-- each continent -->


### A-Z Countries, Regions, Cities
{: #az}

<!-- fix: for all-in-one page version use/check opts :inline -->
[Countries A-Z Index](countries.html) _({{Country.count}})_{: .count} <br>
[Regions A-Z Index](regions.html) _({{Region.count}})_{: .count} <br>
[Cities A-Z Index](cities.html) _({{City.count}})_{: .count}  <br>
