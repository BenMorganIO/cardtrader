module Api
  class Expansion < Api::Client
    EXPORT_PATH = 'expansions/export'

    def self.export = get(EXPORT_PATH)
  end
end
