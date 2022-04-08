# Come Tornare INDIETRO


## Risorse interne

- vedi [99-code_references/OLD-gem_globalize/01_00-install_i18n_globalize-it]()
  globalize non è più usato e quindi siamo tornati indietro
- vedi [99-code_references/02_00-migrate_rollback]()
- vedi [99-code_references/02_00-migrate_rollback]()



## Consiglio

***NON USARE*** il comando `$ rails db:rollback` perché spesso mi ha creato problemi.
Molto meglio creare un nuovo migrate ed indicare cosa togliere. Questo funziona molto bene specialmente quando andiamo ad applicarlo su heroku.
