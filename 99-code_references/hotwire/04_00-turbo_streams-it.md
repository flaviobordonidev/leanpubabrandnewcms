# Turbo Streams

Approfondiamo

## Risorse esterne

- [hotwire inline crud table](bit.ly/inline-crud)



## Vediamo come funziona Turbo Streams

Facciamo un primo esempio di funzionamento usando solo codice <html>.

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/99-code_references/hotwire/04_fig01-turbo_streams_code.png)

Abbiamo un div con un id univoco che sarà usato da Turbo Streams:`<div id="some-id">`.
Questo div contiene un form `<form action="/create" method="POST">` che sarà il *target* per Turbo Streams.

Quando facciamo il submit del form andiamo sull'azione `create` del controller.
Il controller crea il div `<div>This is new content for the "some-id" node.</div>` ed effettua il render di Turbo Stream dicendo di appendere il div creato al div con id="some-id":

```ruby
render turbo_stream: [
  turbo_stream.append("some-id", html)
]
```

> Anche se in questo esempio abbiamo una sola azione, essendo il `render` un *array* possiamo eseguire più azioni.


Il controller genera il seguente codice <html> che manda come response:

```html
<turbo-stream action="append" target="some-id">
  <template>
    <div>
      This is new content for the "some-id" node.
    </div>
  </template>
</turbo-stream>
```


## Esempio inline crud table with Turbo Streams

In questo esempio c'è una tabella con i record ed interagiamo creando, modificando o eliminando i records senza refresh della pagina. (in modo molto *responsive*)

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/99-code_references/hotwire/04_fig02-turbo_streams_code_example.png)

Il codice per il controller non è molto complesso. Vediamo le tre azioni coinvolte.

```ruby
def create
  @user = User.new(user_params)

  if @user.save
    render turbo_stream: [
      turbo_stream.prepend("users", @user),
      turbo_stream.replace(
        "form_user",
        partial: "form",
        locals: { user: User.new }
      )
    ]
  else
    render :new, status: :unprocessable_entity
  end
end
```


```ruby
def update
  if @user.update(user_params)
    render turbo_stream: [
      turbo_stream.replace(@user, @user)
    ]
  else
    render :edit, status: :unprocessable_entity
  end
end
```


```ruby
def destroy
  @user.destroy
  render turbo_stream: [
    turbo_stream.remove(@user)
  ]
end
```




## Turbo Strems Broadcast

