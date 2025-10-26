#### Database ERD normalised Diagram
![Database ERD png](airbnb_database_normalized_png.png)

- I largely found that the schema was already 1nf, 2nf and 3nf compliant for the most part
but I separate the location from the property to comply with 1nf so it's city, country and
street name fields are query-able and atomic
