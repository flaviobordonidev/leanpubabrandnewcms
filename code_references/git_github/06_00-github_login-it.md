# <a name="top"></a> Cap 5.3 - Inizializzazione di Github


## Risorse interne

- [01-base / 05-github / Cap 5.3 - Inizializzazione di Github]()



## Risorse esterne

- [github doc: token-authentication](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)
- [github blog post: token-authentication](https://github.blog/2020-12-15-token-authentication-requirements-for-git-operations/)



## Git push - login wiht TOKEN

```bash
ubuntu@ubuntufla:~/simple_blog (main)$git push origin main
Username for 'https://github.com': flavio.bordoni.dev@gmail.com
Password for 'https://flavio.bordoni.dev@gmail.com@github.com': 
remote: Support for password authentication was removed on August 13, 2021. Please use a personal access token instead.
remote: Please see https://github.blog/2020-12-15-token-authentication-requirements-for-git-operations/ for more information.
fatal: Authentication failed for 'https://github.com/flaviobordonidev/simple_blog.git/'
```


Creating a token
Verify your email address, if it hasn't been verified yet.

In the upper-right corner of any page, click your profile photo, then click Settings.

Settings icon in the user bar

In the left sidebar, click  Developer settings.

In the left sidebar, click Personal access tokens.
Personal access tokens

Click Generate new token.
Generate new token button

Give your token a descriptive name.
Token description field

To give your token an expiration, select the Expiration drop-down menu, then click a default or use the calendar picker.
Token expiration field

Select the scopes, or permissions, you'd like to grant this token. To use your token to access repositories from the command line, select repo.

Selecting token scopes

Click Generate token.
Generate token button

Newly created token

Warning: Treat your tokens like passwords and keep them secret. When working with the API, use tokens as environment variables instead of hardcoding them into your programs.