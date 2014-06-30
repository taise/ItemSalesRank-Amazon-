require 'amazon/ecs'
require 'yaml'

module Amazon
  class ItemSalesRank

    attr_accessor :results
    def initialize(rootkey = 'rootkey.yml')
      @config = YAML.load_file(rootkey)
      Amazon::Ecs.options = {
        :associate_tag     => @config['AWS']['AssociateTag'],
        :AWS_access_key_id => @config['AWS']['AccessKeyId'],
        :AWS_secret_key    => @config['AWS']['SecretKey']
      }
    end

    def search_options
      {
        search_index: 'All',
        response_group: 'ItemAttributes,OfferSummary,Medium',
        country: 'us',
      }
    end

    def info_hash(item)
      if item
        offer_summary = item.get_element('OfferSummary')
        price = if offer_summary.nil?
                  -1
                else
                  offer_summary.get_unescaped('LowestNewPrice/Amount').to_i
                end
        {
          salesrank: item.get('SalesRank').to_i,
          asin:      item.get('ASIN'),
          title:     item.get('ItemAttributes/Title'),
          price:     price
        }
      else 
        {
          salesrank: -1,
          asin:      "",
          title:     "",
          price:     -1
        }
      end
    end

    def search(keyword)
      @results = Amazon::Ecs.item_search(keyword, search_options)
      item = @results.items.first
      info_hash(item)
    end
  end
end

if __FILE__ == $0
  keyword = ARGV[0] || 'iPod touch'
  rootkey = ARGV[1] || 'rootkey.yml'
  item_salesrank = Amazon::ItemSalesRank.new(rootkey)
  puts item_salesrank.search(keyword)
end
