# Instructions

Management are starting to apply Darwinian principles to a Remote Control Car project.
The developers have been split into two teams, _Red_ and _Blue_, and are tasked with improving the design independently of each other.
They don't need to concern themselves with design decisions of the other team.
You have been asked to take a look at the code and see how you can best combine the two efforts for testing purposes.

## 1. Find a more appropriate way of isolating the code of the two teams

Please use modules to better express the intention of the code.

Currently, important types like `Motor` and `Telemetry`, not to mention `RemoteControlCar` itself, are prefixed with the appropriate team's color `<Color>RemoteControlCarTeam`.
The only purpose of the prefix is to allow types with the same name to coexist in the program.
That is better expressed by using a module.
You will see that, for these purposes, a module has advantages over prefixing types.

## 2. Simplify the naming system

Management requires that the teams should be called "Red Remote Control Car Team" and "Blue Remote Control Car Team" in the definitions, and that these long names should even be used in the code itself.
However, the names are rather cumbersome when referencing the teams.

Find a way to use the shorter identifiers "Red" and "Blue" within the module in which you'll be building the cars.
