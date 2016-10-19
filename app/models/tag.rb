class Tag
  include DataMapper::Resource

  # has n, :links
  property :id,   Serial
  property :name, String

end
