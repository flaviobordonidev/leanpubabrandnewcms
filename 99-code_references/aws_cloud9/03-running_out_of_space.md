# Liberiamo spazio su C9 (clear up / free up disk space)

Questo articolo mi è stato molto utile specialmente lavorando su aws EC2 non ubuntu.
Per la EC2 con ubuntu non ho individuato facilmente files che potevo cancellare. (è da approfondire).
Vedi anche il capitolo "04-disk_resize".


Risorse web:

* https://community.c9.io/t/how-do-i-clear-up-disk-space-after-its-full/213/2






## Eliminiamo i temporanei di heroku

Questo funzionava molto bene nella versione linux OS di aws su EC2.

~~~~~~~~
$ sudo rm -rf /home/ubuntu/.local/share/heroku/tmp/*

~~~~~~~~

Abbiamo liberato 0.3G. Su root "/" siamo passati da 7.7G a 7.3G.





## Verifichiamo lo spazio nelle varie directories 

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ sudo du -hx / -t 50000000
~~~~~~~~

Nel mio caso si erano presi quasi tutto lo spazio disco i temporanei di heroku:
** 1.8G    /home/ubuntu/.local/share/heroku/tmp **
Li ho liberati con il comando:


{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
sudo rm -rf /home/ubuntu/.local/share/heroku/tmp/*
~~~~~~~~


~~~~~~~~
heroku run ls tmp
~~~~~~~~




## Esempio di uso


Per vedere le cartelle raggruppate dai 50M in su.

{title="terminal", lang=bash, line-numbers=off}
```
$ sudo du -hx / -t 50000000


user_fb:~/environment/elisinfo (ci) $ sudo du -hx / -t 50000000
48M     /root/.cache/pip/http
63M     /root/.cache/pip
63M     /root/.cache
63M     /root
60M     /lib/modules/5.3.0-1034-aws/kernel
62M     /lib/modules/5.3.0-1034-aws
60M     /lib/modules/5.3.0-1035-aws/kernel
62M     /lib/modules/5.3.0-1035-aws
62M     /lib/modules/5.4.0-1025-aws/kernel
62M     /lib/modules/5.4.0-1025-aws
57M     /lib/modules/4.15.0-1021-aws/kernel
58M     /lib/modules/4.15.0-1021-aws
246M    /lib/modules
295M    /lib
52M     /home/ubuntu/.nvm/versions/node/v10.21.0/lib/node_modules/cdk/node_modules/aws-cdk/node_modules/aws-sdk
84M     /home/ubuntu/.nvm/versions/node/v10.21.0/lib/node_modules/cdk/node_modules/aws-cdk/node_modules
87M     /home/ubuntu/.nvm/versions/node/v10.21.0/lib/node_modules/cdk/node_modules/aws-cdk
87M     /home/ubuntu/.nvm/versions/node/v10.21.0/lib/node_modules/cdk/node_modules
87M     /home/ubuntu/.nvm/versions/node/v10.21.0/lib/node_modules/cdk
49M     /home/ubuntu/.nvm/versions/node/v10.21.0/lib/node_modules/typescript
209M    /home/ubuntu/.nvm/versions/node/v10.21.0/lib/node_modules
209M    /home/ubuntu/.nvm/versions/node/v10.21.0/lib
255M    /home/ubuntu/.nvm/versions/node/v10.21.0
255M    /home/ubuntu/.nvm/versions/node
255M    /home/ubuntu/.nvm/versions
259M    /home/ubuntu/.nvm
50M     /home/ubuntu/environment/elisinfo/tmp/cache/bootsnap-compile-cache
75M     /home/ubuntu/environment/elisinfo/tmp/cache
75M     /home/ubuntu/environment/elisinfo/tmp
143M    /home/ubuntu/environment/elisinfo/node_modules
97M     /home/ubuntu/environment/elisinfo/public/packs/js
97M     /home/ubuntu/environment/elisinfo/public/packs
97M     /home/ubuntu/environment/elisinfo/public
382M    /home/ubuntu/environment/elisinfo
383M    /home/ubuntu/environment
145M    /home/ubuntu/.rvm/gems/ruby-2.6.3/gems
67M     /home/ubuntu/.rvm/gems/ruby-2.6.3/doc
249M    /home/ubuntu/.rvm/gems/ruby-2.6.3
249M    /home/ubuntu/.rvm/gems
319M    /home/ubuntu/.rvm
49M     /home/ubuntu/.npm/_cacache
49M     /home/ubuntu/.npm
278M    /home/ubuntu/.cache/yarn/v6
278M    /home/ubuntu/.cache/yarn
278M    /home/ubuntu/.cache
1.3G    /home/ubuntu
1.3G    /home
55M     /var/lib/postgresql/10/main
55M     /var/lib/postgresql/10
55M     /var/lib/postgresql
48M     /var/lib/dpkg
125M    /var/lib/docker/overlay2/df2e2643de9231e914ea89069c3c66a73f18a6ad5ba64710fcd5dfbe36de2e98/diff/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.201.b09-0.43.amzn1.x86_64/jre/lib
125M    /var/lib/docker/overlay2/df2e2643de9231e914ea89069c3c66a73f18a6ad5ba64710fcd5dfbe36de2e98/diff/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.201.b09-0.43.amzn1.x86_64/jre
125M    /var/lib/docker/overlay2/df2e2643de9231e914ea89069c3c66a73f18a6ad5ba64710fcd5dfbe36de2e98/diff/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.201.b09-0.43.amzn1.x86_64
125M    /var/lib/docker/overlay2/df2e2643de9231e914ea89069c3c66a73f18a6ad5ba64710fcd5dfbe36de2e98/diff/usr/lib/jvm
102M    /var/lib/docker/overlay2/df2e2643de9231e914ea89069c3c66a73f18a6ad5ba64710fcd5dfbe36de2e98/diff/usr/lib/locale
245M    /var/lib/docker/overlay2/df2e2643de9231e914ea89069c3c66a73f18a6ad5ba64710fcd5dfbe36de2e98/diff/usr/lib
213M    /var/lib/docker/overlay2/df2e2643de9231e914ea89069c3c66a73f18a6ad5ba64710fcd5dfbe36de2e98/diff/usr/lib64
66M     /var/lib/docker/overlay2/df2e2643de9231e914ea89069c3c66a73f18a6ad5ba64710fcd5dfbe36de2e98/diff/usr/share/locale
184M    /var/lib/docker/overlay2/df2e2643de9231e914ea89069c3c66a73f18a6ad5ba64710fcd5dfbe36de2e98/diff/usr/share
668M    /var/lib/docker/overlay2/df2e2643de9231e914ea89069c3c66a73f18a6ad5ba64710fcd5dfbe36de2e98/diff/usr
719M    /var/lib/docker/overlay2/df2e2643de9231e914ea89069c3c66a73f18a6ad5ba64710fcd5dfbe36de2e98/diff
719M    /var/lib/docker/overlay2/df2e2643de9231e914ea89069c3c66a73f18a6ad5ba64710fcd5dfbe36de2e98
55M     /var/lib/docker/overlay2/00e48b1936f2e08a74641b603e56611706fbadbce31864eea0f34ac640cd033e/diff/var/runtime/node_modules
55M     /var/lib/docker/overlay2/00e48b1936f2e08a74641b603e56611706fbadbce31864eea0f34ac640cd033e/diff/var/runtime
76M     /var/lib/docker/overlay2/00e48b1936f2e08a74641b603e56611706fbadbce31864eea0f34ac640cd033e/diff/var/lang
131M    /var/lib/docker/overlay2/00e48b1936f2e08a74641b603e56611706fbadbce31864eea0f34ac640cd033e/diff/var
131M    /var/lib/docker/overlay2/00e48b1936f2e08a74641b603e56611706fbadbce31864eea0f34ac640cd033e/diff
131M    /var/lib/docker/overlay2/00e48b1936f2e08a74641b603e56611706fbadbce31864eea0f34ac640cd033e
51M     /var/lib/docker/overlay2/4c910725bb40753b5f50a686cffe3027e6cf1d6aba43c52873c842b63242f8ec/diff/var/runtime/node_modules/aws-sdk
56M     /var/lib/docker/overlay2/4c910725bb40753b5f50a686cffe3027e6cf1d6aba43c52873c842b63242f8ec/diff/var/runtime/node_modules
56M     /var/lib/docker/overlay2/4c910725bb40753b5f50a686cffe3027e6cf1d6aba43c52873c842b63242f8ec/diff/var/runtime
67M     /var/lib/docker/overlay2/4c910725bb40753b5f50a686cffe3027e6cf1d6aba43c52873c842b63242f8ec/diff/var/lang/bin
108M    /var/lib/docker/overlay2/4c910725bb40753b5f50a686cffe3027e6cf1d6aba43c52873c842b63242f8ec/diff/var/lang
174M    /var/lib/docker/overlay2/4c910725bb40753b5f50a686cffe3027e6cf1d6aba43c52873c842b63242f8ec/diff/var
174M    /var/lib/docker/overlay2/4c910725bb40753b5f50a686cffe3027e6cf1d6aba43c52873c842b63242f8ec/diff
174M    /var/lib/docker/overlay2/4c910725bb40753b5f50a686cffe3027e6cf1d6aba43c52873c842b63242f8ec
53M     /var/lib/docker/overlay2/bde29fe7c9d0ee6a6c3091eab35470706f82e5d7d0a1251249635222cae4dcf5/diff/var/runtime/botocore
63M     /var/lib/docker/overlay2/bde29fe7c9d0ee6a6c3091eab35470706f82e5d7d0a1251249635222cae4dcf5/diff/var/runtime
61M     /var/lib/docker/overlay2/bde29fe7c9d0ee6a6c3091eab35470706f82e5d7d0a1251249635222cae4dcf5/diff/var/lang/lib/python3.7/test
160M    /var/lib/docker/overlay2/bde29fe7c9d0ee6a6c3091eab35470706f82e5d7d0a1251249635222cae4dcf5/diff/var/lang/lib/python3.7
182M    /var/lib/docker/overlay2/bde29fe7c9d0ee6a6c3091eab35470706f82e5d7d0a1251249635222cae4dcf5/diff/var/lang/lib
183M    /var/lib/docker/overlay2/bde29fe7c9d0ee6a6c3091eab35470706f82e5d7d0a1251249635222cae4dcf5/diff/var/lang
256M    /var/lib/docker/overlay2/bde29fe7c9d0ee6a6c3091eab35470706f82e5d7d0a1251249635222cae4dcf5/diff/var
256M    /var/lib/docker/overlay2/bde29fe7c9d0ee6a6c3091eab35470706f82e5d7d0a1251249635222cae4dcf5/diff
256M    /var/lib/docker/overlay2/bde29fe7c9d0ee6a6c3091eab35470706f82e5d7d0a1251249635222cae4dcf5
50M     /var/lib/docker/overlay2/e82de315b13b6aa185162f8ce117e0ce4fce16901af1b39d76ae71b60bd406b8/diff/var/runtime/botocore
58M     /var/lib/docker/overlay2/e82de315b13b6aa185162f8ce117e0ce4fce16901af1b39d76ae71b60bd406b8/diff/var/runtime
57M     /var/lib/docker/overlay2/e82de315b13b6aa185162f8ce117e0ce4fce16901af1b39d76ae71b60bd406b8/diff/var/lang/lib/python3.6/test
131M    /var/lib/docker/overlay2/e82de315b13b6aa185162f8ce117e0ce4fce16901af1b39d76ae71b60bd406b8/diff/var/lang/lib/python3.6
143M    /var/lib/docker/overlay2/e82de315b13b6aa185162f8ce117e0ce4fce16901af1b39d76ae71b60bd406b8/diff/var/lang/lib
143M    /var/lib/docker/overlay2/e82de315b13b6aa185162f8ce117e0ce4fce16901af1b39d76ae71b60bd406b8/diff/var/lang
201M    /var/lib/docker/overlay2/e82de315b13b6aa185162f8ce117e0ce4fce16901af1b39d76ae71b60bd406b8/diff/var
201M    /var/lib/docker/overlay2/e82de315b13b6aa185162f8ce117e0ce4fce16901af1b39d76ae71b60bd406b8/diff
201M    /var/lib/docker/overlay2/e82de315b13b6aa185162f8ce117e0ce4fce16901af1b39d76ae71b60bd406b8
51M     /var/lib/docker/overlay2/93736ab40fd412b1d3cc6ed68e6ac3441cf9e45b2303da772b471fd5572b712e/diff/var/runtime/node_modules/aws-sdk
51M     /var/lib/docker/overlay2/93736ab40fd412b1d3cc6ed68e6ac3441cf9e45b2303da772b471fd5572b712e/diff/var/runtime/node_modules
51M     /var/lib/docker/overlay2/93736ab40fd412b1d3cc6ed68e6ac3441cf9e45b2303da772b471fd5572b712e/diff/var/runtime
72M     /var/lib/docker/overlay2/93736ab40fd412b1d3cc6ed68e6ac3441cf9e45b2303da772b471fd5572b712e/diff/var/lang/bin
113M    /var/lib/docker/overlay2/93736ab40fd412b1d3cc6ed68e6ac3441cf9e45b2303da772b471fd5572b712e/diff/var/lang
174M    /var/lib/docker/overlay2/93736ab40fd412b1d3cc6ed68e6ac3441cf9e45b2303da772b471fd5572b712e/diff/var
174M    /var/lib/docker/overlay2/93736ab40fd412b1d3cc6ed68e6ac3441cf9e45b2303da772b471fd5572b712e/diff
174M    /var/lib/docker/overlay2/93736ab40fd412b1d3cc6ed68e6ac3441cf9e45b2303da772b471fd5572b712e
110M    /var/lib/docker/overlay2/43afd979fcd1806eabad7b98eaa8308614899f5671c211a6df4822730475e0ed/diff/usr/lib/locale
110M    /var/lib/docker/overlay2/43afd979fcd1806eabad7b98eaa8308614899f5671c211a6df4822730475e0ed/diff/usr/lib
49M     /var/lib/docker/overlay2/43afd979fcd1806eabad7b98eaa8308614899f5671c211a6df4822730475e0ed/diff/usr/lib64
211M    /var/lib/docker/overlay2/43afd979fcd1806eabad7b98eaa8308614899f5671c211a6df4822730475e0ed/diff/usr
219M    /var/lib/docker/overlay2/43afd979fcd1806eabad7b98eaa8308614899f5671c211a6df4822730475e0ed/diff
219M    /var/lib/docker/overlay2/43afd979fcd1806eabad7b98eaa8308614899f5671c211a6df4822730475e0ed
50M     /var/lib/docker/overlay2/79f521d4ec2cfed8f29a41c5629c1726eed235aadf62bcc6aba60c9f1611679c/diff/var/runtime/botocore
59M     /var/lib/docker/overlay2/79f521d4ec2cfed8f29a41c5629c1726eed235aadf62bcc6aba60c9f1611679c/diff/var/runtime
59M     /var/lib/docker/overlay2/79f521d4ec2cfed8f29a41c5629c1726eed235aadf62bcc6aba60c9f1611679c/diff/var
59M     /var/lib/docker/overlay2/79f521d4ec2cfed8f29a41c5629c1726eed235aadf62bcc6aba60c9f1611679c/diff
59M     /var/lib/docker/overlay2/79f521d4ec2cfed8f29a41c5629c1726eed235aadf62bcc6aba60c9f1611679c
105M    /var/lib/docker/overlay2/3154213786eacff822ec1b3bcba43cd87105dbe799ce0ac18457cd19764c629b/diff/var/runtime
64M     /var/lib/docker/overlay2/3154213786eacff822ec1b3bcba43cd87105dbe799ce0ac18457cd19764c629b/diff/var/lang/lib/python3.8/test
187M    /var/lib/docker/overlay2/3154213786eacff822ec1b3bcba43cd87105dbe799ce0ac18457cd19764c629b/diff/var/lang/lib/python3.8
207M    /var/lib/docker/overlay2/3154213786eacff822ec1b3bcba43cd87105dbe799ce0ac18457cd19764c629b/diff/var/lang/lib
208M    /var/lib/docker/overlay2/3154213786eacff822ec1b3bcba43cd87105dbe799ce0ac18457cd19764c629b/diff/var/lang
323M    /var/lib/docker/overlay2/3154213786eacff822ec1b3bcba43cd87105dbe799ce0ac18457cd19764c629b/diff/var
323M    /var/lib/docker/overlay2/3154213786eacff822ec1b3bcba43cd87105dbe799ce0ac18457cd19764c629b/diff
323M    /var/lib/docker/overlay2/3154213786eacff822ec1b3bcba43cd87105dbe799ce0ac18457cd19764c629b
2.3G    /var/lib/docker/overlay2
2.3G    /var/lib/docker
132M    /var/lib/mysql
126M    /var/lib/snapd/cache
101M    /var/lib/snapd/seed/snaps
101M    /var/lib/snapd/seed
97M     /var/lib/snapd/snaps
323M    /var/lib/snapd
133M    /var/lib/apt/lists
133M    /var/lib/apt
3.0G    /var/lib
116M    /var/cache/apt
125M    /var/cache
169M    /var/log/journal/ec22787b858c335b4b08cc60024214f4
169M    /var/log/journal
183M    /var/log
3.8G    /var
117M    /boot
115M    /usr/lib/jvm/java-8-openjdk-amd64/jre/lib
115M    /usr/lib/jvm/java-8-openjdk-amd64/jre
153M    /usr/lib/jvm/java-8-openjdk-amd64
153M    /usr/lib/jvm
63M     /usr/lib/python3/dist-packages
63M     /usr/lib/python3
72M     /usr/lib/python3.6/config-3.6m-x86_64-linux-gnu
94M     /usr/lib/python3.6
75M     /usr/lib/python2.7
202M    /usr/lib/x86_64-linux-gnu
74M     /usr/lib/debug
51M     /usr/lib/go-1.9/pkg/linux_amd64
59M     /usr/lib/go-1.9/pkg/tool/linux_amd64
59M     /usr/lib/go-1.9/pkg/tool
114M    /usr/lib/go-1.9/pkg
123M    /usr/lib/go-1.9
89M     /usr/lib/gcc/x86_64-linux-gnu/7
89M     /usr/lib/gcc/x86_64-linux-gnu
89M     /usr/lib/gcc
77M     /usr/lib/snapd
1.1G    /usr/lib
531M    /usr/bin
64M     /usr/local/lib/python3.6/dist-packages/astroid/tests/testdata
65M     /usr/local/lib/python3.6/dist-packages/astroid/tests
66M     /usr/local/lib/python3.6/dist-packages/astroid
246M    /usr/local/lib/python3.6/dist-packages
246M    /usr/local/lib/python3.6
51M     /usr/local/lib/python2.7/dist-packages/codeintel/codeintel2/stdlibs
68M     /usr/local/lib/python2.7/dist-packages/codeintel/codeintel2
76M     /usr/local/lib/python2.7/dist-packages/codeintel
144M    /usr/local/lib/python2.7/dist-packages
144M    /usr/local/lib/python2.7
55M     /usr/local/lib/heroku/node_modules/@heroku-cli
116M    /usr/local/lib/heroku/node_modules
161M    /usr/local/lib/heroku
550M    /usr/local/lib
551M    /usr/local
115M    /usr/src/linux-aws-headers-4.15.0-1021
109M    /usr/src/linux-aws-5.3-headers-5.3.0-1030
109M    /usr/src/linux-aws-5.3-headers-5.3.0-1033
109M    /usr/src/linux-aws-5.3-headers-5.3.0-1034
109M    /usr/src/linux-aws-5.3-headers-5.3.0-1035
109M    /usr/src/linux-aws-5.3-headers-5.3.0-1032
733M    /usr/src
60M     /usr/share/go-1.9/src
71M     /usr/share/go-1.9
345M    /usr/share
85M     /usr/libexec/docker/cli-plugins
85M     /usr/libexec/docker
85M     /usr/libexec
3.3G    /usr
64M     /opt/c9/python3/lib/python3.6/site-packages/astroid/tests/testdata
65M     /opt/c9/python3/lib/python3.6/site-packages/astroid/tests
66M     /opt/c9/python3/lib/python3.6/site-packages/astroid
138M    /opt/c9/python3/lib/python3.6/site-packages
139M    /opt/c9/python3/lib/python3.6
139M    /opt/c9/python3/lib
143M    /opt/c9/python3
49M     /opt/c9/lib/server/node_modules/aws-sdk
53M     /opt/c9/lib/server/node_modules
53M     /opt/c9/lib/server
70M     /opt/c9/lib
86M     /opt/c9/node
51M     /opt/c9/dependencies/extensionHost/7897dee8b2c7ac9bedcd9b4f9c6ae764c8ee679ee3675e267d4cac8ff6fc4fda51255dd4d82f63469a4aa5691432ddd7ae9f02270f83e47e3afd48c63cbe54c1/package
51M     /opt/c9/dependencies/extensionHost/7897dee8b2c7ac9bedcd9b4f9c6ae764c8ee679ee3675e267d4cac8ff6fc4fda51255dd4d82f63469a4aa5691432ddd7ae9f02270f83e47e3afd48c63cbe54c1
51M     /opt/c9/dependencies/extensionHost
97M     /opt/c9/dependencies
49M     /opt/c9/ts-server/node_modules/typescript-language-server-with-ts/node_modules/typescript
52M     /opt/c9/ts-server/node_modules/typescript-language-server-with-ts/node_modules
52M     /opt/c9/ts-server/node_modules/typescript-language-server-with-ts
52M     /opt/c9/ts-server/node_modules
52M     /opt/c9/ts-server
89M     /opt/c9/sam-cli-venv/lib/python3.6/site-packages
89M     /opt/c9/sam-cli-venv/lib/python3.6
89M     /opt/c9/sam-cli-venv/lib
100M    /opt/c9/sam-cli-venv
75M     /opt/c9/python2/lib/python2.7/site-packages
75M     /opt/c9/python2/lib/python2.7
75M     /opt/c9/python2/lib
79M     /opt/c9/python2
784M    /opt/c9
784M    /opt
9.6G    /
user_fb:~/environment/elisinfo (ci) $ 
```




