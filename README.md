# libpostal's homebrew repo

[libpostal](https://github.com/openvenues/libpostal) is a powerful tool to normalize address using NLP around the world.

## What is this?

I use macOS and I need a convenient way to use the lib so I built a repo ~~meanwhile a stable version is released~~.

## Why didn't you submit a Formula to Homebrew?

~~Because they don't allow alpha quality software.~~ Soon!
 
## How can I use it?

```
brew tap robsalasco/libpostal
brew install libpostal
```
## Using posteR with the lib

```
devtools::install_github("ironholds/poster")

library(poster)
normalise_addr("Quatre-vignt-douze Ave des Champs-Élysées")
