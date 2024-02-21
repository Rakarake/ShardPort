The structure of the project has been changed:
* "Everything" is now in the root directory.
* Paths are updated for the new project structure and are now UNIX-style,
  this also works on Windows.
* `Shard.csproj` makes sure that files in *Assets* are copied to the build
  directory. This makes distribution of the game easy (just zip the output
  directory).
* Added 'flake.nix' and 'flake.lock', these make it trivial to run and
  get a development environment (an environment with SDL2 and dotnet8)
  if you have nix on your computer.

