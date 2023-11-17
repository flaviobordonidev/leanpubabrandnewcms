# RSpec - System (il vecchio *feature*)


## I tipi di test


## Il feature test

Vediamo il primo tipo di test, ossia il "feature test". Quello da cui conviene sempre iniziare.

Feature tests are concerned with what user does and what user can see on the page.
Lavorano a livello di "browser" simulando le azioni che farebbe un utente fisicamente con tastiera e mouse.

Anche se questo tipo di test si chiama "feature test" su Rspec dobbiamo usare:`rspec:system`

> Attenzione!
> Su rspec **NON** usare `rspec:feature` perché è stata rimpiazzata dal più nuovo `rspec:system`
> La voce `rspec:feature` è ancora attiva solo per retrocompatibilità di app più vecchie.
> Questo tipo di test precedentemente si chiamava *feature* ma oggi è stato rimpiazzato.
> Quindi **non** usare `rspec:feature` perché è stato sostituito dal nuovo `rspec:system`

Let's generate a "feature test" using `rspec:system` generator:

```bash
$ rails g rspec:system your_feature
```

The describe block describes what we're testing inside of the block.

The before block, holds code that executes before each test inside that block.

The it block is your test.

The pending method is used to mark a test as pending (or not yet implemented). You can also use xit "your description" as well.

Use the visit method to make the browser go to a path/page.

Lastly, use the expect matcher to tell the test what it should expect as a result.

To run your tests using the documentation format, use the -f documentation option.

rails g rspec:system your_feature -f documentation
NOTE: There are two setup files, one called rails_helper and another called spec_helper. You should use rails_helper for most of your tests and only use spec_helper when you're testing code that doesn't require the Rails framework (e.g., library code that can work independently of your app or Rails).