require 'bundler'

Bundler.require :default
require File.expand_path('../config/app',  __FILE__)

run Todo::App
