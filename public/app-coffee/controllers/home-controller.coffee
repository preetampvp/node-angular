'use strict'

Home = () ->
  vm = this
  vm.Title = "Hello"

angular.module 'linkedInApp'
.controller('Home', [Home])