# setdate
This program allows you to conveniently and efficiently set the date and time on an Apple II running ProDOS. Ideally, you should avoid having to do this altogether by installing a hardware real-time clock (RTC) along with the proper driver to allow ProDOS to access it. But, if you don't yet have a RTC, this program is for you.

![Setdate Screenshot](pitchers/setdate.png)

# Etymology (which is different from [Entomology](https://en.wikipedia.org/wiki/Entomology))
It is named after the ProDOS [ON_LINE](http://www.easy68k.com/paulrsm/6502/PDOS8TRM.HTM#4.4.6) system call that is used to retrieve volume information.

# Download Binary Executable
See the [releases](https://github.com/gungwald/online/releases) page for a disk image with a binary version that's ready to run.

# Build from Source
#### Requirements
* Windows, Mac, or [Linux](http://getfedora.org) - all the build tools are supported on all 3 platforms
* GNU make - to interpret the Makefile and run the build
* [Merlin32](https://www.brutaldeluxe.fr/products/crossdevtools/merlin/) - to assemble the source code
* [Javer](http://www.java.com) - to run AppleCommander which builds a disk image
#### Process
Type "make".
