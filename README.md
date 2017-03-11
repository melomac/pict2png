## pict2png

`pict2png` is a simple [PICT](https://en.wikipedia.org/wiki/PICT) to [PNG](https://en.wikipedia.org/wiki/Portable_Network_Graphics) image converter, using a TIFF intermediate representation.


### paint2png

`paint2png` is a simple Mac Paint to [PNG](https://en.wikipedia.org/wiki/Portable_Network_Graphics) image converter. Source code is available as a `pict2png` [branch](https://github.com/melomac/pict2png/tree/paint2png).


### Download

Universal code-signed binaries are available in the [releases](https://github.com/melomac/pict2png/releases) section.


### Install

    $ sudo cp pict2png /usr/local/bin/
    $ sudo cp paint2png /usr/local/bin/


### Usage

    Usage: pict2png image.pict image.png


### Batch processing

    $ ls | while read f ; do pict2png "$f" "$f.png" ; done


