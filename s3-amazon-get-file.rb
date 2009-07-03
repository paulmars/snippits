require 'rubygems'
require 'aws/s3'
require 'pp'

include AWS::S3

AWS::S3::Base.establish_connection!(
  :access_key_id     => AWS_KEY,
  :secret_access_key => AWS_SECRET
)

buckets = AWS::S3::Service.buckets

# change
BUCKET = buckets.first # ?
REMOTEFILENAME = "?"

LOCAL_FILE_NAME = 'moth.sql.gz'

open(LOCAL_FILE_NAME, 'w') do |file|
  S3Object.stream(REMOTEFILENAME, BUCKET.name) do |chunk|
    file.write chunk
  end
end