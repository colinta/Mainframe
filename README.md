# Mainframe

A very odd calculator app.

The idea for this app came to me when I was brewing beer using a digital thermometer.  I hadn't bothered to hook the thermometer into a microcrontroller, so I was just reading the voltage directly, and calculating the degrees in Fahrenheit.

The formula was pretty simple: (V * 51.2 - 20.5128) * 9 / 5 + 32

Here's what that looks like on Mainframe:

![mainframe demo](http://media.colinta.com/mainframe.png)

Hopefully you can see that all the parts of this formula are editable - each number, and "Voltage" is represented by `x` and assigned off to the side via `x=`

Cool, huh!?

There's special handling for `π` - rather than convert to a number, it is held symbolically for "as long as possible", so calculations involving `cos/sin` can be exact.
