require 'csv'

namespace :import_csv do
  desc "CSVデータをインポートするタスク"

  task users: :environment do
    path = "db/csv_data/csv_data.csv"
    list = []
    CSV.foreach(path, headers: true) do |row|
      list << row.to_h
    end
    puts "インポート処理を開始"
    begin
      User.transaction do
        User.create!(list)
      end
      puts "インポートインポート完了!".green

    rescue StandardError => e
      puts "#{e.class}: #{e.message}"
      puts "-------------------------"
      puts e.backtrace # 例外が発生した位置情報
      puts "-------------------------"
      puts "インポートに失敗".red
    end
  end
end

