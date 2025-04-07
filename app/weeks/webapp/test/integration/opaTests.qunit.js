sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'ns/weeks/test/integration/FirstJourney',
		'ns/weeks/test/integration/pages/WeeksList',
		'ns/weeks/test/integration/pages/WeeksObjectPage'
    ],
    function(JourneyRunner, opaJourney, WeeksList, WeeksObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('ns/weeks') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheWeeksList: WeeksList,
					onTheWeeksObjectPage: WeeksObjectPage
                }
            },
            opaJourney.run
        );
    }
);