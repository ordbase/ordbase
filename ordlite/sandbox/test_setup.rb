####
# to run use:
#   $ ruby -I ./lib sandbox/test_setup.rb

require 'ordlite'



OrdDb.setup_in_memory_db



b1 = Blob.create( id: 'id123', content: 'c123')
b2 = Blob.create( id: 'id999', content: 'c999')

i1 = Inscribe.create( id: 'id999', 
                      num: 999,
                      bytes: 444,
                      content_type: 'text',
                      date: Time.now,
                      sat: 967502783701719,
                      block: 792337,
                      fee: 6118,
                      tx: '0a3a4dbf6630338bc4df8e36bd081f8f7d2dee9441131cb03a18d43eb4882d5c',
                      offset: 0,
                      address: 'bc1p3h4eecuxjj2g72sq38gyva732866u5w29lhxgeqfe6c0sg8xmagsuau63k',
                      value: 546,
                      output: '0a3a4dbf6630338bc4df8e36bd081f8f7d2dee9441131cb03a18d43eb4882d5c:0',
)  

i2 = Inscribe.create( id: 'i2', 
                      num: 2,
                      bytes: 444,
                      content_type: 'text',
                      date: Time.now,
                      sat: 967502783701719,
                      block: 792337,
                      fee: 6118,
                      tx: '0a3a4dbf6630338bc4df8e36bd081f8f7d2dee9441131cb03a18d43eb4882d5c',
                      offset: 0,
                      address: 'bc1p3h4eecuxjj2g72sq38gyva732866u5w29lhxgeqfe6c0sg8xmagsuau63k',
                      value: 546,
                      output: '0a3a4dbf6630338bc4df8e36bd081f8f7d2dee9441131cb03a18d43eb4882d5c:0',
)  

i3 = Inscribe.create( id: 'i3', 
                      num: 3,
                      bytes: 444,
                      content_type: 'text',
                      date: Time.now,
                      sat: 967502783701719,
                      block: 792337,
                      fee: 6118,
                      tx: '0a3a4dbf6630338bc4df8e36bd081f8f7d2dee9441131cb03a18d43eb4882d5c',
                      offset: 0,
                      address: 'bc1p3h4eecuxjj2g72sq38gyva732866u5w29lhxgeqfe6c0sg8xmagsuau63k',
                      value: 546,
                      output: '0a3a4dbf6630338bc4df8e36bd081f8f7d2dee9441131cb03a18d43eb4882d5c:0',
)  



f1 = Factory.create( id: 'punks',
                        inscribe: i1,
                        max: 721,
                        name: 'Punks' )

pp f1
puts "inscribe:"                        
pp f1.inscribe
puts "collection:"
pp f1.inscribe.factory                        

## add layers via inscribrefs (note: requires pos(ition) / index - 0,1,2, etc.)
f1.inscriberefs.create( pos: 0, inscribe: i2 )
f1.inscriberefs.create( pos: 1, inscribe: i3 )

puts "layers:"
pp f1.layers



puts i1.blob.content
puts i1.blob.id
puts i1.blob.inscribe.id

puts b2.inscribe.num
puts b2.inscribe.block
puts b2.inscribe.content_type


b3 = Blob.create( id: 'id3', content: 'c99999')



puts
c1 = Collection.create( name: 'Punks', max: 100 )
pp c1
puts c1.items.count
puts c1.inscribes.count

c1.items.create( pos: 0, inscribe: i2, name: 'Punk #1' )
c1.items.create( pos: 1, inscribe: i3, name: 'Punk #2' )
puts c1.items.count
puts c1.inscribes.count

puts
pp c1.items.first


puts "bye"