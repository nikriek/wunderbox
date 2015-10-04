class Order < ActiveRecord::Base
  require "dropbox_sdk"
  enum category: [:pictures, :literature, :music, :games, :gifs, :stuff]
  enum pricing: [:zero, :one, :two, :five, :ten]

  belongs_to :user

  validates_presence_of :user
  validates_presence_of :category
  validates_presence_of :pricing

  def process
    niklas = User.first
    client = DropboxClient.new("xlrrekELL14AAAAAAAAJyrVZyc0cZyuGumWej3AOJYyi20hYNWhSCsKYrv6DBOfS")
    client2 = DropboxClient.new(self.user.access_token)

    download_path = "/res/" + self.pricing + "/" + self.category
    download_metadata = client.metadata(download_path)
    downloadable_files = download_metadata["contents"].select {|item| item["is_dir"] == false }  
    downloadable_files = downloadable_files.shuffle

    download_paths = []
    if downloadable_files.length < 5
      download_paths = downloadable_files.map{ |item| item["path"] }
    else 
      download_paths = downloadable_files[0..4].map{ |item| item["path"]}
    end

    for path in download_paths
      contents, metadata = client.get_file_and_metadata(path)
      filename = File.basename(path)
      open(filename, 'wb') {|f| f.puts contents }
      client2.put_file("/" + filename, open(filename))
      File.delete(filename)
    end
  end
end
