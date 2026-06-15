# flat_review_not_supported

MRE demonstrating that **flat review is not supported in Flutter**.

## What is flat review?

Screen readers provide two complementary ways to read content:

* **Focus-based navigation** — the user presses Tab/Shift-Tab to move between
  interactive elements. The screen reader announces each element as it receives
  keyboard focus.
* **Flat review / browse mode** — the user moves a virtual cursor through *all*
  rendered content, regardless of whether it is focusable. In a web browser
  this is the default: arrow keys move through text line-by-line or
  word-by-word. On the Linux desktop Orca provides flat review via keyboard
  shortcuts:
  Depending on your Orca settings you may need to use capslock instead.
  - **Insert + U / I / O** — previous / current / next *line*
  - **Insert + J / K / L** — previous / current / next *word*
  - **Insert + M / , / .** — previous / current / next *character*

## The bug

Flutter exposes no flat-review surface to the platform accessibility APIs.
Orca reports just the name of the window  when
the Flutter window is focused and trying to use flat review, and arrow keys just move through focusable content.

As a result, any content in a plain `Text` widget that is not wrapped in a
`Focus` (or similar) widget is completely **invisible to screen reader users**.
The only content they can reach is content that has received keyboard focus —
effectively limiting access to interactive controls only.
