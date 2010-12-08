require File.join(File.dirname(__FILE__), "..", "..", "config", "environment")

namespace :convert do
  desc "Convert Cumulus"
  task(:cumulus, :volume, :data_file) do |t, args|
    puts "Starting Conversion..."

    user = User.first

    File.open(args[:data_file], "r") do |f|
      i = 0
      while (line = f.gets) do
        fields = line.force_encoding("ISO-8859-1").split("\t") if i == 2

        if i > 5
          r = line.force_encoding("ISO-8859-1").split("\t")

          record = {}
          fields.each_with_index do |k, i|
            record[k] = r[i]
          end

          r[fields.length..r.length].each do |v|
            record["Tags"] ||= []
            if v =~ /^\$Categories/
              record["Tags"] << v.gsub("$Categories", "").split(":").join(",")
            end
          end
          record["Tags"] = record["Tags"].join(",")

          if Asset.where(:identifier => record["Asset Identifier"]).count == 0
            asset = user.assets.new(
              :name => record["Asset Name"],
              :description => record["Notes"],
              :file => File.new(File.join(args[:volume], record["Folder Name"], record["Asset Name"])),
              :tag_list => record["Tags"])
            asset.identifier = record["Asset Identifier"]
            asset.created_at = Date.parse(record["Asset Creation Date"])
            asset.updated_at = Date.parse(record["Asset Modification Date"])
            asset.save!
          end

          print "."
        end

        i += 1
      end
    end
  end
end
