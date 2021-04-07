# overview of what happens here

 - we extract the data we need from google xml
 - we add other data from other data source
 - we rebuild a country.json file which is our main data point
 - we build dart files 


for the country.json file generation  (from root dir)

`dart resources/original/generate_countries_json.dart`

for generating dart files (from root dir)

`dart resources/generate_country_data_files.dart`
