sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'ns/reports/test/integration/FirstJourney',
		'ns/reports/test/integration/pages/ReportsList',
		'ns/reports/test/integration/pages/ReportsObjectPage'
    ],
    function(JourneyRunner, opaJourney, ReportsList, ReportsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('ns/reports') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheReportsList: ReportsList,
					onTheReportsObjectPage: ReportsObjectPage
                }
            },
            opaJourney.run
        );
    }
);