# Clingo: A grounder and solver for logic programs

Clingo is part of the [Potassco](https://potassco.org) project for *Answer Set
Programming* (ASP).  ASP offers a simple and powerful modeling language to
describe combinatorial problems as *logic programs*.  The *clingo* system then
takes such a logic program and computes *answer sets* representing solutions to
the given problem.  To get an idea, check our [Getting
Started](https://potassco.org/doc/start/) page and the [online
version](https://potassco.org/clingo/run/) of clingo.

Please consult the following resources for further information:

  - [**Downloading source and binary releases**](https://github.com/potassco/clingo/releases)
  - [Changes between releases](CHANGES.md)
  - [Documentation](http://sourceforge.net/projects/potassco/files/guide/)
  - [Potassco clingo page](https://potassco.org/clingo/)


## Contents of Windows Binary Release

The `clingo.exe` and `gringo.exe` binaries are compiled with Lua 5.3 but
without Python support. The `clingo-python.exe` and `gringo-python.exe`
executables are additionally build with Python 2.7 support.

To run the executables, you may have to install the [Visual C++ Redistributable
for Visual Studio 2015](
https://www.microsoft.com/en-us/download/details.aspx?id=48145). When
downloading choose the `vc_redist.x64.exe` executable.

To run the executables with Python support, you have to install [Python 2.7.13
for Windows x86-64](
https://www.python.org/ftp/python/2.7.13/python-2.7.13.amd64.msi).

- `clingo.exe`: solver for non-ground programs
- `clingo-python.exe`: solver for non-ground programs with Python support
- `gringo.exe`: grounder
- `gringo-python.exe`: grounder with Python support
- `clasp.exe`: solver for ground programs
- `reify.exe`: reifier for ground programs
- `lpconvert.exe`: translator for ground formats
- `c-api/`: headers and library of clingo C and C++ API
- `python-api/`: clingo Python 2.7 module
  - to use the module either copy it into the Python path or point the
    [PYTHONPATH](https://docs.python.org/2/using/cmdline.html#envvar-PYTHONPATH)
    to the `python-api` directory
