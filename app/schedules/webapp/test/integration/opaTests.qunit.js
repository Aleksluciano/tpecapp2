sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'ns/schedules/test/integration/FirstJourney',
		'ns/schedules/test/integration/pages/SchedulesList',
		'ns/schedules/test/integration/pages/SchedulesObjectPage'
    ],
    function(JourneyRunner, opaJourney, SchedulesList, SchedulesObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('ns/schedules') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheSchedulesList: SchedulesList,
					onTheSchedulesObjectPage: SchedulesObjectPage
                }
            },
            opaJourney.run
        );
    }
);