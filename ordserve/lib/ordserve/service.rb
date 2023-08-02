
# todo/check: find a better name?
class Ordserve < Sinatra::Base

  set :public_folder, Dir.pwd  ## use current working directory 
  set :static, true

  get '/' do
    erb :index
  end

  get '/samples/:name.svg' do
    name = params['name']
    headers( 'Content-Type' => "image/svg+xml" )

    path = "#{Ordinals::Module::Ordserve.root}/samples/#{name}.svg"
  
    blob = read_blob( path )
    puts "     #{blob.size} byte(s)"
    blob
  end 

  get '/content/:id' do
    id = params['id']
    content_dir = settings.content_folder
    path = "#{content_dir}/#{id}"
    if File.exist?( path )
      puts "  serving local content blob >#{path}<..."
      headers( 'Content-Type' => "application/octet-stream" )

      blob = read_blob( path )
      puts "     #{blob.size} byte(s)"
      blob
    else
      ## download first
      content = Ordinals.content( id )
      write_blob( path, content.data )
      content.data
    end
  end
end    # class Ordserve
