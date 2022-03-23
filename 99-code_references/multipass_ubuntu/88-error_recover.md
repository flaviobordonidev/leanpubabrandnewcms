# Error recover


## Risorse esterne

- [How to recover from Multipass Instance stopped while starting error](https://blog.mutantmahe.sh/2021-05-09-how-to-recover-from-multipass-instance-stopped-while-starting-error/)



## How to recover from Multipass Instance stopped while starting error

If you are not able to start the multipass instance either because of your **system crashed** or due to **power failure** and you are not able to get much detail about the error with the *-vvvv* verbose option.

You may be getting the output like this:

```bash
$ multipass start <INSTANCE-NAME> -vvvv
start failed: The following errors occurred:
Instance stopped while starting
Try getting the PID of multipassd and kill that process:
```

Try getting the `PID` of `multipassd` and **kill** that process:

```bash
$ ps aux | grep multipass
user            5792   1.0  0.0  4286756    764 s004  S+    8:26PM   0:00.00 grep multipass
user             725   0.0  0.2  4524668  28044   ??  S     1:32PM   0:01.04 multipass.gui --autostarting
root               141   0.0  0.1  4498516  19276   ??  Ss    1:32PM   0:00.90 /Library/Application Support/com.canonical.multipass/bin/multipassd --verbosity debug
```

Kill the process with the `PID` mentioned on above output.

```bash
$ sudo kill -9 <PID>
```

Now try running the multipass instance.

```bash
$ multipass start <INSTANCE-NAME> -vvvv
```

The above command should start the stuck multipass instance.