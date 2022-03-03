# <a name="top"></a> Cap 1.3 - Implementiamo la IDE

Implementiamo la parte grafica per lo sviluppo.


## Risorse esterne

- [Remote Development with VS Code on Mac](https://medium.com/macoclock/remote-development-with-vscode-on-mac-in-simple-5-steps-6ae100938d67)



## Che cos'è un IDE

L'IDE è un *ambiente di sviluppo integrato* (Integrated Development Environment). Ossia il programma che usiamo per scrivere il codice. Nel nostro caso la scelta è **Visual Studio Code**.


## Installiamo Visaul Studio Code

Basta andare sul sito della microsoft e scaricarlo tanto è gratuito ed open source ^_^

- Download and install VS Code for mac
    Go to URL https://code.visualstudio.com/download and click on the download button.
- Extract the zip file generated using the below command on the command line. or double click on the zip file to extract the content.
    tar -xvzf VSCode-darwin-stable.zip
- Double click on the Visual Studio Code. app to launch VS Code.

> Note: Drag it to the application folder to make it available on the launch pad. Make it available on the dock by right-clicking and choosing option keep in doc



## Installiamo Visual Studio Code Remote Development Extension Pack

Apriamo Visual Studio Code e clicchiamo su *extension icon*. Cerchiamo *remote development extension pack* ed installiamolo.

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app_with_ubuntu_multipass/03_01-install_remote_development_pack.png)



## Colleghiamolo alla VM tramite SSH

> Prerequisiti <br/>
> Local: Ssh client compatible with openssh. On macOS, it comes preinstalled. <br/>
> Remote SSH host: A running ssh server on your remote Linux machine. (Fatto nei capitoli precedenti)


Configure
step 0: Install Visual Studio Code Remote Development Extension Pack.
Click on the extensions icon.
Search for remote development extension pack.
Click install

Step1: Try connecting to a remote host.
To verify that you can connect to the remote machine, where your actual code base is executed the command from the terminal replacing username with your username on the remote machine and host IP with the IP of the remote machine.
ssh username@hostip

Step 2: Configuring ssh In VS Code
In the command pallete(F1)select Remote-SSH: Add New SSH Host… and use the same user@hostname as in step 1
Select Remote-SSH: Connect to Host… from the Command Palette (F1). From the drop-down choose the already added host. Type in the password when prompted for it.

Vs Code will automatically detect the type of the server, if not you will be asked to select the type manually.

You can edit this in vscode settings (Code > Preferences > Settings)by updating remote.SSH.remotePlatform property
After a moment, VS Code will connect to the SSH server and set itself up. VS Code will keep you up-to-date using a progress notification and you can see a detailed log in the Remote - SSH output channel. You can check the status bar to check the remote host you are connected to

Step 3: You can then open any folder or workspace using File > Open… or File > Open Workspace… on the remote machine.

