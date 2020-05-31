// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

require("moment/locale/ja")
require("tempusdominus-bootstrap-4")

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import 'bootstrap';
import '../stylesheets/application';
import '../stylesheets/font-awesome.min';

$(function () {
  $('#startdate').datetimepicker({
    format: "YYYY-MM-DD HH:mm",
    minDate: Date.now(),
    toolbarPlacement: 'top',
    use24hours: true
  });
  $('#enddate').datetimepicker({
    format: "YYYY-MM-DD HH:mm",
    useCurrent: false,
    toolbarPlacement: 'top',
    use24hours: true
  });
  $("#startdate").on("change.datetimepicker", function (e) {
      $('#enddate').datetimepicker('minDate', e.date);
  });
  $("#enddate").on("change.datetimepicker", function (e) {
      $('#startdate').datetimepicker('maxDate', e.date);
  });
});


