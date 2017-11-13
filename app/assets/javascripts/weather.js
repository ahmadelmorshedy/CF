function getLocation() {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(updateCoordinates);
    }
}

function updateCoordinates(position) {
    $("#lon").val(position.coords.longitude);
    $("#lat").val(position.coords.latitude);
}

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

function userLocationChanged(){
  if ($("#user_location:checked").length > 0) {
    getLocation();
  }
}

$(document).on('ready page:load', function () {
  $(document).off("change", "#country").on("change", "#country", getCity);

  $(document).off("change", "#user_location").on("change", "#user_location", userLocationChanged);
});