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
## Input and Buttons
Hello, World! is a fine greeting, but what we need is some interaction.

Now we want to give our user the ability to interact with our app. To do this we will add a text input field and a button. When the button is pressed we will do something with the text.

Do you know HTML well? If you do then this will be easy, but if you’re like me and don’t know HTML, then you’ll be learning both Elm and HTML.

To get a text input field and button in Elm we need to describe the HTML, using Elm, that does this. I had to google what these look like in HTML and then guess how they work in Elm, it's pretty straightforward, sort of.

I then hit my first little snag, I want to capture the text that the user is typing, so how is this done. The help in Elm is great but it doesn't help you if you don't know HTML, so I'm backing to googling for help with Html.

I'm now back from learning about Events in Html, ok this make sense. The events are categorized and looking at their names the two that seem promising are *Keyboard Events* and *Form Events*. *Form Events* is what I want and in particular it is the *oninput* event. The HTML help says the *oninput* is an Event Attribute and the Elm help for the *input* tag tells me where to define the attributes.


Here is the basic pattern for an Elm application


o Model - the state of your application
o View - a way to view/render your as state as HTML.
o Update - a way to update your state

The flow of an Elm application

To get things going you need to describe the initial starting state, the *Model*, of your application.

1. Elm will then apply the *View* function that you have defined passing the current state of your application, you then provide back the HTML that Elm should render.
1. Elm then takes care of applying your *Update* function whenever events occur (I'll call them messages from now on), passing it the current state and the message that needs to be handled. Your *Update* function can now evaluate its current state and the message that has been passed, to determine what the new state should be and then providing this back to Elm.
1. Elm will then go back to step #1.

## JSON and HTTP
I don't know about you, but not only do I like interacting with users, I also like interacting with other systems. This is where the JSON and HTML comes into it.

To do this I think I need to use an HTTP GET request, within Elm, to communicate using JSON. But before I do that, I want to understand JSON decoding in Elm. So, what I will start with is decoding a string within Elm, then move onto HTTP.

For my example I will use a list of users, they will have the following attributes: a unique id, unique username, firstname and lastname.

Below is a concrete example of the JSON.

```
[
  {
    "id": 1,
    "username": "bobthebuilder",
    "firstname": "Bob",
    "lastname": "Builder"
  }
]
```

Here is the JSON schema

```
{
  "$schema": "http://json-schema.org/draft-04/schema#",
  "title": "Users",
  "description": "Schema for a list of users",
  "type": "array",
  "items": {
    "type": "object",
    "properties": {
      "id": { "type": "number", "multipleOf": 1, "minimum": 1 },
      "username": { "type": "string"},
      "firstname": { "type": "string"},
      "lastname": { "type": "string"}
    }
  }
}
```


- Initialize the Elm program by passing in a JSON structure containing a list of users.
- Decode a JSON structure using a string defined in the Elm program.
- Decode a JSON structure return from an HTTP request.



