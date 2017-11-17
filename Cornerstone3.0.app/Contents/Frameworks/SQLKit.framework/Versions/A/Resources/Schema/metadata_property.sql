CREATE TABLE metadata_property 
(
	key varchar(100) primary key not null,
	value text null
);

CREATE INDEX metadata_property_key_index on metadata_property (key);
