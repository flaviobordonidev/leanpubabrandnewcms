# <a name="top"></a> Cap 1.5 - Installiamo PostgreSQL



## Risorse interne:

- [99-rails_references/postgresql/01-install]



## Risorse esterne

- [a fix for 100vh on mobile devices](https://www.frontend.fyi/v/finally-a-fix-for-100vh-on-mobile)



## Instead of 100vh use 100svh

La soluzione migliore nel 90% dei casi è sostituire `100vh` con `100svh`.

With the introduction of these new units, the fix for the issue has become remarkably straightforward. Depending on your requirements, you can now utilize 100dvh, 100lvh, or 100svh.

By using 100dvh, the element will occupy 100% of the height, adjusting accordingly when the toolbars expand or collapse. On the other hand, 100lvh will maintain a height of 100% even with the toolbars expanded, while 100svh will retain a height of 100% when the toolbars are collapsed.