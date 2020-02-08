# OpenWallpaper Manager 

This is the complete source code and builds instructions for the OpenWallpaper Manager.
Video demonstration: [YouTube][youtube_manager]

The OpenWallpaper Manager used in combination with the [OpenWallpaper Plasma][wallpaper_plasma_link]. Currently only for the [KDE Plasma][kde_link].

![preview][preview_img]

## Possibilities

* Add, delete packages and read information about the wallpaper package
* Set play or pause, change volume and set up the wallpaper packages to play
* Behavior customization

Using the OpenWallpaper Manager simplifies the packages management. The Manager uses [Qt D-Bus][qt_dbus] for transfer data between itself and plugin. All saved packages are placed in a hidden `/home/.openWallpaper` directory. Also, an above directory contains a configuration file with a log.

## Roadmap

* Send data directly into the wallpaper package
* Cross platforming
* Possibility to change data of the packages

Also, IDE for creating the wallpaper packages is planned

If you have any suggestions or feedback, feel free to email us.

## Build instructions

The following packages must be installed from the official repositories for all distributives:

* [GCC][gcc_link]
* [CMake 3.10][cmake]

The following are the most popular distributives and the name of the packages that you need to install. If you are a user of a little-known distributive, that is not listed below, we recommend you to find and install analogs of these packages.

ATTENTION: Your system should be updated to the last release.
 
First you need download develop dependencies:
 
### Ubuntu

```console
# sudo apt install build-essential qtdeclarative5-dev qtquickcontrols2-5-dev qtmultimedia5-dev
```
### Fedora

```console
# sudo dnf install qt5-qtdeclarative-devel qt5-qtmultimedia-devel qt5-qtquickcontrols2-devel
```
### Arch

```console
# sudo pacman -S qt5-multimedia qt5-quickcontrols2
```

### Build and installing

Now when all the necessary packages are installed, you can proceed with the compilation and installation.

Clone repository with flag `--recursive`. Go to the Open Wallpaper Manager project directory and run the terminal. Now you should create a folder and enter it.

```console
# mkdir build && cd build
```
Run CMake with the following parameters:

```console
# cmake -D CMAKE_INSTALL_PREFIX=/usr ..
```
CMake can show an error if the system doesn’t have the necessary dependencies.

Start building the project:

```console
# cmake -- build. 
```
if you have more than 2 CPU cores or threads you can write `-- -jХ` where X will be a number of cores/threads.
Example: `cmake --build . -- -j4` 

Read cmake output and if the compilation was successful, you can install a plugin in the system directory with the following command:

```console
# sudo make install
```
Success! Now you can run OpenWallpaper Manager like other programs from the menu.

## Examples

There are several demonstration packages available now. You can create your own and publish it on [reddit][reddit_link] community page.

* [Blink][blink] - [QtOpenGL][qt_opengl] wallpaper
* [Winter][winter] - GIF with the music
* [Sunset][sunset] - Video

## Third-party

* [CMake 3.10+][cmake]
* Qt 5.10+ ([LGPL](http://doc.qt.io/qt-5/lgpl.html))
* [Adwaita Icons][adwaita_link]

## Support

Any help in the current moment will be very helpful. If you want to help, you can pick something of proposed options:

* Involvement with the project development
* Creating the wiki pages with needed (as you think) information for users
* Send an email with your idea
* Share information about that project
* Material help. [Donation Alerts][donate_link] and [Patreon][patreon_link]. Also, you can send hardware for testing, we'll be so thankful to you

## Acknowledgments

* [Andrew Origin][andrew_milashka] - help with README
* [Arch linux][telegram_arch_ru] comminity on Telegram - good advices about Linux
* [KDE Plasma][telegram_kde_ru] community on Telegram - ideas
* [Bogdan Kachura][telegram_bogdan] - help with reddit

## Authors

* [Michael Skorohkodov][michael_gh_link] - bakaprogramm29@gmail.com, [twitter][michael_twitter]
* [Felix Lewandowski][felix_gh_link] - acidicmercury8@outlook.com


[//]: # (LINKS)
[cmake]: https://cmake.org/
[wallpaper_plasma_link]: https://github.com/Samsuper12/OpenWallpaper-Plasma
[kde_link]: https://kde.org/plasma-desktop
[qt]: https://www.qt.io/
[qt_opengl]: https://doc.qt.io/qt-5/qopenglfunctions.html
[gcc_link]: https://gcc.gnu.org/
[qt_dbus]: https://doc.qt.io/qt-5/qtdbus-index.html
[preview_img]: docs/preview_gh.png
[adwaita_link]: https://github.com/GNOME/adwaita-icon-theme

[blink]: https://github.com/Samsuper12/Blink
[winter]: https://github.com/Samsuper12/Winter
[sunset]: https://github.com/Samsuper12/Sunset

[donate_link]: https://www.donationalerts.com/r/redbakas
[patreon_link]: https://www.patreon.com/Samsuris
[michael_twitter]: https://twitter.com/Samsuris4
[michael_gh_link]: https://github.com/Samsuper12
[felix_gh_link]: https://github.com/acidicMercury8
[reddit_link]: https://www.reddit.com/r/OpenWallpaper/
[andrew_milashka]: https://github.com/Andrew-Origin
[telegram_arch_ru]: https://t.me/ArchLinuxChatRU
[telegram_kde_ru]: https://t.me/kde_ru
[telegram_bogdan]: https://t.me/desu_pair
[youtube_manager]: https://youtu.be/W6t2PojD7X4
