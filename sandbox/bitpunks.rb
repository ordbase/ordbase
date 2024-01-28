
$LOAD_PATH.unshift( "../rubycocos/webclient/webclient/lib" )
require 'cocos'

hash = '19745c8c592817a1f7abe990fe4d5e1bbc1f9dd13553912d4d06b5de22ca7ac4'
hash = '19745c8c592817a1f7abe990fe4d5e1bbc1f9dd13553912d4d06b5de22ca7acb'


## url-encoded
q = "searchAll=true&area=&inscriptionNo=&inscription=&address=&protocol=&text=&hash=#{hash}"


# https://bitpunks.love:3313/Utility/Inscriptions
# Request Method:
# POST

puts q


url = 'https://bitpunks.love:3313/Utility/Inscriptions'

form = {
    searchAll: true,
    area: '',
    inscriptionNo: '',
    inscription: '',
    address: '',
    protocol: '',
    text: '',
    hash: hash
}

res = Webclient.post( url, form: form )
pp res

pp res.json

puts res.status.code       #=> 200
puts res.status.message    #=> OK
puts res.status.ok?


puts "bye"


__END__

[{"InscriptionNo"=>"52615493",
  "Inscription"=>"a6df26b9a9bf4929a462370b55be0b253abaecdce23233b79041d262dfa46186i0",
  "ContentType"=>"image/png",
  "ContentProtocol"=>"1"}]

[]
200