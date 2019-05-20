create table user
(
	name text not null,
	password text not null
);

create table item
(
    name text not null,
    rate int not null,
    user text not null
)