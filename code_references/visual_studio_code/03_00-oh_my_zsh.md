# <a name="top"></a> Cap 2 - Configuriamo il terminale

Mac nelle ultime versioni ha cambiato il suo terminale (aka shell) da bash a zsh.
Ne approfittiamo per installare "oh-my-zsh" e "iTerm2"



## Risorse esterne

- [video: Customize your terminal on MacOS like a pro 🔥 | oh-my-zsh | powerlevel10k | iTerm2](https://www.youtube.com/watch?v=Y9eBohzBcJ8)
- [video: OH MY ZSH Tutorial - Bring Your Terminal To Another Level](https://www.youtube.com/watch?v=SVh4osULjP4)
- [sito ufficiale: ohmyz.sh](https://ohmyz.sh)
- [tema: powerlevel10k](https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#installation)
- [font per powerlevel10k](https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#meslo-nerd-font-patched-for-powerlevel10k)
- [username and hostname to prompt](https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#how-do-i-add-username-andor-hostname-to-prompt)



## iTerm2

È bene instarlarlo prima di installare *oh-my-zsh* perché ci mette a disposizione diverse funzionalità ed anche i fonts migliori per il tema *powerlevel10k* che installeremo su *oh-my-zsh*.


## oh-my-zsh



## powerlevel10k

Lanciamo il configuration wizard.

```shell
p10k configure
```

Configuration wizard creates ~/.p10k.zsh based on your preferences. Additional prompt customization can be done by editing this file.

### username and hostname to prompt

When using Lean, Classic or Rainbow style, prompt shows username@hostname when you are logged in *as root or via SSH*. There is little value in showing username or hostname when you are logged in to your local machine as a normal user. So the absence of username@hostname in your prompt is an indication that you are working locally and that you aren't root. You can change it, however.

- [username and hostname to prompt](https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#how-do-i-add-username-andor-hostname-to-prompt)

