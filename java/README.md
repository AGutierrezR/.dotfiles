# SDKMAN

For more documentation about SDKMAN go to [Official page](https://sdkman.io/usage)

## Get a list of available candidates

```bash
sdk list java
```

## Install a specific java version

```bash
sdk install java 21.0.2-tem
```

## Install local version(s)

```bash
sdk install java 17-zulu /Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home
```

This creates a syslink between the indicated folder and the `~/sdkman/Cantidates/Java/17-zulu` folder.

## See the current version in use

```bash
sdk current
```
