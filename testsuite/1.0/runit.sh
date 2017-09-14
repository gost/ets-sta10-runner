curl -H "Content-Type: application/json" -X POST -d '{ "description": "thing 1", "name": "thing name 1", "properties": { "reference": "first" }, "Locations": [ { "description": "location 1", "name": "location name 1", "location": { "type": "Point", "coordinates": [ -117.05, 51.05 ] }, "encodingType": "application/vnd.geo+json" } ], "Datastreams": [ { "unitOfMeasurement": { "name": "Lumen", "symbol": "lm", "definition": "http://www.qudt.org/qudt/owl/1.0.0/unit/Instances.html/Lumen" }, "description": "datastream 1", "name": "datastream name 1", "observationType": "http://www.opengis.net/def/observationType/OGC-OM/2.0/OM_Measurement", "ObservedProperty": { "name": "Luminous Flux", "definition": "http://www.qudt.org/qudt/owl/1.0.0/quantity/Instances.html/LuminousFlux", "description": "observedProperty 1" }, "Sensor": { "description": "sensor 1", "name": "sensor name 1", "encodingType": "application/pdf", "metadata": "Light flux sensor" }, "Observations":[ { "phenomenonTime": "2015-03-03T00:00:00Z", "result": 3 }, { "phenomenonTime": "2015-03-04T00:00:00Z", "result": 4 } ] }, { "unitOfMeasurement": { "name": "Centigrade", "symbol": "C", "definition": "http://www.qudt.org/qudt/owl/1.0.0/unit/Instances.html/Lumen" }, "description": "datastream 2", "name": "datastream name 2", "observationType": "http://www.opengis.net/def/observationType/OGC-OM/2.0/OM_Measurement", "ObservedProperty": { "name": "Tempretaure", "definition": "http://www.qudt.org/qudt/owl/1.0.0/quantity/Instances.html/Tempreture", "description": "observedProperty 2" }, "Sensor": { "description": "sensor 2", "name": "sensor name 2", "encodingType": "application/pdf", "metadata": "Tempreture sensor" }, "Observations":[ { "phenomenonTime": "2015-03-05T00:00:00Z", "result": 5 }, { "phenomenonTime": "2015-03-06T00:00:00Z", "result": 6 } ] } ] }' http://gost:8080/v1.0/Things
sta_test_result=$(java -jar testsuite/1.0/ets-sta10-1.0-aio.jar testsuite/1.0/test-run-props.xml)
file=${sta_test_result##*: } 
echo sta_test_runner output: $file
cp $file res.xml
result=$(sed -n '2p'<res.xml)
result=$( echo "$result" | tr '<' '{')
result=$( echo "$result" | tr '>' '}')
result=$( echo "$result" | tr ' ' ',')
result=$( echo "$result" | tr -d '/"')
now=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
echo "res" $result
curl -H "Content-Type: application/json" -X POST -d '{"phenomenonTime": "'$now'","result" : "'$result'","Datastream":{"@iot.id":"166"}}' https://gost.geodan.nl/v1.0/Observations


