# Linux (/ maybe MacOS?) Port of Shard

## Dependencies
* dotnet8
* SDL2

## Run using terminal/console on any operating system
`dotnet run` in the project root.

# Build and distribute using terminal/console
`dotnet build --configuration Release` which produces `bin/Release/net8.0-windows/`.
To run this anywhare using the dotnet command: `dotnet Shard.dll` inside
that directory. Note that the working directory must be in this directory
for the game to work.
On windows, you should be able to run 'Shard.exe'.

## Visual Studio
Open 'Shard.csproj' in Visual Studio. Done.
Save the solution if it asks. This file is in the gitignore so wont be commited.

## TODO: test on MacOS

## TODO: test in VSCode

## Nix
If nix is installed on your system and you have flakes enabled, `nix run`
to run, `nix develop` to enter an environment with the dependencies installed.
`nix build` produces 'result', 'result/bin' contains all Shard and all
resource files and can be distributed. Note that your working directory must
be the same as these files.
Note that it is not optimal to use `nix run` for development, as it builds
a clean project.

# Adding more asset folders
If you want more folders in 'Assets', you need to specify those in
'Shard.csproj', look at how this is done for 'Fonts' and do exactly that.
So if you wanted to add 'Tilesets' in 'Assets', add this snippet under
the snippet for fonts.

```xml
<Content Include="Assets\Tilesets\*">
  <CopyToOutputDirectory>PreserveNewest</CopyToOutputDirectory>
</Content>
```

