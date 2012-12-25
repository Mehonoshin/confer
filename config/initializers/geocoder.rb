# geocoding service (see below for supported options):
Geocoder::Configuration.lookup = :yandex

# to use an API key:
Geocoder::Configuration.api_key = "AE58Uk4BAAAABmRkQgIA1mOl-oVXSbiOdz1CWJoD2Ctd5rEAAAAAAAAAAACsdVyqjM1NwfU9bytvBWvJpLV9BQ=="

# geocoding service request timeout, in seconds (default 3):
Geocoder::Configuration.timeout = 10

# use HTTPS for geocoding service connections:
Geocoder::Configuration.use_https = false

# language to use (for search queries and reverse geocoding):
Geocoder::Configuration.language = :ru
