$(document).ready(function(){
  calendar();
});

$(document).on('page:load', function() {
  calendar();
});


var calendar = function(){

    // page is now ready, initialize the calendar...


    var today_or_later = function(){
      var check = $('#calendar').fullCalendar('getDate');
      var today = new Date();
      if(check < today) {
        return false;
      } else {
        return true;
      };
    };

    $('#calendar').fullCalendar({
        header: {
				left: 'prev,next today',
				center: 'title',
				right: 'month,agendaWeek,agendaDay'
			},

			eventSources: [{  
    		url: '/bookings',  
   		}],

   		selectable: {
      month: false,
      agenda: true
   	}	,

    editable: false,
    eventStartEditable: false, 
    eventDurationEditable: false,

   	dayClick: function(date, allDay, jsEvent, view) {
      // console.log(view.name);
      if (view.name === "month") { 
        $('#calendar').fullCalendar('gotoDate', date);
        $('#calendar').fullCalendar('changeView', 'agendaDay');
      }
    }
    ,

 		select: function(start, end, allDay) {
        if(today_or_later()) {
        	var length = ((end-start)/(3600000)) * 60;
           alert(length + "select")
          $('#calendar').fullCalendar('renderEvent', 
            {
              start: start,
              end: end,
              allDay: false
            }
          );

          jQuery.post(
            '/bookings',
            
            { booking: {
              start_time: start,
              duration: 2,

          	} }
          );

    	    } else {
            // alert("help!");
        }
    }

	});

};