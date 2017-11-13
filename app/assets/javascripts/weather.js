function getCity(){
  $.ajax({
    type: 'POST',
    url: '/country_cities_select',
    data: {
      country_code: $("#country").val()
    },
    success: function (result){
      $("#city_select").html(result);
    }
  });
};

$(document).on('ready page:load', function () {
  $(document).off("change", "#country").on("change", "#country", getCity);
});