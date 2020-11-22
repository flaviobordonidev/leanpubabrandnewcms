
---
Verfichiamo import su heroku
Come primo passo verifichiamo che la cartella tmp non ha file .csv già caricati

$ heroku run ls tmp

Dopodiché ci colleghiamo alla console rails su heroku

$ heroku run rails c


bobdesa64:~/workspace/donamat (ks) $ heroku run ls tmp
Running ls tmp on ⬢ limitless-chamber-62677... up, run.3110
cache  heroku-buildpack-release-step.yml
bobdesa64:~/workspace/donamat (ks) $ heroku run rails c
Running rails c on ⬢ limitless-chamber-62677... up, run.5745
Loading production environment (Rails 5.0.0.1)
irb(main):001:0> ftp = Net::FTP.new
=> #<Net::FTP:0x007f88c1039340 @mon_owner=nil, @mon_count=0, @mon_mutex=#<Thread::Mutex:0x007f88c10392a0>, @binary=true, @passive=true, @debug_mode=false, @resume=false, @sock=#<Net::FTP::NullSocket:0x007f88c1039278>, @logged_in=false, @open_timeout=nil, @read_timeout=60>
irb(main):002:0> ftp.connect("romasportface.com",21)
=> nil
irb(main):003:0> ftp.login("rmsport02@romasportface.com","166$}ItcoLr")
=> true
irb(main):004:0> ftp.passive = true
=> true
irb(main):005:0> ftp.getbinaryfile("MRDP1-transactions.txt", "tmp/MRDP1-transactions.txt")
=> nil
irb(main):006:0> ftp.close
=> nil
irb(main):007:0> exit
bobdesa64:~/workspace/donamat (ks) $ heroku run ls tmp
Running ls tmp on ⬢ limitless-chamber-62677... up, run.3183
cache  heroku-buildpack-release-step.yml
bobdesa64:~/workspace/donamat (ks) $ 

Non ci ha copiato il file. (forse lo ha copiato e quando il processo ha terminato lo ha cancellato)

http://stackoverflow.com/questions/5542916/ftp-to-rails-app-hosted-on-heroku

Heroku does not support your application receiving FTP. you can store files in #{Rails.root}/tmp/. However, these files are only available to the process that created them. When the process completes, the files are purged. 

