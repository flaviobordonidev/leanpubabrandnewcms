# Elapsed time with Ruby, the right way



{title="elapsed_time.rb", lang=ruby, line-numbers=off}
~~~~~~~~
  starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  # time consuming operation
  # .
  # .
  # .
  ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  elapsed = ending - starting
  elapsed # => 9.183449000120163 seconds
~~~~~~~~




## Per approfondimenti

https://blog.dnsimple.com/2018/03/elapsed-time-with-ruby-the-right-way/

When you want to calculate the elapsed time with Ruby, what do you usually do?

starting = Time.now
# time consuming operation
ending = Time.now
elapsed = ending - starting
elapsed # => 10.822178
⚠ This is wrong. Let's see why.

Time doesn't move only forwards
Depending on the low level Operating System (OS) settings, Ruby's Time.now uses gettimeofday or clock_gettime Linux functions from time.h.

According to the documentation of gettimeofday:

[It] gives the number of seconds and microseconds since the Epoch.

It returns a struct with the number of seconds and the system time zone. Ruby VM can then calculate and it returns a Time object with these informations. This is often indicated as wall time in Linux documentation.

However:

The time returned by gettimeofday() is affected by discontinuous jumps in the system time (e.g., if the system administrator manually changes the system time).

This isn't only affected by manual adjustments, but also to automatic reconciliations of the system clock. For instance, if your server uses NTP:

Ideally the reference time is the same everywhere in the world. Once synchronized, there should not be any unexpected changes between the clock of the operating system and the reference clock. Therefore, NTP has no special methods to handle the situation.

For a tiny offset ntpd will adjust the local clock as usual.

In NTP documentation, there is an entire section about clocks quality:

Unfortunately all the common clock hardware is not very accurate. This is simply because the frequency that makes time increase is never exactly right. Even an error of only 0.001% would make a clock be off by almost one second per day.

The lack of perfect accuracy is due to CPU physical conditions like temperature, air pressure, and even magnetic fields.

So when the OS tries to set a new system time, it doesn't guarantee that the new value will be in the future. If a CPU has a clock that is "too fast", the OS can decide to reset the time of a few seconds backward.

Another reason why wall clocks are flawed is because some CPUs can't manage leap seconds. On Wikipedia there is a page dedicated to incidents in software history due to leap seconds.

🤓 To recap: system clock is constantly floating and it doesn't move only forwards. If your calculation of elapsed time is based on it, you're very likely to run into calculation errors or even outages.

Elapsed time, the right way
How can you calculate elapsed time that has constant increments that move only forwards? 🤔

Posix systems have solved this problem by introducing a monotonic clock. It's conceptually similar to a timer that starts with an event and it isn't affected by time floating problems. Each time you request the time to the monotonic clock, it returns the time since that event. On Mac OS, this event is the system boot. Alongside with monotonic, there are several clock types: realtime, monotonic raw, virtual just to name a few. Each of them solves a different problem.

Since Ruby 2.1+ (MRI 2.1+ and JRuby 9.0.0.0+) there is a new method that allows to access to the current values of all these clocks: Process.clock_gettime. This is named after the Linux function clock_gettime (still from time.h).

t = Process.clock_gettime(Process::CLOCK_MONOTONIC)
# => 2810266.714992
t / (24 * 60 * 60.0) # time / days
# => 32.52623512722222
The variable t expresses the time in seconds since system boot.

$ uptime
14:32  up 32 days, 12:29, 2 users, load averages: 1.70 1.74 1.67
How to measure elapsed time with Ruby then?

starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
# time consuming operation
ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
elapsed = ending - starting
elapsed # => 9.183449000120163 seconds
Conclusion
If you look at the Ruby ecosystem, there are literally thousands of cases where the elapsed time calculations are wrong. Maybe this is a good time for you to contribute to Open Source 💚💎 and fix these problems. 😉

Remember: wall clock is for telling time, monotonic clock is for measuring time. ⏰