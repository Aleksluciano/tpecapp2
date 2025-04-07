using TPEService as service from '../../srv/tpeservice';


annotate service.Reports with @(UI: {
    SelectionFields    : [day],
    PresentationVariant: {
        SortOrder     : [ //Default sort order
            {
                Property  : day,
                Descending: true,
            },
            {
                Property  : point_ID,
                Descending: false,
            },
            {
                Property  : period_name,
                Descending: false,
            }
        ],
        Visualizations: ['@UI.LineItem'],
    },
    LineItem           : [
        {
            $Type                : 'UI.DataField',
            Value                : schedule_name,
            ![@HTML5.CssDefaults]: {width: '10rem'}
        },
        {
            $Type                : 'UI.DataField',
            Value                : day,
            ![@HTML5.CssDefaults]: {width: '10rem'}
        },
        {
            $Type                : 'UI.DataField',
            Value                : dayweek_code,
            ![@HTML5.CssDefaults]: {width: '10rem'}
        },
        {
            $Type                : 'UI.DataField',
            Value                : point_ID,
            ![@HTML5.CssDefaults]: {width: '10rem'}
        },
        {
            $Type                : 'UI.DataField',
            Value                : period_name,
            ![@HTML5.CssDefaults]: {width: '5rem'}
        },
        {
            $Type: 'UI.DataField',
            Value: user_ID,
        },
        {
            $Type: 'UI.DataField',
            Value: user.gender_code,
        }
    ]
});

annotate service.Reports with @(
    UI.FieldGroup #GeneratedGroup1: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: schedule_name,
            },
            {
                $Type: 'UI.DataField',
                Value: day,
            },
            {
                $Type                  : 'UI.DataField',
                Label                  : 'Dia da Semana',
                Value                  : dayweek_code,
                ![@Common.FieldControl]: #ReadOnly
            },
            {
                $Type: 'UI.DataField',
                Value: point_ID,
            },
            {
                $Type: 'UI.DataField',
                Value: period_name,
            },
            {
                $Type: 'UI.DataField',
                Value: user_ID,
            }
        ],
    },
    UI.Facets                     : [{
        $Type : 'UI.ReferenceFacet',
        ID    : 'GeneratedFacet1',
        Label : 'Relatório',
        Target: '@UI.FieldGroup#GeneratedGroup1',
    }, ]
);


annotate service.Reports with {
    schedule @(Common: {ValueList: {
        Label         : 'Escala',
        CollectionPath: 'Schedules',
        Parameters    : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: schedule_name,
            ValueListProperty: 'name'
        }]
    }});
    user     @(Common: {
        Text           : user.name,
        TextArrangement: #TextOnly,
        ValueList      : {
            Label         : 'Usuário',
            CollectionPath: 'Users',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: user_ID,
                    ValueListProperty: 'ID',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'name'
                },

                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'age'
                },

                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'lastdayCount'
                },

                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'dom'
                },

                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'seg'
                },

                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'ter'
                },

                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'qua'
                },

                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'qui'
                },

                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'sex'
                },

                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'sab'
                }
            ]
        }
    });

    point    @(Common: {
        //show text, not id for mitigation in the context of risks
        Text           : point.name,
        TextArrangement: #TextOnly,
        ValueList      : {
            Label         : 'Ponto',
            CollectionPath: 'Points',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: point_ID,
                    ValueListProperty: 'ID'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'name'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'descr'
                }
            ]
        }
    });

    period   @(Common: {
        //show text, not id for mitigation in the context of risks
        Text           : period.descr,
        TextArrangement: #TextOnly,
        ValueList      : {
            Label         : 'Período',
            CollectionPath: 'Periods',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: period_name,
                    ValueListProperty: 'name'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'descr'
                }


            ]
        }
    });

    dayweek  @(Common: {
        Text           : dayweek.day,
        TextArrangement: #TextOnly,
        ValueList      : {
            Label         : 'Days of the Week',
            CollectionPath: 'DaysOfWeek',

            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: dayweek_code,
                    ValueListProperty: 'code'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'day'
                },

            ]
        }
    });
}
