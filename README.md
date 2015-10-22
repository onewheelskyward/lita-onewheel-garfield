# lita-onewheel-garfield

[![Build Status](https://travis-ci.org/onewheelskyward/lita-onewheel-garfield.png?branch=master)](https://travis-ci.org/onewheelskyward/lita-onewheel-garfield)
[![Coverage Status](https://coveralls.io/repos/onewheelskyward/lita-onewheel-garfield/badge.png)](https://coveralls.io/r/onewheelskyward/lita-onewheel-garfield)
[![Documentation Status](https://readthedocs.org/projects/lita-onewheel-garfield/badge/?version=latest)](https://readthedocs.org/projects/lita-onewheel-garfield/?badge=latest)

Display a Garfield™® comic in IRC.  http://www.garfield.com

## Installation

Add lita-onewheel-garfield to your Lita instance's Gemfile:

``` ruby
gem 'lita-onewheel-garfield'
```

## Usage, command mode (e.g. directed at bot or using config.robot.alias = '!')

garfield random - Get a random garfield comic.

garfield - Get today's garfield, or a random one if you've already seen today's.*

garfield 1/1/1980 - Get a garfield for a m/d/y date.

garfield 1980-1-1 - Get a garfield for a y-m-d date.

garfield 1-1-1980 - Get a garfield for a m-d-y date.

garfield first - Get the first garfield comic.

garfield last - Get the last garfield comic.

garfield today - Get today's garfield comic.

garfield prev - Get the previous day's comic based on the last one you displayed.

garfield next - Get the next day's comic based on the last on you displayed.

\* Coming soon to a Lita handler near you.
