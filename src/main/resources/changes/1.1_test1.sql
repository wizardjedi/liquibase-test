--liquibase formatted sql

--changeset asayapin:1
create table test4 (
    id SERIAL primary key,
    name varchar(255)
);
--rollback drop table test4;
