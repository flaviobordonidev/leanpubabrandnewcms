# <a name="top"></a> Cap git_github.14 - Connettiamo GitHub a Ubuntu multipass

Connettiamoci ad un repository Github - il nostro mac o la nostra vm GitHub alla nostra VM locale: ubuntu multipass.

In this article we will learn how to use multiple SSH keys for different Git accounts on your machine. The most common reasons to need this is in the case that you have a different account for work and personal projects or even if you are a freelance/contractor working for different organisations.


## Risorse esterne

- [How to Use Multiple SSH Keys For Different Git Accounts](https://theboreddev.com/use-multiple-ssh-keys-different-git-accounts/)



## Introduzione

We will take you through the steps you will need to follow in order to be able to push to your git repositories using the right author and having the right permissions every time.

If you are using the right user in your commit, but still using the wrong SSH key, you will get an error message similar to this:

```shell
$ git push
                                                                                                                                                 
ERROR: Permission to theboreddev/myrepository.git denied to theboreddev.
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
```

Let’s see what do we have to do to fix this issue.



## 1 – Create a New SSH Key

The first thing you will need is an SSH key that will be added to your corresponding Github account. If you don’t have an SSH key yet and you don’t know how to generate an SSH key, check our article “How to Generate SSH Keys”.

Once you have your SSH key, it’s time to add it to Github!



## 2 – Add SSH Key to Github Account

Once you have your new SSH key, you will have to add it as a valid SSH key into your Github account. That’s the way that Github will know that you are a “trusted” user for that account when connecting through SSH.

If you don’t know how to do that, check our article “How to Add SSH Keys to Github”.

## 3 – Modify SSH config
In order to be able to determine what SSH key will be used for each repository, we will need to add configuration to our SSH config to associate each key to certain repositories.

To modify your SSH config you can run:

```shell
vim ~/.ssh/config
```

Once in your editor, you will need two different sections for github.com hosts. Our configuration will look like this:

```shell
Host github.com
  Hostname github.com
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519
Host github.com-theboreddev
  Hostname github.com
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_boreddev
```

The first SSH key (id_ed25519) will be used for every github.com repository by default. We will see now how to use the alternative key for other repositories.


## 4 – Associate Repository to New Key

Once we have that configuration in place, the next step is not very intuitive but we’ll try to make it clear.

We have to either clone our repository in a different way or modify the remote origin url for our existing repositories.

Let’s see how to do it in both cases:


### 4.1 – Clone New Repository

If we are going to clone a new repository, instead of using the original github.com url, we will clone it in a slightly different way:

```shell
git clone git@github.com-theboreddev:theboreddev/myrepo.git
```

Notice that the hostname has changed to use the host we previously configured in our ~/.ssh/config file!


### 4.2 – Modify Remote Url For Existing Repository

If instead we already have a local repository we would like to configure to be able to push using the new SSH key, we’d have to do the following:

```shell
git remote set-url origin git@github.com-theboreddev:theboreddev/myrepo.git
```

That’s all! It should work now as well.



## 5 – Set User For Current Repository
One more thing to do, if we have a global username and email already defined in Git, is to override the username and email for our current repository. This step will only be needed if you need to use a different user from the one you normally use.

In order to do so, you’d just have to do something similar to this inside your git repository:

```shell
git config user.name  "theboreddev"
git config user.email "account@theboreddev.com"
```

That’s all! If you commit a change and try to push to your repository, it should work!


