require 'csv'
require './amazon/item_salesrank'


base_dir = "./"
items = "item_names.csv"
items_rank = "item_salesrank.csv"
target   = File.join(base_dir, items)
extended = File.join(base_dir, items_rank)

item_salesrank = Amazon::ItemSalesRank.new


# Amazon Product Advertising API allows to only 2,000 requests
# per 1 hour for each free user.

c = 0
open(extended, "w") do |f|
  CSV.foreach(target, {headers: true}) do |line|
    c += 1
    item = item_salesrank.search(line['item_name']).values
    amazon_info = line.to_hash.values.concat(item)
    puts "#{Time.now} : #{'%08d' % c} : #{amazon_info.join(",")}"
    f.puts amazon_info.to_ary.to_csv
    sleep 3;
  end
end
