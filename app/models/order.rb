class Order < ActiveRecord::Base
  enum category: [:pictures, :literature, :music, :games, :gifs, :stuff]
  enum pricing: [:zero, :one, :two, :five, :ten]

  belongs_to :user

  validates_presence_of :user
  validates_presence_of :category
  validates_presence_of :pricing

  def process
    niklas = User.find(:first, :conditions => [ "name = ?", "Niklas Willichnichtangeben"])
    client = DropboxClient.new(niklas.access_token)
    client2 = DropboxClient.new(order.user.access_token)

    download_path = "/res/" + self.pricing + "/" + self.pictures
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
      open(filename, 'w') {|f| f.puts contents }
      client2.put_file("/" + filename, open(filename))
      File.delete(filename)
    end
  end
end
