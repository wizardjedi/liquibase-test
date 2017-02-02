--liquibase formatted sql

--changeset asayapin:test-1
INSERT INTO test4 (name) VALUES ('test');

--rollback delete from test4 where name='test';
