class Transaction < ApplicationRecord
  
  # Attenzione! Come si vede nella vita reale ci sono degli errori. In basso a volte si usa "_" ed altre "-"
  # Quindi preferisco prendere tutto il nome del file.
  #
  # BNL01_transactions.txt
  # BNL02_transactions.txt
  # STC01_transactions.txt
  # VFD01-transactions.txt
  # VFD02-transactions.txt
  # VFD03-transactions.txt


  # setter method (serve self perché va a scrivere nel db)(non creo il getter method)
  def self.import (csvfilename)
    
    ftp = Net::FTP.new
    ftp.connect("boutiquecampodifiori.com",21)
    ftp.login("boutiqu1","nSz0Yae46G")
    ftp.chdir("/tmp")
    ftp.passive = true
    ftp.getbinaryfile(csvfilename, "tmp/#{csvfilename}")
    ftp.close

    #CSV.foreach("tmp/BNL01_transactions.txt", col_sep: ';') do |row|
    CSV.foreach( "tmp/#{csvfilename}", col_sep: ';') do |row|
      t = Transaction.new
      t.csvfilename = csvfilename
      t.timestamp = row[0]
      t.id_check = row[1]
      t.onlus = row[2]
      t.project = row[3]
      t.kind = row[4]
      t.verify = row[5]
      t.cents = row[6]
      t.people_name = row[7]
      t.people_email = row[8]
      t.extra = row[9]
      t.save
    end
  end

end
