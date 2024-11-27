require 'csv'
require 'fileutils'
require 'json'
require 'net/http'

require_relative 'api/client'
require_relative 'api/expansion'
require_relative 'api/product'

class Trader
  CSV_HEADERS = %w[
    Set Number Name Rarity Condition Foil Lang Signed Altered QTY Price Description
  ].freeze

  def self.expansions
    @expansions ||= Api::Expansion.export
  end

  def self.export_csv
    timestamp = Time.now.strftime("%Y%m%d%H%M%S")

    FileUtils.mkdir_p './tmp'
    CSV.open("./tmp/#{timestamp}_export.csv", 'wb') do |csv|
      csv << CSV_HEADERS

      expansions.map do |expansion|
        Api::Product
          .export(expansion_id: expansion['id'])
          .sort_by do |product|
            props = product['properties_hash']

            [
              rarity_sort(props['mtg_rarity']),
              props['collector_number'].to_i
            ]
          end
          .each do |product|
            props = product['properties_hash']

            csv << [
              expansion['code'],
              props['collector_number'],
              product['name_en'],
              props['mtg_rarity'],
              props['condition'],
              props['mtg_foil'] ? 'foil' : nil,
              props['mtg_language'],
              props['signed'] ? 'signed' : nil,
              props['altered'] ? 'altered' : nil,
              product['quantity'],
              "$#{product['price_cents'] * 0.01}",
              product['description']
            ]
          end
      end
    end

    true
  end

  def self.rarity_sort(rarity)
    case rarity
    when 'Common'   then 1
    when 'Uncommon' then 2
    when 'Rare'     then 3
    when 'Mythic'   then 4
    else 0
    end
  end
end
