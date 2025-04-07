using {tpens as my} from '../db/schema';

@path           : '/service/tpe'
@cds.query.limit: {
    default: 300,
    max    : 300
}
service TPEService {

    entity Users      as projection on my.UsersTable order by
        name asc;

    annotate Users with @odata.draft.enabled;

    entity Points     as projection on my.PointsTable order by
        name asc;

    annotate Points with @odata.draft.enabled;

    entity Periods    as projection on my.PeriodsTable order by
        name asc;

    annotate Periods with @odata.draft.enabled;
    entity Weeks      as projection on my.WeekTable;
    annotate Weeks with @odata.draft.enabled;
    entity DaysOfWeek as projection on my.DaysOfWeekTable;
    annotate DaysOfWeek with @odata.draft.enabled;

    entity Schedules   as projection on my.ScheduleTable order by
        begin asc;

    annotate Schedules with @odata.draft.enabled;
    entity Reports     as projection on my.ReportTable;
    annotate Reports with @odata.draft.enabled;
    entity Genders     as projection on my.GenTable;
    annotate Genders with @odata.draft.enabled;

}
