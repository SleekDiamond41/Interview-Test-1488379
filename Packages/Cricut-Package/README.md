#  Cricut-Package

## Products
Cricut-Package is a swift package that implements a simple shape selection experience.
It contains 3 vital products: Core, Interface, and Live. Core and Live depend on
Interface, and Interface depends on nothing. There is also a Bonus product, which is
a pure SwiftUI version of Core. It uses no ViewModels, and its business logic cannot
be validated in unit tests. Still, it's fun to dream of writing simpler code.

* Core contains our Views and ViewModels, and other business logic.
* Live contains our external dependencies. These could be on external libraries
like Firebase, or on Apple frameworks like CoreBluetooth.
* Interface serves as a communication contract between Core and Live.
* The Host app is a minimal launch point that ties together all three

      (This depends on -> that)
        
        
           Host App
         /    |      \
        /     v       \
       / _ Interface _ \
      |  /|         |\  |
      v /             \ v
      Core           Live
         

> Note the use of "protocol witnesses" in the Interface rather than protocols; an idea shamelessly poached [from PointFree](https://www.pointfree.co/blog/posts/21-how-to-control-the-world)

The Interface serves as a contract between Core and Live, essentially between
"our code" and "other code." This contract enables faster build times as the app
grows and deterministic unit testing.


## Testing
Cricut-Package contains two test targets: 
* CoreTests: unit tests, validating our internal business logic
* LiveTests: integration tests, validating our connections to the outside world

Our unit tests are fast and deterministic. A test that passes once will always pass.
These tests can be written to *mathematically prove* correctness of our code; if the
tests pass, any bugs in the app must come from somewhere else (third party libraries,
or even Apple code). Mathematical perfection is rarely worth the effort though, 
so it is acceptable to have a few reasonable tests over most code, with a few 
extras for tricky logic. 

Integration tests are less reliable. We can't control the external world, so we
use these as sanity checks and documentation of what we expect from the outside world.
