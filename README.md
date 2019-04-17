# libpostal's homebrew repo

libpostal is a powerful tool to normalize address using NLP around the world. If you are working like me with messy data (as always here in Chile) it will be very useful to process massive datasets. 

## What is this?

I use macOS and I need a convenient way to use the lib so I built a repo meanwhile a stable version is released.
 
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
