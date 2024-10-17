namespace :members do
    desc "Bulk upload members"
    task bulk_upload: :environment do
        puts "Bulk upload process started"
        file = Roo::Spreadsheet.open('./tmp/Members.xlsx')

        # Assuming your data starts at row 2, skipping the header row
        (2..file.last_row).each do |i|
          name = file.cell(i, 2)
          mobile = file.cell(i, 5).present? ? file.cell(i, 5) : file.cell(i, 4)
          status = file.cell(i, 7).present? ? file.cell(i, 7) : 0
          # Insert the data into the database
          member = Member.create(name: name, mobile: mobile, status: status)
    
          address = file.cell(i, 3)
          if address.present?
            address_array = address.split(",")
            address_array.pop if address_array.last.blank?
            zip = address_array.last.split(/[-—\s]+/).last
            
            #zip code 
            zip_code = if zip.present? && zip.match?(/\A\d.+\z/)
              zip.to_s.match?(/^\d{2}$/) ? "5600#{zip}" : zip.gsub(".", "")  
            else
              ""   
            end
    
            Address.create(
              member_id: member.id,
              permanent: address,
              communication: address,
              permanent_zip: zip_code,
              communication_zip: zip_code
            )
          end  
        end
        puts "Bulk upload process ended"
    end
end