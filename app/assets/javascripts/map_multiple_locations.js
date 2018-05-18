let pinInfobox;

function displayInfobox(e) {
  pinInfobox.setOptions({
    title: e.target.Title,
    description: 'test',
    visible: true,
    offset: new Microsoft.Maps.Point(0, 25),
  });
  pinInfobox.setLocation(e.target.getLocation());
}

function GetMap() {
  const locations = [];
  const mapData = [
    { Name: 'The Independence Palace', Latitude: 10.777701, Longitude: 106.695915 },
    { Name: 'Golden Dragon Water Puppet Theater', Latitude: 10.776182, Longitude: 106.692352 },
    { Name: 'Saigon Opera House', Latitude: 10.776506, Longitude: 106.703102 },
    { Name: 'Jaspas Restaurant', Latitude: 10.773610, Longitude: 106.705589 },
  ];
  const infoboxLayer = new Microsoft.Maps.EntityCollection();
  const pinLayer = new Microsoft.Maps.EntityCollection();
  const apiKey = 'AuR1da9qofh51efnw2aHR6coBmMHTltqGO-NlCn3Lwk0oAHY1Qlz_9IcSr02TpuC';
  const map = new Microsoft.Maps.Map('#bingMap', { credentials: apiKey });

  // Create the info box for the pushpin
  pinInfobox = new Microsoft.Maps.Infobox(new Microsoft.Maps.Location(0, 0), { visible: false });
  infoboxLayer.push(pinInfobox);

  mapData.forEach((data) => {
    const location = new Microsoft.Maps.Location(data.Latitude, data.Longitude);
    const pin = new Microsoft.Maps.Pushpin(location);
    locations.push(location);
    pin.Title = data.Name;
    pinLayer.push(pin);
    Microsoft.Maps.Events.addHandler(pin, 'click', displayInfobox);
  });
  map.entities.push(pinLayer);
  map.entities.push(infoboxLayer);

  const bestview = Microsoft.Maps.LocationRect.fromLocations(locations);
  map.setView({ center: bestview.center, zoom: 15 });
}


// function hideInfobox(e) {
//   pinInfobox.setOptions({visible: false});
// }
