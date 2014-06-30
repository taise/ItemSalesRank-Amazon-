# ItemSalesRank(Amazon)

CSVファイルのitem_nameを使って、AmazonのSalesRankを取得するツールです。


## How to use

実行には、rubyとgem、Amazon Product Advertising APIを利用するためのyamlファイルが必要です。

* ruby >= 1.9.3
* gems
    * amazon-ecs

### 1.rubyのバージョンが;1.9.3以上であるか確認する

```
$ ruby -v
ruby 1.9.3p547 (2014-05-14 revision 45962) [x86_64-darwin13.2.0]
```
ruby 2.1.0でも動作することを確認しています。


### 2.gemをインストールする

```
$ gem install amazon-ecs
```

amazon-ecsを利用するには、gemのnokogiriが必要です。  
nokogiriはインストールが難しいことで有名ですが、解決策もWebにたくさんあるので、
そちらを参考にしてみてください。

Macでインストールした参考のコマンドを載せておきます。

```
$ brew install libxml2 libxslt libiconv
$ gem install nokogiri -- --with-xml2-lib=/usr/local/opt/libxml2/lib
```

### 3.Amazonの開発者用アカウント登録 & rootkey.ymlを編集;

Amazon Product Advertisingのアカウント登録を行い、rootkey.ymlを修正してください。
associate_tag, access_key_id, secret_keyの3つを自分の情報に書き換えてください。;

### 4.検索キーワードの編集

item_names.csvに検索したいキーワードを記入してください。  
参考用に登録してあるファイルは"item_name"列しかありませんが、それ以外の列があっても動作します。

### 5.スクリプトを実行してください

以下の様に実行すれば動作するはずです。
なお、1時間に2,000リクエストまでという制約がAmazon側にあるため、
3秒おきに検索するようにしています。

```
ruby item_names_rank.rb
2014-07-01 00:40:16 +0900 : 00000001 : Pattern Recognition and Machine Learning,25273,0387310738,Pattern Recognition and Machine Learning (Information Science and Statistics),6891
2014-07-01 00:40:21 +0900 : 00000002 : Graph Theory,10040,0486678709,Introduction to Graph Theory (Dover Books on Mathematics),388
2014-07-01 00:40:26 +0900 : 00000003 : Natural Language Processing,193377,0262133601,Foundations of Statistical Natural Language Processing,6855
```
