# selected_semantics_ignored

MRE demonstrating that **`Semantics(selected: true)` is not announced by screen readers in Flutter on Linux**.

## The bug

Flutter's `Semantics` widget exposes a `selected` property that is intended to
communicate a "selected" state to assistive technologies — for example:

* a highlighted item in a list
* a pressed/active toggle button
* a selected tab or chip

When `selected: true` is set, Flutter should map this to the AT-SPI
`STATE_SELECTED` flag so that Orca (and other AT-SPI consumers) can announce
"selected" when the user navigates to the widget.

**What actually happens:** Orca never says "selected". The visual highlight
changes correctly, but the accessibility state is not propagated. This is
clearly wrong for:

* `ListTile` with `selected: true` wrapped in `Semantics(selected: true)`
* An `ElevatedButton` wrapped in `Semantics(selected: true)`

The app also includes a plain `Focus` + `Semantics(selected: true)` node for
comparison, though it is less clear whether a non-interactive widget is
expected to expose `STATE_SELECTED` on all platforms.

## How to reproduce

1. Run the app: `flutter run -d linux`
2. Enable Orca.
3. Tab to the selected list item and the toggle button.
4. Observe that Orca announces the label/role but **never** says "selected".

## Expected behaviour

Orca should announce "selected" (or the platform-equivalent phrase) when
focusing a list item or button whose AT-SPI accessibility node carries
`STATE_SELECTED`.

## Workaround

None known. Wrapping with `Semantics(selected: true)` has no observable effect
on what Orca announces.
