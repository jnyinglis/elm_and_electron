# Elm and Electron

What is Elm? http://elm-lang.org

What is Electron? https://electron.atom.io

## The Plan
What's the plan?...well it's quite simple...start of with the most basic Elm program and the most simple Electron setup, then gradually add enhancements and see how far I can get.

When it starts to get too painful, then I'll stop...or maybe I'll get bored before then, or more likely I'll hit my intellectual barrier!

## Running Electron
Running Electron is straightforward.

Install using npm

```
npm i -g electron
```

[![asciicast](https://asciinema.org/a/VwP7z17M5iwZinoDe0T0X96d7.png)](https://asciinema.org/a/VwP7z17M5iwZinoDe0T0X96d7)

Then run from the command line
```
electron main.js
```

## Hello, World!
The first step here is to create a simple 'Hello, World!' program in Elm and have it run within Electron.

Here are the basics of what's required.

- main.js - This is the Electron bootstap code. This is where we tell Electron to use our index.html file.

- index.html - This is the page we want to display in Electron and is the bootstrap for Elm. This will reference our compiled Elm code, which we will name elm.js

- Main.elm - This is our Elm code. Below is how will compile this to elm.js
```
elm-make Main.elm --output elm.js
```