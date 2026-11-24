# HTML patterns — starting points

Generic HTML+CSS for the most common components, written against the `--ds-*` semantic tokens in `ds-tokens.css`. `design-init` writes a project's real tokens under the same names, so these patterns pick up the project's look without changes.

**These are approximations, not the design system.** When `design-context.md` documents a component's anatomy, the anatomy wins: restructure the pattern to match it. When the DS ships its own CSS or a component library, that wins over everything here.

## Rules for every pattern

1. **Zero hardcoded values** — every color, space, size and radius through a `--ds-*` property (U2).
2. **`data-ds-component`** on every DS block, with `data-ds-ref` (identifier from `design-context.md`) and `data-ds-variant` where relevant.
3. **`data-ds-gap="true"`** on every off-DS block, with an inline CSS comment saying what was assumed.
4. **Classes use the `ds-` prefix** and BEM: `.ds-card`, `.ds-card__head`, `.ds-card--featured`.
5. **Zero JavaScript**, unless the spec names an interactive state.

---

## Button

```css
.ds-btn {
  display: inline-flex; align-items: center; justify-content: center; gap: var(--ds-space-2);
  font: inherit; font-size: var(--ds-font-size-body-sm); font-weight: var(--ds-font-weight-medium);
  padding: var(--ds-space-3) var(--ds-space-5);
  border-radius: var(--ds-radius-md); border: 1px solid transparent; cursor: pointer;
}
.ds-btn--primary   { background: var(--ds-color-action-primary); color: var(--ds-color-action-primary-text); }
.ds-btn--primary:hover { background: var(--ds-color-action-primary-hover); }
.ds-btn--secondary { background: var(--ds-color-action-secondary); color: var(--ds-color-action-secondary-text);
                     border-color: var(--ds-color-action-secondary-text); }
.ds-btn--full      { width: 100%; }
.ds-btn:focus-visible { outline: 2px solid var(--ds-color-focus-ring); outline-offset: 2px; }
```

```html
<button class="ds-btn ds-btn--primary" data-ds-component="Button" data-ds-variant="primary">Continue</button>
```

## Text input

```css
.ds-field { display: flex; flex-direction: column; gap: var(--ds-space-1); }
.ds-field__label { font-size: var(--ds-font-size-body-sm); font-weight: var(--ds-font-weight-medium); }
.ds-field__input {
  font: inherit; padding: var(--ds-space-3); border-radius: var(--ds-radius-sm);
  border: 1px solid var(--ds-color-border-strong); background: var(--ds-color-bg-surface);
}
.ds-field__help  { font-size: var(--ds-font-size-caption); color: var(--ds-color-text-secondary); }
.ds-field--error .ds-field__input { border-color: var(--ds-color-error-fg); }
.ds-field--error .ds-field__help  { color: var(--ds-color-error-fg); }
```

```html
<div class="ds-field ds-field--error" data-ds-component="Text input" data-ds-variant="error">
  <label class="ds-field__label" for="email">Email</label>
  <input class="ds-field__input" id="email" type="email" value="anna.rossi@example.test">
  <span class="ds-field__help">Enter a valid email address</span>
</div>
```

The label is always visible — never placeholder-only.

## Card

```css
.ds-card {
  background: var(--ds-color-bg-surface); border: 1px solid var(--ds-color-border-default);
  border-radius: var(--ds-radius-lg); padding: var(--ds-space-5);
  display: flex; flex-direction: column; gap: var(--ds-space-4);
}
.ds-card--featured { border: 2px solid var(--ds-color-border-featured); }
.ds-card__head { display: flex; justify-content: space-between; align-items: center; gap: var(--ds-space-3); }
.ds-card__actions { display: flex; gap: var(--ds-space-3); }
.ds-card__actions > * { flex: 1; }
```

## Alert / inline message

```css
.ds-alert { display: flex; gap: var(--ds-space-3); padding: var(--ds-space-4); border-radius: var(--ds-radius-md); }
.ds-alert--info    { background: var(--ds-color-info-bg);    color: var(--ds-color-info-fg); }
.ds-alert--success { background: var(--ds-color-success-bg); color: var(--ds-color-success-fg); }
.ds-alert--warning { background: var(--ds-color-warning-bg); color: var(--ds-color-warning-fg); }
.ds-alert--error   { background: var(--ds-color-error-bg);   color: var(--ds-color-error-fg); }
```

## Empty state

```css
.ds-empty { text-align: center; padding: var(--ds-space-8) var(--ds-space-5);
            display: flex; flex-direction: column; align-items: center; gap: var(--ds-space-3); }
.ds-empty__title { font-size: var(--ds-font-size-h3); font-weight: var(--ds-font-weight-bold); }
.ds-empty__text  { color: var(--ds-color-text-secondary); max-width: 40ch; }
```

Title says what's empty, text says why and what to do next, one CTA.

## Loader / skeleton

```css
.ds-skeleton { background: var(--ds-color-bg-muted); border-radius: var(--ds-radius-sm); height: 1em; }
.ds-spinner  { width: 32px; height: 32px; border-radius: var(--ds-radius-pill);
               border: 3px solid var(--ds-color-bg-muted); border-top-color: var(--ds-color-action-primary); }
```

## Header

