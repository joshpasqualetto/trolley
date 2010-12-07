require File.join(File.dirname(__FILE__), "..", "..", "config", "environment")

namespace :convert do
  desc "Convert Cumulus"
  task(:cumulus, :volume, :data_file) do |t, args|
    puts "Starting Conversion..."

    File.open(args[:data_file], "r") do |f|
      fields, records = [], []

      i = 0
      while (line = f.gets) do
        fields = line.split("\t") if i == 2
        records << line.split("\t") if i > 5
        i += 1
      end

      records = records.collect do |record|
        hash = {}

        fields.each_with_index do |k, i|
          hash[k] = record[i]
        end

        record[fields.length..record.length].each do |v|
          hash["Tags"] ||= []
          hash["Tags"] << v.split(":").join(",")
        end

        hash["Tags"] = hash["Tags"].join(",")
        hash["Tags"].gsub!("$Categories,", "")
        hash["Tags"].gsub!("$Sources,", "")

        hash
      end

      records.each do |record|
        asset = Asset.new(
          :name => record["Asset Name"],
          :description => record["Notes"],
          :file => File.new(File.join(args[:volume], record["Folder Name"], record["Asset Name"])),
          :tag_list => record["Tags"])
        asset.created_at = Date.parse(record["Asset Creation Date"])
        asset.updated_at = Date.parse(record["Asset Modification Date"])
        asset.save!
      end
    end
  end
end
