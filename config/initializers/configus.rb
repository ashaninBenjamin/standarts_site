Configus.build Rails.env do
  env :production do
    carrierwave do
      storage :fog
    end
  end

  env :development do
    carrierwave do
      storage :file
    end
  end

  env :test, parent: :development do
  end
end