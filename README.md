# Buffet

Buffet is a test distribution framework for Ruby applications. It distributes
your tests across multiple worker machines and runs them in parallel, which
significantly speeds up the testing cycle.

## Installation

Install: `gem install buffet-gem`

## Usage

Run `buffet` from the command line at the top level of your application.

Buffet expects to find a `buffet.yml` file in the same directory which tells it
about the project being tested and what machines it should run on. If you want
to specify a different configuration file, use the --config switch.

Buffet also allows you to specify a name for the project using the --project
switch. This switch is intended to allow multiple runs of the same project
from the same master user, since the project name is used as a namespace to
prevent resource contention.

## Details

If you have a database or other set-up that needs to be prepared before every
test you can create a `bin/before-buffet-run` script in your application's
folder which makes the necessary preparations (you can customize which file
to use by specifying the prepare_script setting in buffet.yml).

Note that bin/before-buffet-run is executed separately from the actual test
running process, so e.g. environment variables will not be preserved. To
customize the test running environment, you can use the worker_command setting.
To set up a specific RVM environment, for example, you could use:

```worker_command: rvm use 1.9.3 && .buffet/buffet-worker```
