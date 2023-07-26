$LOAD_PATH.unshift( "../ordlite/lib" )
require 'ordlite'


OrdDb.open( './ordsub1k.db' )

=begin
class AddHash < ActiveRecord::Migration[7.0]
   def up
        change_table :blobs do |t|
          t.string :sha256
        end
    end
end
AddHash.new.up
=end

###
### check range -  675 - 1075  
###   up-to 1075???
##
###  ==> saving shroom 186 with hash 3067fa383c71024fc04614b1524d7f13b408839d8f2b18da47db31437b52edaf...
##  sub1k_shrooms.rb:48:in `block in <main>': undefined method `inscribe' for nil:NilClass (NoMethodError)
##  shroom 186 not found is not in sub1k??

=begin
inscribes = Inscribe.png.to_a
puts "  #{inscribes.size} .PNG inscribe(s)"

inscribes.each_with_index do |rec, i|
    puts "==> #{i+1}/#{inscribes.size}  no.#{rec.num} (#{rec.content_type} - #{rec.bytes} bytes)..."
    if rec.bytes != rec.content.bytesize
        puts "!! ERROR - bytes mismatch - blob corrupt?"
        exit 1
    end
    hex = Digest::SHA256.hexdigest( rec.content )
    puts hex 
    rec.blob.sha256 = hex
    rec.blob.save
end
=end

## read inscription №105 converted "by hand" to .csv datafile
recs = read_csv( './shrooms.csv')  

recs.each do |rec|
   num = rec['num'].to_i(10) 
   hash = rec['hash']
   puts "==> saving shroom #{num} with hash #{hash}..."

   blob = Blob.find_by( sha256: hash )
   inscribe = blob.inscribe
   if inscribe.content_type != 'image/png'
     puts "!! ERROR - wrong content type; expect image/png got:"
     pp inscribe
     exit 1
   end
   write_blob( "./i/shroom#{num}.png", inscribe.content )
end

