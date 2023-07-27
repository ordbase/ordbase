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
## 
## ==> saving shroom 186 with hash 3067fa383c71024fc04614b1524d7f13b408839d8f2b18da47db31437b52edaf...
## !! ERROR - no matching hash found
##   is inscribe no. 1075!!
##          4af5d25017a5c71d1333925ea29b79a18d36548597fc4f03e6a23f2d740547c7i0
## ==> saving shroom 196 with hash 5cf2abd9fe6f1878ee29f317d54e2ca2e5a46ad0417edf8c7e19a5edf0bcc818...
## !! ERROR - no matching hash found
##   is inscribe no. 1074!!!
##          2807ac74213d2e9e4b86b7fc121edf7a94c66bc11a8142f851e5d7162d357333i0   


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

## export inscribe ids
meta = []
recs.each do |rec|
  num = rec['num'].to_i(10) 
  hash = rec['hash']

  id = if num == 186
             '4af5d25017a5c71d1333925ea29b79a18d36548597fc4f03e6a23f2d740547c7i0'
       elsif num == 196
             '2807ac74213d2e9e4b86b7fc121edf7a94c66bc11a8142f851e5d7162d357333i0'
       else
             Blob.find_by( sha256: hash ).id
       end   

  meta << [num.to_s, id]
end
pp meta

buf = ''
buf << "num,id\n"
meta.each do |values| 
   buf << values.join(',')
   buf << "\n"
end  
write_text( "./shrooms_inscriptions.csv", buf )



recs.each do |rec|
   num = rec['num'].to_i(10) 
   hash = rec['hash']
   puts "==> saving shroom #{num} with hash #{hash}..."

   ## note: shrooms no. 186 and 196  are NOT in sub1k
   ##     - no. 186 is inscribe no. 1075 @ 4af5d25017a5c71d1333925ea29b79a18d36548597fc4f03e6a23f2d740547c7i0
   ##     - no. 196 is inscribe no. 1074 @ 2807ac74213d2e9e4b86b7fc121edf7a94c66bc11a8142f851e5d7162d357333i0        
   blob = if num == 186
            blob = Blob.new( content: Ordinals.content( '4af5d25017a5c71d1333925ea29b79a18d36548597fc4f03e6a23f2d740547c7i0' ).data )
            puts hash
            puts Digest::SHA256.hexdigest( blob.content )
            blob
          elsif num == 196
            blob = Blob.new( content: Ordinals.content( '2807ac74213d2e9e4b86b7fc121edf7a94c66bc11a8142f851e5d7162d357333i0' ).data )
            puts hash
            puts Digest::SHA256.hexdigest( blob.content )        
            blob   
          else
            Blob.find_by( sha256: hash )
          end   
 
   write_blob( "./i/shroom#{num}.png", blob.content )
end

