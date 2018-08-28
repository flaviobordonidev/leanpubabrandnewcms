# Leggiamo file da web




## Open-uri

Se il file txt è pubblicamente visibile su un sito web si può scaricare con open-uri al posto di net/ftp.


For reading from the FTP-server, first load the file into a variable and then use CSV.new(file, options) on it:

~~~~~~~~
require 'open-uri'
require 'csv'

file = open("http://www.justinmrao.com/salary_data.csv")

CSV.new(file, col_sep: ',').readlines do |row|
  # ... do stuff on each row
end
~~~~~~~~
