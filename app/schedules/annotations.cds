using TPEService as service from '../../srv/tpeservice';
annotate service.Schedules with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'name',
                Value : name,
            },
            {
                $Type : 'UI.DataField',
                Label : 'begin',
                Value : begin,
            },
            {
                $Type : 'UI.DataField',
                Label : 'end',
                Value : end,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'Escala',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'end',
            Value : end,
        },
        {
            $Type : 'UI.DataField',
            Label : 'begin',
            Value : begin,
        },
        {
            $Type : 'UI.DataField',
            Label : 'name',
            Value : name,
        },
    ],
);

