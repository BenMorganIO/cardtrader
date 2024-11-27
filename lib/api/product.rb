module Api
  class Product < Api::Client
    EXPORT_PATH = "products/export"

    def self.export(query)
      get(EXPORT_PATH, query)
    end
  end
end
