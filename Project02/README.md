# CS1XA3 Project02 - desjarde

## Overview
This web page is Evan Desjardine's custom CV. It is a showcase of the HTML, CSS and JavaScript that has been learned so far, which also describes his various other experiences. It contains various information sections whose visibility can be toggled, as well as links, which alter when hovered over, that lead to relevant references and social medias, plus the ability to enable dark mode.

## Custom JavaScript Code
### Light/Dark Mode Button
This feature sets all the color/background-color attributes throughout the page to the inverse of what they are initially. Once the light/dark button in the top right corner is clicked, the web page mode changes. This is done by finding the RGB color value, using a regex to take only the RGB values out of the string and place them in an array. Then these numbers and converted into a hexadecimal colour tag, which is inverted by setting each character in the hex value to its opposite. (i.e 0=F, 1=E, etc.) Once the inverted colour is found, the attribute is set to that color, and the button changes to be lighter, indicating that another click will return the page to light mode.

### Information Toggle
This feature allows for the user to open and close each of the information sections on the page. If the user hovers over the section title or the arrow, the mouse turns into a pointer, to show that area is clickable. Each title is clickable using it's own id, then on click the information is hidden or shown, based off of it's previous state, and the arrow beside the title that was clicked is rotated accordingly. The arrows also change colors from dark to light mode.

## References
The HTML template for this website was taken from [here](http://www.thomashardy.me.uk/free-responsive-html-css3-cv-template)  
Various aspects of this web page were learned from the HTML, CSS and JavaScript sections of [w3schools](https://www.w3schools.com/)  
Lessons 17-20 from [Programming by Stealth](https://www.bartbusschots.ie/s/blog/programming-by-stealth/)  
Defining the css :hover state in jQuery learned [here](https://stackoverflow.com/questions/21051440/how-to-define-the-css-hover-state-in-a-jquery-selector)  
Changing rgb colours to hexadecimal colour from [here](https://stackoverflow.com/questions/1740700/how-to-get-hex-color-value-rather-than-rgb-value)  
The icons are made by Google and Pixel Perfect from [flaticon.com](https://www.flaticon.com)

