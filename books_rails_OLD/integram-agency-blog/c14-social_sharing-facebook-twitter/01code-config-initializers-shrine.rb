  # require "shrine"
  # require "shrine/storage/file_system"
  
  # Shrine.storages = {
  #   cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"), # temporary
  #   store: Shrine::Storage::FileSystem.new("public", prefix: "uploads/store"), # permanent
  # }
  
  # Shrine.plugin :activerecord
  # Shrine.plugin :cached_attachment_data # for forms

require "shrine/storage/s3"

s3_options = {
  access_key_id:       'AKIAJ5Y7LYS2TEBNE26A',
  secret_access_key:   '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',
  bucket:              'brandnewcms-dev',
  region:              'eu-central-1',
  #s3_host_name:       's3.eu-central-1.amazonaws.com',
}


# The S3 storage plugin handles uploads to Amazon S3 service, using the aws-sdk gem.
Shrine.storages = {
  cache: Shrine::Storage::S3.new(prefix: "cache", upload_options: { acl: 'public-read' }, **s3_options),
  store: Shrine::Storage::S3.new(prefix: "store", upload_options: { acl: 'public-read' }, **s3_options),
}

Shrine.plugin :activerecord
#Shrine.plugin :direct_upload
Shrine.plugin :presign_endpoint
Shrine.plugin :restore_cached_data
