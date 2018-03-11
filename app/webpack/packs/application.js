import $ from 'jquery'
global.$ = $
global.jQuery = $

import 'bootstrap/dist/js/bootstrap';
import '../src/javascript/sb-admin'

import Rails from 'rails-ujs'
Rails.start()
global.Rails = Rails;

import Turbolinks from 'turbolinks'
Turbolinks.start()
