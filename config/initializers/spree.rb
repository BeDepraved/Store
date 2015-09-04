Spree.config do |config|
  # Example:
  # Uncomment to override the default site name.
  #  config.site_name = "Gazella Running Costumes"
  #  config.logo = "store/rungazella.png"

  #S3 configuration
  if Rails.env.production? true
    # production. Store images on S3.
    # development will default to local storage
    attachment_config = {
      s3_credentials: {
        access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
        secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
        bucket:            ENV['S3_BUCKET_NAME']
        },

      storage:        :s3,
      s3_headers:     { "Cache-Control" => "max-age=31557600" },
      s3_protocol:    "https",
      bucket:         ENV['S3_BUCKET_NAME'],
      url:            ":s3_domain_url",

      path:           "/:class/:id/:style/:basename.:extension",
      default_url:    "/:class/:id/:style/:basename.:extension",
      default_style:  "product"
      }

    attachment_config.each do |key, value|
      Spree::Image.attachment_definitions[:attachment][key.to_sym] = value
    end
  end
  Spree.user_class = "Spree::User"
end