```css
.ds-header { display: flex; align-items: center; justify-content: space-between; gap: var(--ds-space-5);
             padding: var(--ds-space-4) var(--ds-space-5); background: var(--ds-color-bg-surface);
             border-bottom: 1px solid var(--ds-color-border-default); }
.ds-header__logo { width: 120px; height: 32px; background: var(--ds-color-bg-muted);
                   border-radius: var(--ds-radius-sm); }  /* [GAP] logo placeholder — never redrawn (U4) */
.ds-header__nav  { display: flex; gap: var(--ds-space-5); }
.ds-header__burger { display: none; }
@media (max-width: 767px) {
  .ds-header__nav { display: none; }
  .ds-header__burger { display: block; }
}
```

```html
<header class="ds-header" data-ds-component="Header">
  <div class="ds-header__logo" data-ds-gap="true" aria-label="Logo"></div>
  <nav class="ds-header__nav"><a href="#">Products</a><a href="#">Pricing</a><a href="#">Help</a></nav>
  <button class="ds-btn ds-btn--secondary">Sign in</button>
  <button class="ds-header__burger" aria-label="Menu">☰</button>
</header>
```

If `design-context.md` carries a **Live site visual check** for the Header, its nav items, order and CTA text replace the placeholders above.

## Footer

```css
.ds-footer { background: var(--ds-color-bg-inverse); color: var(--ds-color-text-inverse);
             padding: var(--ds-space-6) var(--ds-space-5); font-size: var(--ds-font-size-body-sm); }
.ds-footer a { color: inherit; }
.ds-footer__legal { display: flex; flex-wrap: wrap; gap: var(--ds-space-4); margin-top: var(--ds-space-4); }
```

## Hero (BRAND)

```css
.ds-hero { padding: var(--ds-space-8) var(--ds-space-5); display: grid; gap: var(--ds-space-5);
           grid-template-columns: 1fr; max-width: var(--ds-container-max); margin: 0 auto; }
.ds-hero__title { font-size: var(--ds-font-size-display); line-height: var(--ds-line-height-tight); }
@media (min-width: 992px) { .ds-hero { grid-template-columns: 1.2fr 1fr; align-items: center; } }
```

---

## Device frame

Not a DS component: the presentation device that says "this is inside a site" at a glance (`output-contract.md` rule 11). One wrapper, `.ds-device-frame`, that changes via media query — a browser bar at ≥768px, a phone bezel below. The content stays the same DOM.

```css
body.ds-canvas { margin: 0; background: var(--ds-color-bg-page); padding: var(--ds-space-7) var(--ds-space-6);
                 font-family: var(--ds-font-family); color: var(--ds-color-text-primary); }
.ds-device-frame { max-width: var(--ds-container-max); margin: 0 auto; background: var(--ds-color-bg-surface);
                   border: 1px solid var(--ds-color-border-default); border-radius: var(--ds-radius-lg);
                   overflow: hidden; box-shadow: var(--ds-shadow-md); }
.ds-browser-bar { display: flex; gap: var(--ds-space-2); padding: var(--ds-space-3) var(--ds-space-4);
                  background: var(--ds-color-bg-muted); }
.ds-browser-bar span { width: 9px; height: 9px; border-radius: var(--ds-radius-pill);
                       background: var(--ds-color-border-strong); }
.ds-phone-notch, .ds-phone-home { display: none; }
@media (max-width: 767px) {
  body.ds-canvas { padding: var(--ds-space-5) var(--ds-space-4); }
  .ds-device-frame { max-width: var(--ds-breakpoint-mobile); border: 12px solid var(--ds-color-bg-inverse);
                     border-radius: 44px; box-shadow: var(--ds-shadow-lg); }
  .ds-browser-bar { display: none; }
  .ds-phone-notch { display: block; width: 120px; height: 24px; margin: 0 auto;
                    background: var(--ds-color-bg-inverse); border-radius: 0 0 var(--ds-radius-lg) var(--ds-radius-lg); }
  .ds-phone-home  { display: block; width: 120px; height: 4px; margin: var(--ds-space-3) auto var(--ds-space-2);
                    border-radius: var(--ds-radius-pill); background: var(--ds-color-bg-inverse); opacity: .6; }
}
```

**Don't** put the provenance banner or journey navigation inside the frame — they are review tools, not page content. **Don't** duplicate content into desktop and mobile blocks.

## Screen skeleton

```html
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>&lt;Screen name&gt; — mockup</title>
<link rel="stylesheet" href="assets/ds-tokens.css">
<style>
  /* only the patterns this screen uses */
  .ds-mockup-banner { position: sticky; top: 0; z-index: 999; background: var(--ds-color-bg-inverse);
                      color: var(--ds-color-text-inverse); padding: var(--ds-space-2) var(--ds-space-4);
                      font-size: var(--ds-font-size-caption); text-align: center; }
  @media print { .ds-mockup-banner, .ds-navbar { display: none; } }
</style>
</head>
<body class="ds-canvas" data-journey="A">

<div class="ds-mockup-banner">Mockup generated by spec-to-design · Journey A — … · tokens: … · not production code</div>
<div class="ds-navbar"><!-- index, previous/next, "Screen N of M" --></div>

<div class="ds-device-frame">
  <div class="ds-browser-bar"><span></span><span></span><span></span></div>
  <div class="ds-phone-notch"></div>
  <header class="ds-header" data-ds-component="Header"><!-- see Header --></header>
  <main><!-- screen content --></main>
  <footer class="ds-footer" data-ds-component="Footer"><!-- see Footer --></footer>
  <div class="ds-phone-home"></div>
</div>

</body>
</html>
```

Set `lang` to the spec's output language.
