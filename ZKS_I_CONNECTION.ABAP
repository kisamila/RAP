@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Connection View CDS Data Model'
@Metadata.ignorePropagatedAnnotations: true
@UI.headerInfo: {
    typeName: 'Connection',
    typeNamePlural: 'Connections'
}
@Search.searchable: true
define view entity ZKS_I_CONNECTION
  as select from /dmo/connection as Connection
  association [1..*] to ZKS_I_FLIGHT  as _Flight  on  $projection.CarrierId    = _Flight.CarrierId
                                                  and $projection.ConnectionId = _Flight.ConnectionId
  association [1..1] to ZKS_I_CARRIER as _Carrier on  $projection.CarrierId = _Carrier.CarrierId
{
      @UI.facet: [{ id: 'Connection',
                    purpose: #STANDARD,
                    type: #IDENTIFICATION_REFERENCE,
                    position: 10,
                    label: 'Connection' },
                    { id: 'Flight',
                    purpose: #STANDARD,
                    type: #LINEITEM_REFERENCE,
                    position: 20,
                    label: 'Flight Details',
                    targetElement: '_Flight'
                    } ]
      @ObjectModel.text.association: '_Carrier'
      @UI.identification: [{ position: 10 }]
      @UI.lineItem: [{ position: 10, label: 'Airline' }]
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
  key carrier_id      as CarrierId,
      @Search.defaultSearchElement: true
      @UI.lineItem: [{ position: 20 }]
      @UI.identification: [{ position: 20 }]
  key connection_id   as ConnectionId,
      @UI.selectionField: [{ position: 10 }]
      @UI.lineItem: [{ position: 30, label: 'Airport From' }]
      @UI.identification: [{ position: 30 }]
      @Consumption.valueHelpDefinition: [{ entity: {
          name: 'ZKS_I_AIRPORT_VH',
          element: 'AirportId'
      } }]
      @EndUserText.label: 'Depature Airport ID'
      airport_from_id as AirportFromId,
      @UI.lineItem: [{ position: 40, label: 'Airport To' }]
      @UI.selectionField: [{ position: 20 }]
      @UI.identification: [{ position: 40 }]
      @Consumption.valueHelpDefinition: [{ entity: {
         name: 'ZKS_I_AIRPORT_VH',
         element: 'AirportId'
        } }]
      @EndUserText.label: 'Destination Airport ID'
      airport_to_id   as AirportToId,
      @UI.lineItem: [{ position: 50 }]
      @UI.identification: [{ position: 50 }]
      @UI.selectionField: [{ position: 30 }]
      departure_time  as DepartureTime,
      @UI.lineItem: [{ position: 60 }]
      @UI.identification: [{ position: 60 }]
      arrival_time    as ArrivalTime,
      @UI.lineItem: [{ position: 70 }]
      @UI.identification: [{ position: 70 }]
      @Semantics.quantity.unitOfMeasure: 'DistanceUnit'
      distance        as Distance,
      @UI.identification: [{ position: 80 }]
      distance_unit   as DistanceUnit,
      // Association for the Flight Table.
      @Search.defaultSearchElement: true
      _Flight,
      _Carrier
}
