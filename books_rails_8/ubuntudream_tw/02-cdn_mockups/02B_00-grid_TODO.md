


<div class="grid grid-cols-12 gap-4">
  <div class="col-span-6 bg-blue-200">Metà</div>
  <div class="col-span-6 bg-blue-400">Altra metà</div>
</div>


<div class="grid grid-cols-12 gap-4">
  <div class="col-span-4 bg-red-200">4 colonne</div>
  <div class="col-span-8 bg-red-400">8 colonne</div>
</div>



---


## Responsive come in Bootstrap?

Sì, con le breakpoint classes di Tailwind. Per esempio:

<div class="grid grid-cols-12 gap-4">
  <div class="col-span-12 md:col-span-6 lg:col-span-4">Responsive</div>
</div>

- col-span-12: su mobile
- md:col-span-6: da 768px in su (tablet)
- lg:col-span-4: da 1024px in su (desktop)


---

Come tradurre in tailwind il seguente layout bootstrap che ha anche le "row":

<div class="container text-center">
  <div class="row">
    <div class="col">
      Column
    </div>
    <div class="col">
      Column
    </div>
    <div class="col">
      Column
    </div>
  </div>
</div>

Ottimo esempio! Quello che hai mostrato è un classico layout Bootstrap con una container, una row e tre col, ognuna delle quali si distribuisce in modo equamente spaziale all'interno della riga (grazie al comportamento Flexbox implicito di Bootstrap sulle row).

In Tailwind, non esiste una classe astratta row, ma possiamo ricreare lo stesso identico layout in due modi principali:

✅ Versione equivalente in Tailwind (con Flexbox)

<div class="container mx-auto text-center">
  <div class="flex">
    <div class="flex-1 border p-4">Column</div>
    <div class="flex-1 border p-4">Column</div>
    <div class="flex-1 border p-4">Column</div>
  </div>
</div>


Se preferisci usare Grid (più vicino al modello 12 colonne):

<div class="container mx-auto text-center">
  <div class="grid grid-cols-3 gap-4">
    <div class="border p-4">Column</div>
    <div class="border p-4">Column</div>
    <div class="border p-4">Column</div>
  </div>
</div>

Bootstrap rende automaticamente col stackabili su mobile. In Tailwind devi specificarlo così:

<div class="container mx-auto text-center">
  <div class="flex flex-col md:flex-row">
    <div class="flex-1 border p-4">Column</div>
    <div class="flex-1 border p-4">Column</div>
    <div class="flex-1 border p-4">Column</div>
  </div>
</div>



## CSS Flex vs Grid (using Tailwind CSS) | Which to choose?

- [CSS Flex vs Grid (using Tailwind CSS) | Which to choose?](https://www.youtube.com/watch?v=NUDLB5WG_6E)

Nell'immagine `03_fig01-tw_flex_on_email_button` è meglio usare `flex` invece di `grid` perché ci interessa che il pulsante si *adatti al contenuto*, ossia a quello che c'è scritto dentro. In questo caso "Get a demo". Se domani ci voglio scrivere "Get a free demo", usando `flex` il pulsante si allunga da solo. Se invece usavo grid che succedeva? Boh! è da provare.