

module OrdDb

class CreateDb

def up

ActiveRecord::Schema.define do


=begin
   CREATE TABLE inscribes(
    id varchar NOT NULL PRIMARY KEY, 
    num integer NOT NULL, 
    content_length integer NOT NULL, 
    content_type varchar NOT NULL, 
    date datetime(6) NOT NULL, 
    sat integer NOT NULL, 
    height integer NOT NULL, 
    fee integer NOT NULL, 
    tx varchar NOT NULL, 
    offset integer NOT NULL, 
    address varchar NOT NULL, 

    created_at datetime(6) NOT NULL, 
    updated_at datetime(6) NOT NULL)

  CREATE TABLE blobs(
    id varchar NOT NULL PRIMARY KEY, 
    content blob NOT NULL
    
    created_at datetime(6) NOT NULL, 
    updated_at datetime(6) NOT NULL)
=end



create_table :inscribes, :id => :string do |t|    
    ## "id": "0a3a4dbf6630338bc4df8e36bd081f8f7d2dee9441131cb03a18d43eb4882d5ci0",
    ## note: change to uuid (universally unique id) - why? why not?
    ##        id gets used by row_id (internal orm db machinery) and is int
   ## t.string   :uuid,  null: false, index: { unique: true, name: 'inscribe_uuids' }

   ## "title": "Inscription 10371414",
   ##   note: use num/no. from title only - why? why not?
    t.integer  :num, null: false, index: { unique: true, name: 'inscribe_nums' }
   
    ##  "content length": "85 bytes",
    ## note:  extract bytes as integer!!!
    ##    change to bytes - why? why not?
    t.integer  :bytes, null: false
    ## "content type": "text/plain;charset=utf-8",
    ## note: make sure always lower/down case!!!
    t.string   :content_type, null: false

    ## "timestamp": "2023-06-01 05:00:57 UTC"
    ##   or use date_utc ???
    ##   or change to t.integer AND timestamp  or time or epoch(time) - why? why not?
    t.datetime :date, null: false

    ##
    ## "sat": "967502783701719",
    t.integer    :sat, null: false

    ##
    ## "genesis height": "792337",
    ##   -> change height to block - why? why not?
    ## "genesis fee": "6118",
    ## "genesis transaction": "0a3a4dbf6630338bc4df8e36bd081f8f7d2dee9441131cb03a18d43eb4882d5c",
    ## "offset": "0"
    t.integer    :block, null: false
    t.integer    :fee, null: false
    t.string     :tx, null: false
    t.integer    :offset, null: false 
   
    ###
    ## "address": "bc1p3h4eecuxjj2g72sq38gyva732866u5w29lhxgeqfe6c0sg8xmagsuau63k",
    ##    is this minter/inscriber addr??? 
    t.string     :address, null: false

    ## "output": "0a3a4dbf6630338bc4df8e36bd081f8f7d2dee9441131cb03a18d43eb4882d5c:0",
    ##  "output value": "546",
    t.string   :output, null: false
    t.integer  :value,  null: false

    ## -- ignore for now - why? why not?
    ##   what is location  ???
    ## "location": "0a3a4dbf6630338bc4df8e36bd081f8f7d2dee9441131cb03a18d43eb4882d5c:0:0",

  ## timestamp last
  t.timestamps
end


create_table :blobs, :id => :string do |t|
    ## "id": "0a3a4dbf6630338bc4df8e36bd081f8f7d2dee9441131cb03a18d43eb4882d5ci0",
    ## note: change to uuid (universally unique id) - why? why not?
    ##        id gets used by row_id (internal orm db machinery) and is int
    ## t.string   :id,  null: false, index: { unique: true, name: 'blob_uuids' }
 
    t.binary     :content,   null: false
    t.string     :sha256   ## sha256 hash as hexstring
    t.string     :md5      ## md5 hash as hexstring - add why? why not?  

  ## timestamp last
  t.timestamps
end


=begin
 "name": "Planetary Ordinals",
  "inscription_icon": "98da33abe2045ec1421fcf1bc376dea5beb17ded15aa70ca5da490f50d95a6d9i0",
  "supply": "69",
  "slug": "planetary-ordinals",
  "description": "",
  "twitter_link": "https://twitter.com/ordinalswallet",
  "discord_link": "https://discord.com/invite/ordinalswallet",
  "website_link": ""
=end

create_table :collections do |t|
  t.string   :name, null: false
  t.string   :slug   
  t.text     :desc    # description
  t.integer  :max     # supply
  t.string   :icon_id    ## rename to inscribe_icon_id or such - why? why not?
  ## add twitter_link, discord_link, website_link - why? why not?

  ## if on-chain and metadata inscribed - add why? why not??
  ## t.string   :source_id,  null: false   ## foreign key reference

  ## timestamp last
  t.timestamps
end

create_table :items do |t|
  t.integer   :collection_id, null: false
  t.string    :inscribe_id,   null: false
  t.integer   :pos,           null: false
  t.string    :name

  ## timestamp last
  t.timestamps

  ## todo/fix: add unique index for :pos+:collection_id !!!
end



###
#  generative (collection) factory
create_table :factories, :id => :string do |t|
  t.string   :name
  t.integer  :max        # max limit
  t.integer  :maxblock   # max block limit
  t.string   :dim        # dimension e.g. 24x24 (in px)

  t.string   :inscribe_id,  null: false   ## foreign key reference

  ## timestamp last
  t.timestamps
end

#####
## join table (factory has_many modules)
##   rename to layer / sprites / blocks / tiles / modules / submodules / subs / mods / ...etc - why? why not?
##             layerlists or inscribelists or ???
##  change/rename to factory_items or layer_items or such?
create_table :inscriberefs, :id => false do |t|
  t.string  :factory_id,    null: false
  t.string  :inscribe_id,   null: false
  t.integer :pos,           null: false    ## position (index) in list (starting at 0)
  ## todo/fix: make factory_id + inscribe_id + pos unique index - why? why not?

  ## timestamp last
  t.timestamps
end


create_table :generatives, :id => :string do |t|
  t.string  :factory_id,    null: false
  t.string  :g,             null: false  ##  use space separated numbers - why? why not?    
  t.binary  :content    ### optional for now - why? why not?
 
  ## timestamp last
  t.timestamps
end




end # block Schema.define

end # method up
end # class CreateDb
  
end # module OrdDb
