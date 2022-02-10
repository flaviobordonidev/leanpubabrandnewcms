
---
You can use library links below:

http://www.ruby-doc.org/stdlib-1.9.3/libdoc/net/ftp/rdoc/index.html

and you can use EventMachine https://github.com/schleyfox/em-ftp-client.

require 'net/ftp'
ftp = Net::FTP.new
ftp.connect("myhostname.com",21)
ftp.login("myuser","my password")
ftp.chdir("/mydirectory")
ftp.passive = true
ftp.getbinaryfile("mysourcefile", "mydestfile")

