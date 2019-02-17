
This project contains 3 different types of programs that allow you to set the date and time on an Apple II running ProDOS. 

# How to Avoid Using This
Ideally, you should avoid having to set the date manually by installing a hardware real-time clock (RTC) along with the proper driver to allow ProDOS to access it. The NO SLOT CLOCK is the easiest RTC to get today. The name means that it does not require an expansion slot. AppleWin emulates the NO SLOT CLOCK by default. You just have to install the [driver](ftp://ftp.apple.asimov.net/pub/apple_II/images/hardware/clock/NSC_UTILITIES_V14.dsk) to make it work. For real hardware you can buy a [NO SLOT CLOCK](https://www.reactivemicro.com/product/no-slot-clock-from-manila-gear/).

To install the [driver](ftp://ftp.apple.asimov.net/pub/apple_II/images/hardware/clock/NSC_UTILITIES_V14.dsk) you need to arrange the files on your boot disk in this order:
* PRODOS
* NS.CLOCK.SYSTEM (from the driver [disk](ftp://ftp.apple.asimov.net/pub/apple_II/images/hardware/clock/NSC_UTILITIES_V14.dsk))
* BASIC.SYSTEM (or other SYSTEM program that you want to run)

# setdate
![Setdate Screenshot](pitchers/setdate.png)

# dateentryform
![DateEntryForm Screenshot](pitchers/dateentryform.png)

# setdatevalues
![SetDateValues Screenshot](pitchers/setdatevalues.png)

# Download Disk Image
See the [releases](https://github.com/gungwald/setdate/releases) page for a disk image with copies that are ready to run.

# Build from Source
#### Requirements
* Windows, Mac, or [Linux](http://getfedora.org) - all the build tools are supported on all 3 platforms
* GNU make - to interpret the Makefile and run the build
* VirtualBasic from Bitbucket: https://bitbucket.org/andresloz/virtualbasic. You need to pull the 2018-09-25 version using Mercurial. The current "released" version on virtualbasic.org does not have the ability to be used in a make file.
* Python to run VirtualBasic.
* [Javer](http://www.java.com) - to run AppleCommander which builds a disk image
#### Process
Type "make".
