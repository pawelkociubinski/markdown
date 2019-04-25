module Normalize exposing (normalize)

import Css exposing (..)
import Css.Global exposing (a, body, button, code, details, each, fieldset, global, h1, hr, html, img, input, legend, optgroup, pre, progress, select, small, strong, summary, textarea, typeSelector)

normalize =
    global
        -- 1. Correct the line height in all browsers.
        -- 2. Prevent adjustments of font size after orientation changes in iOS.
        [ html
            [ lineHeight (num 1.15) -- 1
            , property "-webkit-font-smoothing" "none" -- 2
            ]

        -- Remove the margin in all browsers.
        , body
            [ margin zero ]

        -- Correct the font size and margin on `h1` elements within `section` and `article` contexts in Chrome, Firefox, and Safari.
        , h1
            [ fontSize (em 2)
            , margin2 (em 0.67) (px 0)
            ]

        -- 1. Add the correct box sizing in Firefox.
        -- 2. Show the overflow in Edge and IE.
        , hr
            [ boxSizing contentBox -- 1
            , height (px 0) -- 1
            , overflow visible -- 2
            ]

        -- 1. Correct the inheritance and scaling of font size in all browsers.
        -- 2. Correct the odd `em` font sizing in all browsers.
        , pre
            [ fontFamilies [ "monospace", "monospace" ] -- 1
            , fontSize (em 1)
            ]

        -- Remove the gray background on active links in IE 10.
        , a
            [ backgroundColor transparent ]

        -- 1. Remove the bottom border in Chrome 57-
        -- 2. Add the correct text decoration in Chrome, Edge, IE, Opera, and Safari.
        , typeSelector "abbr[title]"
            [ property "border-bottom" "none" -- 1
            , textDecoration underline -- 2
            , textDecoration2 underline dotted -- 2
            ]

        -- Add the correct font weight in Chrome, Edge, and Safari.
        , each
            [ typeSelector "b"
            , strong
            ]
            [ fontWeight bolder ]

        -- 1. Correct the inheritance and scaling of font size in all browsers.
        -- 2. Correct the odd `em` font sizing in all browsers.
        , each
            [ code
            , typeSelector "kbd"
            , typeSelector "samp"
            ]
            [ fontFamilies [ "monospace", "monospace" ] -- 1
            , fontSize (em 1)
            ]

        -- Add the correct font size in all browsers.
        , small
            [ fontSize (pct 80) ]

        -- Prevent `sub` and `sup` elements from affecting the line height in all browsers.
        , each
            [ typeSelector "sub"
            , typeSelector "sup"
            ]
            [ fontSize (pct 75)
            , lineHeight (num 0)
            , position relative
            , verticalAlign baseline
            ]
        , typeSelector "sub"
            [ bottom (em -0.25) ]
        , typeSelector "sup"
            [ top (em -0.5) ]

        -- Remove the border on images inside links in IE 10.
        , img
            [ borderStyle none ]

        -- 1. Change the font styles in all browsers.
        -- 2. Remove the margin in Firefox and Safari.
        , each
            [ button
            , input
            , optgroup
            , select
            , textarea
            ]
            [ fontFamily inherit -- 1
            , fontSize (pct 100) -- 1
            , lineHeight (num 1.15) -- 1
            , margin (px 0) -- 2
            ]

        -- Show the overflow in IE.
        -- 1. Show the overflow in Edge.
        , each
            [ button
            , input -- 1
            ]
            [ overflow visible ]

        -- Remove the inheritance of text transform in Edge, Firefox, and IE.
        -- 1. Remove the inheritance of text transform in Firefox.
        , each
            [ button
            , select -- 1
            ]
            [ textTransform none ]

        -- Correct the inability to style clickable types in iOS and Safari.
        , each
            [ button
            , typeSelector "[type=\"button\"]"
            , typeSelector "[type=\"reset\"]"
            , typeSelector "[type=\"submit\"]"
            ]
            [ property "-webkit-appearance" "button" ]

        -- Remove the inner border and padding in Firefox.
        , each
            [ typeSelector "button:-moz-focusring"
            , typeSelector "[type=\"button\"]:-moz-focusring"
            , typeSelector "[type=\"reset\"]:-moz-focusring"
            , typeSelector "[type=\"submit\"]:-moz-focusring"
            ]
            [ property "outline" "1px dotted ButtonText" ]

        -- Correct the padding in Firefox.
        , fieldset
            [ padding3 (em 0.35) (em 0.75) (em 0.625) ]

        -- 1. Correct the text wrapping in Edge and IE.
        -- 2. Correct the color inheritance from `fieldset` elements in IE.
        -- 3. Remove the padding so developers are not caught out when they zero out `fieldset` elements in all browsers.
        , legend
            [ boxSizing borderBox -- 1
            , color inherit -- 2
            , display table -- 1
            , maxWidth (Css.pct 100) -- 1
            , padding zero -- 3
            , property "white-space" "normal" -- 1
            ]

        -- Add the correct vertical alignment in Chrome, Firefox, and Opera.
        , progress
            [ verticalAlign baseline ]

        -- Remove the default vertical scrollbar in IE 10+.
        , textarea
            [ overflow auto ]

        -- 1. Add the correct box sizing in IE 10.
        -- 2. Remove the padding in IE 10.
        , each
            [ typeSelector "[type=\"checkbox\"]"
            , typeSelector "[type=\"radio\"]"
            ]
            [ boxSizing borderBox -- 1
            , padding zero -- 2
            ]

        -- Correct the cursor style of increment and decrement buttons in Chrome.
        , each
            [ typeSelector "[type=\"number\"]::-webkit-inner-spin-button"
            , typeSelector "[type=\"number\"]::-webkit-outer-spin-button"
            ]
            [ height auto ]

        -- 1. Correct the odd appearance in Chrome and Safari.
        -- 2. Correct the outline style in Safari.
        , typeSelector "[type=\"search\"]"
            [ property "-webkit-appearance" "textfield" -- 1
            , outlineOffset (px -2) -- 2
            ]

        -- Remove the inner padding in Chrome and Safari on macOS.
        , typeSelector "[type=\"search\"]::-webkit-search-decoration"
            [ property "-webkit-appearance" "none" ]

        -- 1. Correct the inability to style clickable types in iOS and Safari.
        -- 2. Change font properties to `inherit` in Safari.
        , typeSelector "::-webkit-file-upload-button"
            [ property "-webkit-appearance" "button" -- 1
            , property "font" "inherit" -- 2
            ]

        -- Add the correct display in Edge, IE 10+, and Firefox.
        , details
            [ display block ]

        -- Add the correct display in all browsers.
        , summary
            [ display listItem ]

        -- Add the correct display in IE 10+.
        , typeSelector "template"
            [ display none ]

        -- Add the correct display in IE 10.
        , typeSelector "[hidden]"
            [ display none ]
        ]
