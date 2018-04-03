import $ from 'jquery';
global.$ = $;
global.jQuery = $;

import 'bootstrap/dist/js/bootstrap';
import 'bootstrap-datepicker/dist/js/bootstrap-datepicker';
import 'chosen-jquery/lib/chosen.jquery';

import Chart from 'chart.js';

import Rails from 'rails-ujs';
Rails.start();
global.Rails = Rails;

import Turbolinks from 'turbolinks';
Turbolinks.start();

import '../src/javascript/sb-admin';
import '../src/javascript/charts';
