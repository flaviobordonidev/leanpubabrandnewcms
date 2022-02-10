# Gestiamo i files CSV tramite Amazon S3

Il servizio S3 è la parte storage dei servizi web di Amazon (Amazon Web Service - AWS).

gli upload ed i download dei files su Amazon S3 tramite rails è meglio gestirli con una gemma specifica tipo:

* refile
* carrierwave
* paperclip
* dragonfly
* shrine

Noi abbiamo scelto di usare paperclip ma vanno bene tutti quanti.





## Implementiamo Amazon S3

* https://www.sitepoint.com/uploading-files-with-paperclip/
* https://devcenter.heroku.com/articles/paperclip-s3
* http://stackoverflow.com/questions/32919273/access-denied-s3-with-paperclip
* https://github.com/thoughtbot/paperclip/wiki/Paperclip-with-Amazon-S3
* http://rexstjohn.com/how-to-solve-access-denied-with-heroku-paperclip-s3-ror/
* https://console.aws.amazon.com/iam/home#users/botpaperclip

1. installiamo gem 'aws-sdk', '~> 2.3'
2. Per accesso da development
    # config/environments/development
    config.paperclip_defaults = {
      storage: :s3,
      s3_credentials: {
        bucket: 'flapaperclip',
        access_key_id: 'AKIAJJ55RPPRPGHJTOMA',
        secret_access_key: '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',
        s3_region: 'eu-central-1'
      }
    }
3. Crea-account/login su AWS S3. -> click su S3 -> click su create bucket 
  su proprietà vedi il nome del bucket
  ed il region nella metà dello Static Website Hosting -> Endpoint
4. Crea uno IAM user e prendi
  - access_key_id
  - secret_access_key
  Inoltre su User -> Permission -> Attach Policy --> AmazonS3FullAccess






We’ll also need to specify the AWS configuration variables for the production Environment.
# config/environments/production.rb
config.paperclip_defaults = {
  storage: :s3,
  s3_credentials: {
    bucket: ENV.fetch('S3_BUCKET_NAME'),
    access_key_id: ENV.fetch('AWS_ACCESS_KEY_ID'),
    secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY'),
    s3_region: ENV.fetch('AWS_REGION'),
  }
}










