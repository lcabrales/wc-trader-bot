--STATIC DATA TABLES
CREATE TABLE IF NOT EXISTS world (
    id TEXT PRIMARY KEY,
    name VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS map (
    id TEXT PRIMARY KEY,
    name VARCHAR(255),
    world_id TEXT,
    FOREIGN KEY (world_id) REFERENCES world (id)
);

CREATE TABLE IF NOT EXISTS piece (
    id TEXT PRIMARY KEY,
    name VARCHAR(255),
    map_id TEXT,
    FOREIGN KEY (map_id) REFERENCES map (id)
);


-- world INSERT OR IGNORE
INSERT OR IGNORE INTO world (id, name)
VALUES
    ('e32d8743-8e9f-4a95-bd62-97c4b49d45cc', 'Faerieland'),
    ('f93b7a0e-5197-4b14-835b-7b7e97d9ad89', 'Haunted Woods'),
    ('b187ff9f-4dd2-4e2c-98d5-8b398f2c0e13', 'Krawk Island'),
    ('cc02c3dd-4ed0-4ea4-a2c9-92158236e543', 'Kreludor'),
    ('a5f6ebae-4fe2-4d71-9d57-59d69a7866c4', 'Lost Desert'),
    ('3e6b6d15-0f71-42cd-b7dd-92f2f0a8b732', 'Maraqua'),
    ('9d415f4e-8e2b-4b4b-8b4a-10520f35dbf5', 'Meridell'),
    ('5c8aaf57-2480-48e4-96f4-ae144a4f29a4', 'Mystery Island'),
    ('981e1a13-9641-4e1b-9ee2-d30a7f1a5377', 'Neopia Central'),
    ('0f94e0dd-7d7b-43d9-9b50-7cefd56670f3', 'Terror Mountain'),
    ('87655f28-4baf-49d3-a229-5f67d35dca23', 'Tyrannia'),
    ('f42a16b4-cd6e-4ff2-bde4-520fa071a6f9', 'Virtupets');


-- map INSERT OR IGNORE
INSERT OR IGNORE INTO map (id, name, world_id)
VALUES
    ('f7fbad7c-74ef-4545-8057-e636624199ab', 'Kreludor 1', 'e32d8743-8e9f-4a95-bd62-97c4b49d45cc'),
    ('48429fa1-1837-4985-b95e-61c9b87f23bf', 'Kreludor 2', 'e32d8743-8e9f-4a95-bd62-97c4b49d45cc'),
    ('71e01b18-cc02-4ef0-b8d5-0a37f6511fc9', 'Kreludor 3', 'e32d8743-8e9f-4a95-bd62-97c4b49d45cc'),
    ('49131fdf-5a28-4ff1-8060-483c18e19d78', 'Neopia Central 1', 'f93b7a0e-5197-4b14-835b-7b7e97d9ad89'),
    ('e1584181-6f95-4828-8a20-697ea80a934e', 'Neopia Central 2', 'f93b7a0e-5197-4b14-835b-7b7e97d9ad89'),
    ('e16f67df-0fb2-42ad-8416-26eb199bae6c', 'Neopia Central 3', 'f93b7a0e-5197-4b14-835b-7b7e97d9ad89'),
    ('178a40a5-5b46-4e9b-a70d-825680540e4e', 'Haunted Woods 1', 'b187ff9f-4dd2-4e2c-98d5-8b398f2c0e13'),
    ('d1f2ff9e-6a07-4a7d-b470-673b30749262', 'Haunted Woods 2', 'b187ff9f-4dd2-4e2c-98d5-8b398f2c0e13'),
    ('eecb42e2-bfc1-4b5d-b70e-7472f01af5d5', 'Haunted Woods 3', 'b187ff9f-4dd2-4e2c-98d5-8b398f2c0e13'),
    ('0f6e84dd-6226-43b5-a208-692872877b1a', 'Lost Desert 1', 'cc02c3dd-4ed0-4ea4-a2c9-92158236e543'),
    ('07f5d913-c25e-4415-8897-9d295c364db9', 'Lost Desert 2', 'cc02c3dd-4ed0-4ea4-a2c9-92158236e543'),
    ('1baf1099-c262-4a55-9e01-1dc8ee620d2d', 'Lost Desert 3', 'cc02c3dd-4ed0-4ea4-a2c9-92158236e543'),
    ('6f2c76f1-50a6-44db-9f79-24689ebe7080', 'Faerieland 1', 'a5f6ebae-4fe2-4d71-9d57-59d69a7866c4'),
    ('b82b11b1-586f-4db9-b55a-3037265f91ab', 'Faerieland 2', 'a5f6ebae-4fe2-4d71-9d57-59d69a7866c4'),
    ('7fc4d1d7-25c2-4329-a41b-fce8b08df26b', 'Faerieland 3', 'a5f6ebae-4fe2-4d71-9d57-59d69a7866c4'),
    ('d3c3c49f-b66d-4ed2-bbdc-7f5d9a06e6b5', 'Krawk Island 1', '3e6b6d15-0f71-42cd-b7dd-92f2f0a8b732'),
    ('a440f5da-90f6-4d2a-bf2d-5c4d55b11da6', 'Krawk Island 2', '3e6b6d15-0f71-42cd-b7dd-92f2f0a8b732'),
    ('d9ad4821-6e61-43d7-a972-4a9184f2c8c2', 'Krawk Island 3', '3e6b6d15-0f71-42cd-b7dd-92f2f0a8b732'),
    ('e53d355e-3b7f-4a8b-bb9e-56423f26389d', 'Mystery Island 1', '5c8aaf57-2480-48e4-96f4-ae144a4f29a4'),
    ('e674ed97-0ab2-4ab3-bc4c-2523c2abaf4b', 'Mystery Island 2', '5c8aaf57-2480-48e4-96f4-ae144a4f29a4'),
    ('019067d4-3788-42d6-8e7e-d9ac2a51c2fb', 'Mystery Island 3', '5c8aaf57-2480-48e4-96f4-ae144a4f29a4'),
    ('628a9e3d-9e3c-4875-93ef-677f4d882e06', 'Virtupets 1', '981e1a13-9641-4e1b-9ee2-d30a7f1a5377'),
    ('8918f89c-b7f5-47e2-9372-019a216e3a3c', 'Virtupets 2', '981e1a13-9641-4e1b-9ee2-d30a7f1a5377'),
    ('dbac100e-d095-43ad-b03c-8d378a992fdf', 'Virtupets 3', '981e1a13-9641-4e1b-9ee2-d30a7f1a5377'),
    ('9e0cb41b-2397-48c5-8db1-3a25dcb2cb88', 'Meridell 1', '9d415f4e-8e2b-4b4b-8b4a-10520f35dbf5'),
    ('36ce072a-59b0-49ae-9d5b-6bb4fd18cb75', 'Meridell 2', '9d415f4e-8e2b-4b4b-8b4a-10520f35dbf5'),
    ('e55a872d-4db3-4eef-aa45-48a9dc0c77bc', 'Meridell 3', '9d415f4e-8e2b-4b4b-8b4a-10520f35dbf5'),
    ('52d8fc7d-0fd0-4d91-8398-32f61d3b607d', 'Tyrannia 1', '0f94e0dd-7d7b-43d9-9b50-7cefd56670f3'),
    ('78f6f84a-b5f2-41d4-b59f-84ae5be0c274', 'Tyrannia 2', '0f94e0dd-7d7b-43d9-9b50-7cefd56670f3'),
    ('ff1538e2-c1e1-4d91-b738-6b23eeac9d77', 'Tyrannia 3', '0f94e0dd-7d7b-43d9-9b50-7cefd56670f3'),
    ('cd447d68-2497-4b2a-bf5f-28eb6a87c89e', 'Terror Mountain 1', '87655f28-4baf-49d3-a229-5f67d35dca23'),
    ('9de9c81b-aa92-47a5-ba0d-62811f417e4c', 'Terror Mountain 2', '87655f28-4baf-49d3-a229-5f67d35dca23'),
    ('c6d2cde4-7369-42b5-a327-6856ad7a618f', 'Terror Mountain 3', '87655f28-4baf-49d3-a229-5f67d35dca23'),
    ('e7f82b12-fb97-4f6c-9149-30369a7ee84d', 'Maraqua 1', 'f42a16b4-cd6e-4ff2-bde4-520fa071a6f9'),
    ('1ae9b93f-523e-48c1-a0af-10b16e40d97f', 'Maraqua 2', 'f42a16b4-cd6e-4ff2-bde4-520fa071a6f9'),
    ('4e15b8a9-2b07-47c3-bb7e-7ac95af3f16e', 'Maraqua 3', 'f42a16b4-cd6e-4ff2-bde4-520fa071a6f9');


-- piece INSERT OR IGNORE

-- INSERT OR IGNORE values for the piece table
INSERT OR IGNORE INTO piece (id, name, map_id)
VALUES
    ('e5c69d42-bd25-4d25-a4c8-7bc0652d1c2f', '1.1', (SELECT id FROM map WHERE name = 'Kreludor 1')),
    ('35e45d36-30da-44be-9e88-33e2b889c0ef', '1.2', (SELECT id FROM map WHERE name = 'Kreludor 1')),
    ('bc06f4d0-b3b9-46c9-9b11-b7587914b1eb', '1.3', (SELECT id FROM map WHERE name = 'Kreludor 1')),
    ('b50389f0-f2da-4de5-9b7b-1c7fe6f4d684', '1.4', (SELECT id FROM map WHERE name = 'Kreludor 1')),
    ('2272e450-aae9-4e22-9de2-4b5daa6281c2', '1.5', (SELECT id FROM map WHERE name = 'Kreludor 1')),
    ('3f7a3c24-7e02-4a6f-87e9-60dbb920ff8c', '1.6', (SELECT id FROM map WHERE name = 'Kreludor 1')),
    ('b3087a07-013f-4d07-a9f4-7d94d62a8f92', '1.7', (SELECT id FROM map WHERE name = 'Kreludor 1')),
    ('b2d9e3a1-9427-4b4e-9a09-2d6e20a07261', '1.8', (SELECT id FROM map WHERE name = 'Kreludor 1')),
    ('57b9cc6e-2d20-4e4e-a6e0-47af38d59e29', '1.9', (SELECT id FROM map WHERE name = 'Kreludor 1')),
    ('f2ce4e5c-5f6d-4d15-9f0a-4d1039e94ebf', '1.10', (SELECT id FROM map WHERE name = 'Kreludor 1')),
    ('23ad9d3c-8c4f-4c92-a8f9-c5369baf2a07', '1.11', (SELECT id FROM map WHERE name = 'Kreludor 1')),
    ('ea257bc0-670a-4be9-b218-13ccf18c28e9', '1.12', (SELECT id FROM map WHERE name = 'Kreludor 1')),
    ('267f3581-2b7b-4a4a-bc73-bf6bb0a9e4a5', '1.13', (SELECT id FROM map WHERE name = 'Kreludor 1')),
    ('3f7d45e1-d5ce-440e-b03a-88f1f6a3d936', '1.14', (SELECT id FROM map WHERE name = 'Kreludor 1')),
    ('50eb11d9-8e9b-4ed6-bc7f-68a1dddf8b66', '1.15', (SELECT id FROM map WHERE name = 'Kreludor 1')),
    ('9df70cc5-75a0-40f1-9d3b-4e06ff79d4b7', '1.16', (SELECT id FROM map WHERE name = 'Kreludor 1')),
    ('07a1ed4a-39e7-450e-bd42-9899e60a86ea', '1.17', (SELECT id FROM map WHERE name = 'Kreludor 1')),
    ('9f6c549d-12e4-4db3-9c8d-943da2a56c44', '1.18', (SELECT id FROM map WHERE name = 'Kreludor 1')),
    ('6ffdb72e-1064-4d2b-9b60-8ce3f9d0e0ef', '1.19', (SELECT id FROM map WHERE name = 'Kreludor 1')),
    ('fa71c0d2-09a6-4e25-9e44-1c6ff7f9c564', '1.20', (SELECT id FROM map WHERE name = 'Kreludor 1'));

-- INSERT OR IGNORE values for the piece table
INSERT OR IGNORE INTO piece (id, name, map_id)
VALUES
    ('ffaf6877-d476-4e2f-bf29-4a192f0d0a8a', '2.1', (SELECT id FROM map WHERE name = 'Kreludor 2')),
    ('63c0deaf-5321-4b07-8b88-77d719051383', '2.2', (SELECT id FROM map WHERE name = 'Kreludor 2')),
    ('9c567a1d-34ea-4a0e-9d81-50c873184e82', '2.3', (SELECT id FROM map WHERE name = 'Kreludor 2')),
    ('ebcc184e-8bde-49e9-9e97-3d8ff7dc16ab', '2.4', (SELECT id FROM map WHERE name = 'Kreludor 2')),
    ('c9ab9da2-7e34-4b62-b66a-1b1a03a3e46d', '2.5', (SELECT id FROM map WHERE name = 'Kreludor 2')),
    ('59fd54c7-91d1-4f6e-8f62-53634cbfe947', '2.6', (SELECT id FROM map WHERE name = 'Kreludor 2')),
    ('be5e16a2-7462-4a24-9e4b-6890db6fe242', '2.7', (SELECT id FROM map WHERE name = 'Kreludor 2')),
    ('d6a4f120-79e3-4ae9-8a9e-0b38e2de85d9', '2.8', (SELECT id FROM map WHERE name = 'Kreludor 2')),
    ('42c60143-4fd3-4e2e-874d-71d57ab2e888', '2.9', (SELECT id FROM map WHERE name = 'Kreludor 2')),
    ('12fc067c-450d-4ef0-86c1-b5f095c24e53', '2.10', (SELECT id FROM map WHERE name = 'Kreludor 2')),
    ('0bc77d44-5674-4554-8b36-1aef8f826de6', '2.11', (SELECT id FROM map WHERE name = 'Kreludor 2')),
    ('f9f16637-27e9-4077-8a27-8c1f067b4419', '2.12', (SELECT id FROM map WHERE name = 'Kreludor 2')),
    ('a064bd6f-0756-4b85-8e5f-6ff0e6a24b1b', '2.13', (SELECT id FROM map WHERE name = 'Kreludor 2')),
    ('383d2622-18fe-40ce-82f2-60d8e4393f48', '2.14', (SELECT id FROM map WHERE name = 'Kreludor 2')),
    ('041c2a2b-af88-4af6-98ff-7086820f4c36', '2.15', (SELECT id FROM map WHERE name = 'Kreludor 2')),
    ('ab8f1b0a-cda7-4b7b-98f2-56ef8f2f8538', '2.16', (SELECT id FROM map WHERE name = 'Kreludor 2')),
    ('075e42af-2e42-4859-bd3e-5116f8c0a14e', '2.17', (SELECT id FROM map WHERE name = 'Kreludor 2')),
    ('4a5a272f-69a6-4f47-b2e4-d34e72c38c8f', '2.18', (SELECT id FROM map WHERE name = 'Kreludor 2')),
    ('1fc4e9cd-7517-4170-8a06-3dc4177e2952', '2.19', (SELECT id FROM map WHERE name = 'Kreludor 2')),
    ('b50fe7e4-8f6f-4b4a-8f2d-6146bdf63307', '2.20', (SELECT id FROM map WHERE name = 'Kreludor 2'));

-- INSERT OR IGNORE values for the piece table
INSERT OR IGNORE INTO piece (id, name, map_id)
VALUES
    ('fe335f87-7543-4e02-8efc-2a40e9284b87', '3.1', (SELECT id FROM map WHERE name = 'Kreludor 3')),
    ('6c57a623-4b13-4f5a-b66c-82ee57122d7d', '3.2', (SELECT id FROM map WHERE name = 'Kreludor 3')),
    ('9be6d44a-f6ad-4ef8-a7d6-0fc14d13d9f2', '3.3', (SELECT id FROM map WHERE name = 'Kreludor 3')),
    ('2b45d7e7-7a09-4b1b-8af4-409d2a3283c0', '3.4', (SELECT id FROM map WHERE name = 'Kreludor 3')),
    ('4c7c559d-5f20-4c87-84c2-3668aead0669', '3.5', (SELECT id FROM map WHERE name = 'Kreludor 3')),
    ('3126c3fb-6e35-4df1-8841-5ad329e70af1', '3.6', (SELECT id FROM map WHERE name = 'Kreludor 3')),
    ('de3bba17-07ab-4d6a-a301-217d7e5c37f1', '3.7', (SELECT id FROM map WHERE name = 'Kreludor 3')),
    ('4b8f6829-9e44-44f6-91d3-1522545e02e0', '3.8', (SELECT id FROM map WHERE name = 'Kreludor 3')),
    ('8b21e2fd-0674-4fa9-9d39-1654da95b8b6', '3.9', (SELECT id FROM map WHERE name = 'Kreludor 3')),
    ('85de4c82-7871-4a76-95e7-fb94b0178444', '3.10', (SELECT id FROM map WHERE name = 'Kreludor 3')),
    ('d041e312-2ae2-4c99-9b9b-16c84a8332c4', '3.11', (SELECT id FROM map WHERE name = 'Kreludor 3')),
    ('cbdb57b5-5237-48b5-a8eb-c6e7e7e0d7a2', '3.12', (SELECT id FROM map WHERE name = 'Kreludor 3')),
    ('aa49a1a7-6dca-4e22-ae3e-c2439a60d55e', '3.13', (SELECT id FROM map WHERE name = 'Kreludor 3')),
    ('e4a95cfe-9e7e-4f43-89b9-4489f753d0f3', '3.14', (SELECT id FROM map WHERE name = 'Kreludor 3')),
    ('40c5956b-02d2-431a-8b3d-23a97a32f69c', '3.15', (SELECT id FROM map WHERE name = 'Kreludor 3')),
    ('2035e0c2-04b6-4d62-954d-5e7c12e4b0eb', '3.16', (SELECT id FROM map WHERE name = 'Kreludor 3')),
    ('680e2753-d7dd-40f0-bc6c-5e51e1eb9ae6', '3.17', (SELECT id FROM map WHERE name = 'Kreludor 3')),
    ('5b73c6d3-40c4-4090-9762-8296974d9c53', '3.18', (SELECT id FROM map WHERE name = 'Kreludor 3')),
    ('c7e2145d-19a9-4c9b-b62b-9e96f0ab63f7', '3.19', (SELECT id FROM map WHERE name = 'Kreludor 3')),
    ('b8da409d-6978-4f66-9f64-68e6a5e9c95e', '3.20', (SELECT id FROM map WHERE name = 'Kreludor 3'));

-- INSERT OR IGNORE values for the piece table
INSERT OR IGNORE INTO piece (id, name, map_id)
VALUES
    ('556ce7fc-4a92-4fa2-87d2-89cd8a203f70', '1.1', (SELECT id FROM map WHERE name = 'Neopia Central 1')),
    ('8cf7fcbe-92e0-43d1-8045-57dfb5751609', '1.2', (SELECT id FROM map WHERE name = 'Neopia Central 1')),
    ('9a97cad2-72f0-4b07-af87-6174dff402ea', '1.3', (SELECT id FROM map WHERE name = 'Neopia Central 1')),
    ('3f40d108-22d9-4d85-b2cb-f23815e94c7a', '1.4', (SELECT id FROM map WHERE name = 'Neopia Central 1')),
    ('4fde19f6-fe0b-4b7c-8f1c-7a6d4f6cfca3', '1.5', (SELECT id FROM map WHERE name = 'Neopia Central 1')),
    ('5eac163b-a718-4694-bb1b-db8478df0b10', '1.6', (SELECT id FROM map WHERE name = 'Neopia Central 1')),
    ('b0f29e06-835e-4aa2-b8e9-75a8fa75b0ca', '1.7', (SELECT id FROM map WHERE name = 'Neopia Central 1')),
    ('325a407a-cf46-4afa-b902-e1964cf80104', '1.8', (SELECT id FROM map WHERE name = 'Neopia Central 1')),
    ('85676db5-e937-41cf-8c3d-b68bbde29dbf', '1.9', (SELECT id FROM map WHERE name = 'Neopia Central 1')),
    ('9733b7b0-7c6e-41db-8201-227f5871f987', '1.10', (SELECT id FROM map WHERE name = 'Neopia Central 1')),
    ('1dd5bad4-1a8a-4c8f-993d-918b15273346', '1.11', (SELECT id FROM map WHERE name = 'Neopia Central 1')),
    ('ee7b6555-c382-4a9b-afe6-f186bc1b6203', '1.12', (SELECT id FROM map WHERE name = 'Neopia Central 1')),
    ('c0426129-2f9d-4915-a430-8b11379956f4', '1.13', (SELECT id FROM map WHERE name = 'Neopia Central 1')),
    ('f64c437e-6cb9-4ea3-9daf-6421fca7e2cb', '1.14', (SELECT id FROM map WHERE name = 'Neopia Central 1')),
    ('cd5740b0-33dc-4368-abed-473f1c5fe212', '1.15', (SELECT id FROM map WHERE name = 'Neopia Central 1')),
    ('4d9fc95b-e445-499b-8aba-357dbeca0fec', '1.16', (SELECT id FROM map WHERE name = 'Neopia Central 1')),
    ('3ecb3fe3-1406-4a7e-bd7b-25e5bc2a395d', '1.17', (SELECT id FROM map WHERE name = 'Neopia Central 1')),
    ('94adaa83-1731-4b7d-8be6-5f0b27c92f6d', '1.18', (SELECT id FROM map WHERE name = 'Neopia Central 1')),
    ('5059575a-311a-4dda-98c3-aa0350614b3f', '1.19', (SELECT id FROM map WHERE name = 'Neopia Central 1')),
    ('e005883f-9d16-4d12-8a6b-458ea82f9519', '1.20', (SELECT id FROM map WHERE name = 'Neopia Central 1'));

-- INSERT OR IGNORE values for the piece table
INSERT OR IGNORE INTO piece (id, name, map_id)
VALUES
    ('8366d136-d3af-4e30-b460-530d57348897', '2.1', (SELECT id FROM map WHERE name = 'Neopia Central 2')),
    ('7a4dc923-1c15-4d90-85c2-1ea7f37dcdb4', '2.2', (SELECT id FROM map WHERE name = 'Neopia Central 2')),
    ('83abd92a-5041-4f9c-815e-d7009f437f76', '2.3', (SELECT id FROM map WHERE name = 'Neopia Central 2')),
    ('df4edb89-fc08-43c8-8ad6-8fa1d3f2f8a5', '2.4', (SELECT id FROM map WHERE name = 'Neopia Central 2')),
    ('0f31542b-f757-4a12-9ee8-23d4717f08f5', '2.5', (SELECT id FROM map WHERE name = 'Neopia Central 2')),
    ('ae0aaa3c-641a-4813-975d-70500f49d050', '2.6', (SELECT id FROM map WHERE name = 'Neopia Central 2')),
    ('76478c19-a267-4f1a-828b-9a14a409a053', '2.7', (SELECT id FROM map WHERE name = 'Neopia Central 2')),
    ('8024288a-59ee-405e-857e-ead8bcee277d', '2.8', (SELECT id FROM map WHERE name = 'Neopia Central 2')),
    ('33b71ffa-17e7-4d77-9559-2e6dc4dffbb4', '2.9', (SELECT id FROM map WHERE name = 'Neopia Central 2')),
    ('a645bb93-fda7-4aae-aafd-cfe8c38647a0', '2.10', (SELECT id FROM map WHERE name = 'Neopia Central 2')),
    ('876ae836-1a0f-4ef4-bc2f-de521e60c15a', '2.11', (SELECT id FROM map WHERE name = 'Neopia Central 2')),
    ('1996360a-476d-4d43-9f4a-f06f994d1d53', '2.12', (SELECT id FROM map WHERE name = 'Neopia Central 2')),
    ('e3c783a4-5b02-4fec-aa30-09ccc28caef5', '2.13', (SELECT id FROM map WHERE name = 'Neopia Central 2')),
    ('86ea2d16-106b-48d6-83f7-62f73447588a', '2.14', (SELECT id FROM map WHERE name = 'Neopia Central 2')),
    ('d4a5cef6-d8a0-4ee6-aad2-38c04a530ca4', '2.15', (SELECT id FROM map WHERE name = 'Neopia Central 2')),
    ('0c8bad74-900f-40b6-9d2c-ce665a75055a', '2.16', (SELECT id FROM map WHERE name = 'Neopia Central 2')),
    ('7ab0d566-7620-4974-834c-468735244ee2', '2.17', (SELECT id FROM map WHERE name = 'Neopia Central 2')),
    ('3ce52276-7e81-4137-84a8-8eaca1b23088', '2.18', (SELECT id FROM map WHERE name = 'Neopia Central 2')),
    ('86b120f1-caf6-4115-a521-fce717475f3d', '2.19', (SELECT id FROM map WHERE name = 'Neopia Central 2')),
    ('f8f19c6a-2d1d-4973-ab8f-cad62135a8f2', '2.20', (SELECT id FROM map WHERE name = 'Neopia Central 2'));

-- INSERT OR IGNORE values for the piece table
INSERT OR IGNORE INTO piece (id, name, map_id)
VALUES
    ('5eee6ed5-8343-4556-988a-bc9991c30ffc', '3.1', (SELECT id FROM map WHERE name = 'Neopia Central 3')),
    ('ac06d8ea-9f5a-4556-93f1-02bd3b0ba26e', '3.2', (SELECT id FROM map WHERE name = 'Neopia Central 3')),
    ('23ded5f2-d291-47ee-90fd-b71aea604dbe', '3.3', (SELECT id FROM map WHERE name = 'Neopia Central 3')),
    ('6c427684-2c0b-4d28-8a6a-c8ddcf612caa', '3.4', (SELECT id FROM map WHERE name = 'Neopia Central 3')),
    ('aa72dcdc-3679-4a5b-b499-6d243e5a02f0', '3.5', (SELECT id FROM map WHERE name = 'Neopia Central 3')),
    ('351b16d8-8d14-4f2b-aa06-ba148402667d', '3.6', (SELECT id FROM map WHERE name = 'Neopia Central 3')),
    ('65982974-c0ca-4f4c-ab14-53dd51d68fde', '3.7', (SELECT id FROM map WHERE name = 'Neopia Central 3')),
    ('518a3537-88a7-4b9e-a677-e50a257cfaa5', '3.8', (SELECT id FROM map WHERE name = 'Neopia Central 3')),
    ('dbc7c809-fb26-4d58-8b95-a6c0d612de7a', '3.9', (SELECT id FROM map WHERE name = 'Neopia Central 3')),
    ('ef97c8d4-03a0-4531-8d49-356a888699c0', '3.10', (SELECT id FROM map WHERE name = 'Neopia Central 3')),
    ('b256a79b-b2eb-4ebc-9ca3-2ced2fb64240', '3.11', (SELECT id FROM map WHERE name = 'Neopia Central 3')),
    ('22616c5b-4c9f-4e04-bc67-05bbd5f6db00', '3.12', (SELECT id FROM map WHERE name = 'Neopia Central 3')),
    ('dd4f73d7-085e-4426-a3c4-06ff84321233', '3.13', (SELECT id FROM map WHERE name = 'Neopia Central 3')),
    ('a986445e-50cb-4dc2-955f-5253a67e6609', '3.14', (SELECT id FROM map WHERE name = 'Neopia Central 3')),
    ('ab46c95f-6edb-4a72-9981-2ad3e8519f7f', '3.15', (SELECT id FROM map WHERE name = 'Neopia Central 3')),
    ('c45d3d4f-0902-4914-8ac3-a25468aa60eb', '3.16', (SELECT id FROM map WHERE name = 'Neopia Central 3')),
    ('da02da8d-513c-44a0-9b0a-6fb576d811f1', '3.17', (SELECT id FROM map WHERE name = 'Neopia Central 3')),
    ('f879b6aa-2e7a-4d92-a535-047f6406af02', '3.18', (SELECT id FROM map WHERE name = 'Neopia Central 3')),
    ('56c16d99-0bc1-4047-848c-e61a77423fda', '3.19', (SELECT id FROM map WHERE name = 'Neopia Central 3')),
    ('e86e9e6c-397a-46a0-af6a-b0d638b823b2', '3.20', (SELECT id FROM map WHERE name = 'Neopia Central 3'));

-- INSERT OR IGNORE values for the piece table
INSERT OR IGNORE INTO piece (id, name, map_id)
VALUES
    ('4e6ae847-c14e-405c-a5b7-f2e22c6f0e78', '1.1', (SELECT id FROM map WHERE name = 'Haunted Woods 1')),
    ('d083a284-8172-4740-b72c-ceb34e3d6354', '1.2', (SELECT id FROM map WHERE name = 'Haunted Woods 1')),
    ('1ea7b9fb-6b22-4fba-a7bf-8b19620e7ac4', '1.3', (SELECT id FROM map WHERE name = 'Haunted Woods 1')),
    ('dcf29096-fb3c-4b70-9752-73992f1397e6', '1.4', (SELECT id FROM map WHERE name = 'Haunted Woods 1')),
    ('94b32ed8-ea6d-46f3-8a89-2fc1f619bb55', '1.5', (SELECT id FROM map WHERE name = 'Haunted Woods 1')),
    ('c0251fb0-3277-4a89-8962-d0c97ea1064a', '1.6', (SELECT id FROM map WHERE name = 'Haunted Woods 1')),
    ('68f56884-3e20-4474-8d72-1c7a114f0ad9', '1.7', (SELECT id FROM map WHERE name = 'Haunted Woods 1')),
    ('6c61ecc3-ba59-4a73-ba2c-b2f96e6fa9b8', '1.8', (SELECT id FROM map WHERE name = 'Haunted Woods 1')),
    ('8227d22b-3506-4cb3-98d4-5b6e747b3c31', '1.9', (SELECT id FROM map WHERE name = 'Haunted Woods 1')),
    ('ee8e61dc-68b5-453d-8961-063d81371504', '1.10', (SELECT id FROM map WHERE name = 'Haunted Woods 1')),
    ('399b49c9-bb9c-4f5c-a43e-a48bec40147d', '1.11', (SELECT id FROM map WHERE name = 'Haunted Woods 1')),
    ('2d027e9b-52ee-4a5c-b6c8-e1af3fb0673b', '1.12', (SELECT id FROM map WHERE name = 'Haunted Woods 1')),
    ('3eae4e1c-d03b-4224-b356-95c1c26b5e8e', '1.13', (SELECT id FROM map WHERE name = 'Haunted Woods 1')),
    ('a62c699a-c1dd-41b1-8a2a-1128bc2aa5b5', '1.14', (SELECT id FROM map WHERE name = 'Haunted Woods 1')),
    ('e7a8b31b-3f8f-4e86-a8ad-18fd9c7bbf3f', '1.15', (SELECT id FROM map WHERE name = 'Haunted Woods 1')),
    ('29fe6b14-e12a-4c95-b4c5-4dbb46113ad1', '1.16', (SELECT id FROM map WHERE name = 'Haunted Woods 1')),
    ('3c3f6b48-feb6-4cf4-9338-3e4251b0f0bc', '1.17', (SELECT id FROM map WHERE name = 'Haunted Woods 1')),
    ('854a242e-3e5b-44bf-b1fa-16bd3a4f7deb', '1.18', (SELECT id FROM map WHERE name = 'Haunted Woods 1')),
    ('326c4382-3fda-44bf-9b12-ee79b498eb98', '1.19', (SELECT id FROM map WHERE name = 'Haunted Woods 1')),
    ('f0d75509-cf62-441b-af00-3cbc39a34bf9', '1.20', (SELECT id FROM map WHERE name = 'Haunted Woods 1'));

-- INSERT OR IGNORE values for the piece table
INSERT OR IGNORE INTO piece (id, name, map_id)
VALUES
    ('5cc9ac66-c07c-4b38-a870-6969be7f963f', '2.1', (SELECT id FROM map WHERE name = 'Haunted Woods 2')),
    ('5d0ffdda-724e-41bc-b573-7fd0f5c9bd35', '2.2', (SELECT id FROM map WHERE name = 'Haunted Woods 2')),
    ('024e37d5-4177-4c62-bfcf-0aa346ec966f', '2.3', (SELECT id FROM map WHERE name = 'Haunted Woods 2')),
    ('76050896-a57d-413c-b5ce-1df3f87c7bae', '2.4', (SELECT id FROM map WHERE name = 'Haunted Woods 2')),
    ('f59f3363-e34d-41d0-a686-1d7f6a14c71b', '2.5', (SELECT id FROM map WHERE name = 'Haunted Woods 2')),
    ('0849f3a3-7877-4d31-bb7e-0752962bde6f', '2.6', (SELECT id FROM map WHERE name = 'Haunted Woods 2')),
    ('b533aad7-0ced-4c38-b65f-881365114c47', '2.7', (SELECT id FROM map WHERE name = 'Haunted Woods 2')),
    ('f086a30c-105f-4819-b5f0-c069efd76f82', '2.8', (SELECT id FROM map WHERE name = 'Haunted Woods 2')),
    ('698f5b7d-bb7e-4078-9f51-317609186ed3', '2.9', (SELECT id FROM map WHERE name = 'Haunted Woods 2')),
    ('e0664ed6-5922-4890-a96e-fbe99a20d15a', '2.10', (SELECT id FROM map WHERE name = 'Haunted Woods 2')),
    ('81c2ca68-0738-43f1-8660-070a88e2fc29', '2.11', (SELECT id FROM map WHERE name = 'Haunted Woods 2')),
    ('a2e92e98-b0b5-4381-a8b6-2053ed0d0d61', '2.12', (SELECT id FROM map WHERE name = 'Haunted Woods 2')),
    ('8d679ee4-5234-4516-be53-a7e17eea6a6d', '2.13', (SELECT id FROM map WHERE name = 'Haunted Woods 2')),
    ('d7b3f8f6-f061-4aa2-bb7f-f201158bcd8e', '2.14', (SELECT id FROM map WHERE name = 'Haunted Woods 2')),
    ('e76a3681-3370-4c9e-8058-272eb9b83a17', '2.15', (SELECT id FROM map WHERE name = 'Haunted Woods 2')),
    ('f0549468-3f9e-4a80-91bf-4c3c92c88094', '2.16', (SELECT id FROM map WHERE name = 'Haunted Woods 2')),
    ('fb8ced0b-920b-4b70-831d-57ab1bd8dfec', '2.17', (SELECT id FROM map WHERE name = 'Haunted Woods 2')),
    ('39a538c8-19ce-40df-ac89-400a41cfe00e', '2.18', (SELECT id FROM map WHERE name = 'Haunted Woods 2')),
    ('8ef56f18-bdd9-489a-9333-f4e7caa9860c', '2.19', (SELECT id FROM map WHERE name = 'Haunted Woods 2')),
    ('249641a0-d857-4234-8cfd-3ba00a93e08d', '2.20', (SELECT id FROM map WHERE name = 'Haunted Woods 2'));

-- INSERT OR IGNORE values for the piece table
INSERT OR IGNORE INTO piece (id, name, map_id)
VALUES
    ('c7635573-2645-4ed3-8600-ca8dc5ebe2ad', '3.1', (SELECT id FROM map WHERE name = 'Haunted Woods 3')),
    ('6bca08f8-d424-49c6-a887-28ab47424324', '3.2', (SELECT id FROM map WHERE name = 'Haunted Woods 3')),
    ('ebebf538-3875-4758-a3e5-4eaeb776cb1f', '3.3', (SELECT id FROM map WHERE name = 'Haunted Woods 3')),
    ('883b3bcb-46d3-4fcb-8192-eb82dc5203ee', '3.4', (SELECT id FROM map WHERE name = 'Haunted Woods 3')),
    ('22435592-4205-4206-a3fc-c75b115a7acd', '3.5', (SELECT id FROM map WHERE name = 'Haunted Woods 3')),
    ('6c51ca58-65b1-4e79-8bfb-ead17c1834d1', '3.6', (SELECT id FROM map WHERE name = 'Haunted Woods 3')),
    ('3c7b70bb-431c-4fce-8b6a-9c33ba1b06d9', '3.7', (SELECT id FROM map WHERE name = 'Haunted Woods 3')),
    ('6c2e5078-0cff-46ae-ae86-94a55ea73a8b', '3.8', (SELECT id FROM map WHERE name = 'Haunted Woods 3')),
    ('9f7e7502-6afa-427e-a96f-5088e120540b', '3.9', (SELECT id FROM map WHERE name = 'Haunted Woods 3')),
    ('daed04fe-4df9-486a-940b-e7e1ecbab17f', '3.10', (SELECT id FROM map WHERE name = 'Haunted Woods 3')),
    ('12f78ab7-45d1-4527-82fb-8ce2782cc8e5', '3.11', (SELECT id FROM map WHERE name = 'Haunted Woods 3')),
    ('a44e65c9-a243-4df5-aac8-8c0da7b56692', '3.12', (SELECT id FROM map WHERE name = 'Haunted Woods 3')),
    ('98ea5a32-4acb-4f35-aae0-dee22f12f0f4', '3.13', (SELECT id FROM map WHERE name = 'Haunted Woods 3')),
    ('b9b3b6b8-854a-4e50-aa1c-b7ba8cf5edba', '3.14', (SELECT id FROM map WHERE name = 'Haunted Woods 3')),
    ('1cfbb198-6297-4b68-a359-6e4cc22d3360', '3.15', (SELECT id FROM map WHERE name = 'Haunted Woods 3')),
    ('aa83e4a9-ff09-47c4-96bd-aabf5dbea69e', '3.16', (SELECT id FROM map WHERE name = 'Haunted Woods 3')),
    ('1fa2641e-ff8f-4d80-8ca7-c08ebfaf1bfe', '3.17', (SELECT id FROM map WHERE name = 'Haunted Woods 3')),
    ('18ba0dee-84a1-40d8-9fc7-21157b22e1d5', '3.18', (SELECT id FROM map WHERE name = 'Haunted Woods 3')),
    ('e4564390-3ca7-4477-b27c-df508949c694', '3.19', (SELECT id FROM map WHERE name = 'Haunted Woods 3')),
    ('e9549290-b61f-4d89-a28f-fb92784e341f', '3.20', (SELECT id FROM map WHERE name = 'Haunted Woods 3'));

-- INSERT OR IGNORE values for the piece table
INSERT OR IGNORE INTO piece (id, name, map_id)
VALUES
    ('ad66dc20-dbb9-4941-bee6-ae749f59722d', '1.1', (SELECT id FROM map WHERE name = 'Lost Desert 1')),
    ('364988be-7b96-4b86-af5d-08680ef2f07d', '1.2', (SELECT id FROM map WHERE name = 'Lost Desert 1')),
    ('43dca819-a33d-4aad-8a78-bf2ae5a0857e', '1.3', (SELECT id FROM map WHERE name = 'Lost Desert 1')),
    ('01d61267-97aa-475d-9693-0fe7b954f374', '1.4', (SELECT id FROM map WHERE name = 'Lost Desert 1')),
    ('9a93f038-28fc-43a3-9906-f51bd7d940ef', '1.5', (SELECT id FROM map WHERE name = 'Lost Desert 1')),
    ('812ce50e-41f8-4288-856f-df69d00cff12', '1.6', (SELECT id FROM map WHERE name = 'Lost Desert 1')),
    ('7d34fab8-0d40-4293-a2dc-f4a1597de802', '1.7', (SELECT id FROM map WHERE name = 'Lost Desert 1')),
    ('f7fa873d-c425-415f-8ecb-daa201722968', '1.8', (SELECT id FROM map WHERE name = 'Lost Desert 1')),
    ('98cb9d12-4057-4c4b-91a1-1ca36b2c7fa5', '1.9', (SELECT id FROM map WHERE name = 'Lost Desert 1')),
    ('a0b643d5-7c0e-4427-9a0d-6f421500e08a', '1.10', (SELECT id FROM map WHERE name = 'Lost Desert 1')),
    ('f9fe8789-a735-4ac1-bebb-b4f56cffc92a', '1.11', (SELECT id FROM map WHERE name = 'Lost Desert 1')),
    ('5a264132-de31-4a63-b609-6983623935ea', '1.12', (SELECT id FROM map WHERE name = 'Lost Desert 1')),
    ('7484c2ca-2315-4fc9-995e-6fa5db51b236', '1.13', (SELECT id FROM map WHERE name = 'Lost Desert 1')),
    ('0f3650ec-0d41-47d1-8d9a-20fa30bb720d', '1.14', (SELECT id FROM map WHERE name = 'Lost Desert 1')),
    ('6a804908-134a-415a-b3fa-c1a1f2d5faee', '1.15', (SELECT id FROM map WHERE name = 'Lost Desert 1')),
    ('9b0649d3-5ca4-4b82-a2b7-f3cebea7bb34', '1.16', (SELECT id FROM map WHERE name = 'Lost Desert 1')),
    ('4203634c-ef14-48a2-85f1-d6cb60c608da', '1.17', (SELECT id FROM map WHERE name = 'Lost Desert 1')),
    ('d9c8c89b-028d-4770-8035-a624de7ecd06', '1.18', (SELECT id FROM map WHERE name = 'Lost Desert 1')),
    ('217d1d52-87ed-4705-b6c3-a53f8dd861aa', '1.19', (SELECT id FROM map WHERE name = 'Lost Desert 1')),
    ('e909931b-1bc2-4dc8-99f2-46cc507317cb', '1.20', (SELECT id FROM map WHERE name = 'Lost Desert 1'));

-- INSERT OR IGNORE values for the piece table
INSERT OR IGNORE INTO piece (id, name, map_id)
VALUES
    ('3fe2cd4a-b614-4b58-81f4-4cc9252407f7', '2.1', (SELECT id FROM map WHERE name = 'Lost Desert 2')),
    ('62139e44-a7e0-4157-9ff8-c8f1c82d11d1', '2.2', (SELECT id FROM map WHERE name = 'Lost Desert 2')),
    ('fb3940ec-9c7f-4a6d-8ea0-9dc6a2b5efc8', '2.3', (SELECT id FROM map WHERE name = 'Lost Desert 2')),
    ('3e476100-c201-4b9b-8a2e-f31f4077cdf4', '2.4', (SELECT id FROM map WHERE name = 'Lost Desert 2')),
    ('40d1928e-ea2d-4dd7-afe6-62fd5f2d6e5f', '2.5', (SELECT id FROM map WHERE name = 'Lost Desert 2')),
    ('1e1769ad-e606-46b4-a89b-f4b3b9e3587f', '2.6', (SELECT id FROM map WHERE name = 'Lost Desert 2')),
    ('1807b3c2-df53-4671-9d9c-566c84144bed', '2.7', (SELECT id FROM map WHERE name = 'Lost Desert 2')),
    ('a2747b7f-8fec-4759-ac59-19665e209f69', '2.8', (SELECT id FROM map WHERE name = 'Lost Desert 2')),
    ('a9c5baf6-ee9f-490f-b9c6-13d0eb90da8b', '2.9', (SELECT id FROM map WHERE name = 'Lost Desert 2')),
    ('1ab5a6d0-b931-45d6-a08d-f6d01da559eb', '2.10', (SELECT id FROM map WHERE name = 'Lost Desert 2')),
    ('78bc1ec1-1f8c-40dc-8907-dd7c43bf9dad', '2.11', (SELECT id FROM map WHERE name = 'Lost Desert 2')),
    ('9611d13f-be9c-41f0-8e88-5cdaaadc4ec2', '2.12', (SELECT id FROM map WHERE name = 'Lost Desert 2')),
    ('29952550-e8f1-49df-a3c7-8e552ecbc04e', '2.13', (SELECT id FROM map WHERE name = 'Lost Desert 2')),
    ('7c257617-3618-4a40-a0e2-37547a3766eb', '2.14', (SELECT id FROM map WHERE name = 'Lost Desert 2')),
    ('9d9ea097-0ad2-49a6-a53f-cbfef808c28c', '2.15', (SELECT id FROM map WHERE name = 'Lost Desert 2')),
    ('70522f80-4c28-429f-be7d-69d9a7c9f999', '2.16', (SELECT id FROM map WHERE name = 'Lost Desert 2')),
    ('b7a13a6a-fdd8-4194-b55d-e7f9bc6e159c', '2.17', (SELECT id FROM map WHERE name = 'Lost Desert 2')),
    ('092d4d22-967b-4cfb-a474-55d3b42de0e0', '2.18', (SELECT id FROM map WHERE name = 'Lost Desert 2')),
    ('1e2f2be9-97e3-4a3c-b1f4-d6082cc1f59e', '2.19', (SELECT id FROM map WHERE name = 'Lost Desert 2')),
    ('17f85706-d935-42de-9197-d8b4494520f5', '2.20', (SELECT id FROM map WHERE name = 'Lost Desert 2'));

-- INSERT OR IGNORE values for the piece table
INSERT OR IGNORE INTO piece (id, name, map_id)
VALUES
    ('3fe2cd4a-b614-4b58-81f4-4cc9252407f7', '3.1', (SELECT id FROM map WHERE name = 'Lost Desert 3')),
    ('62139e44-a7e0-4157-9ff8-c8f1c82d11d1', '3.2', (SELECT id FROM map WHERE name = 'Lost Desert 3')),
    ('fb3940ec-9c7f-4a6d-8ea0-9dc6a2b5efc8', '3.3', (SELECT id FROM map WHERE name = 'Lost Desert 3')),
    ('3e476100-c201-4b9b-8a2e-f31f4077cdf4', '3.4', (SELECT id FROM map WHERE name = 'Lost Desert 3')),
    ('40d1928e-ea2d-4dd7-afe6-62fd5f2d6e5f', '3.5', (SELECT id FROM map WHERE name = 'Lost Desert 3')),
    ('1e1769ad-e606-46b4-a89b-f4b3b9e3587f', '3.6', (SELECT id FROM map WHERE name = 'Lost Desert 3')),
    ('1807b3c2-df53-4671-9d9c-566c84144bed', '3.7', (SELECT id FROM map WHERE name = 'Lost Desert 3')),
    ('a2747b7f-8fec-4759-ac59-19665e209f69', '3.8', (SELECT id FROM map WHERE name = 'Lost Desert 3')),
    ('a9c5baf6-ee9f-490f-b9c6-13d0eb90da8b', '3.9', (SELECT id FROM map WHERE name = 'Lost Desert 3')),
    ('1ab5a6d0-b931-45d6-a08d-f6d01da559eb', '3.10', (SELECT id FROM map WHERE name = 'Lost Desert 3')),
    ('78bc1ec1-1f8c-40dc-8907-dd7c43bf9dad', '3.11', (SELECT id FROM map WHERE name = 'Lost Desert 3')),
    ('9611d13f-be9c-41f0-8e88-5cdaaadc4ec2', '3.12', (SELECT id FROM map WHERE name = 'Lost Desert 3')),
    ('29952550-e8f1-49df-a3c7-8e552ecbc04e', '3.13', (SELECT id FROM map WHERE name = 'Lost Desert 3')),
    ('7c257617-3618-4a40-a0e2-37547a3766eb', '3.14', (SELECT id FROM map WHERE name = 'Lost Desert 3')),
    ('9d9ea097-0ad2-49a6-a53f-cbfef808c28c', '3.15', (SELECT id FROM map WHERE name = 'Lost Desert 3')),
    ('70522f80-4c28-429f-be7d-69d9a7c9f999', '3.16', (SELECT id FROM map WHERE name = 'Lost Desert 3')),
    ('b7a13a6a-fdd8-4194-b55d-e7f9bc6e159c', '3.17', (SELECT id FROM map WHERE name = 'Lost Desert 3')),
    ('092d4d22-967b-4cfb-a474-55d3b42de0e0', '3.18', (SELECT id FROM map WHERE name = 'Lost Desert 3')),
    ('1e2f2be9-97e3-4a3c-b1f4-d6082cc1f59e', '3.19', (SELECT id FROM map WHERE name = 'Lost Desert 3')),
    ('17f85706-d935-42de-9197-d8b4494520f5', '3.20', (SELECT id FROM map WHERE name = 'Lost Desert 3'));

-- INSERT OR IGNORE values for the piece table
INSERT OR IGNORE INTO piece (id, name, map_id)
VALUES
    ('ba8ecaea-1f95-4299-a626-8b67d955243e', '1.1', (SELECT id FROM map WHERE name = 'Faerieland 1')),
    ('4758531c-626c-44e8-8e8c-25c38903a9fe', '1.2', (SELECT id FROM map WHERE name = 'Faerieland 1')),
    ('883c2322-8a4d-44c7-8213-286629ce6f73', '1.3', (SELECT id FROM map WHERE name = 'Faerieland 1')),
    ('063833cc-751a-426a-805f-20a6eae3b6f4', '1.4', (SELECT id FROM map WHERE name = 'Faerieland 1')),
    ('d51cd085-9451-4ca3-a34e-fbab1de2aa87', '1.5', (SELECT id FROM map WHERE name = 'Faerieland 1')),
    ('f71cc3dc-2402-45d0-9a2e-99392fd9220f', '1.6', (SELECT id FROM map WHERE name = 'Faerieland 1')),
    ('235a90ed-3f69-4bed-a8fd-64291a481ffe', '1.7', (SELECT id FROM map WHERE name = 'Faerieland 1')),
    ('b732dbd9-1028-4452-8e25-ba88efc69233', '1.8', (SELECT id FROM map WHERE name = 'Faerieland 1')),
    ('0e88eeed-57f3-4a8c-9aa2-02872e156b4b', '1.9', (SELECT id FROM map WHERE name = 'Faerieland 1')),
    ('9a576ce6-ba6d-466a-9381-3ddb2432335b', '1.10', (SELECT id FROM map WHERE name = 'Faerieland 1')),
    ('b0fdd433-5c00-4347-9f48-e7db8d971707', '1.11', (SELECT id FROM map WHERE name = 'Faerieland 1')),
    ('7a201e92-21e5-48c5-b2a9-07c11dae6bec', '1.12', (SELECT id FROM map WHERE name = 'Faerieland 1')),
    ('aec6cb9c-8df4-4d31-a898-61a05447700f', '1.13', (SELECT id FROM map WHERE name = 'Faerieland 1')),
    ('3c2929cb-275f-450f-a788-79b5e520b195', '1.14', (SELECT id FROM map WHERE name = 'Faerieland 1')),
    ('6a000ce3-7005-4be2-be4b-6c777eea6bef', '1.15', (SELECT id FROM map WHERE name = 'Faerieland 1')),
    ('e64d9029-c74c-48a0-a0f8-dddf669a05e9', '1.16', (SELECT id FROM map WHERE name = 'Faerieland 1')),
    ('15c74fe0-7cfe-4c37-ac4a-31111042444d', '1.17', (SELECT id FROM map WHERE name = 'Faerieland 1')),
    ('d430e18d-78f5-41c1-a5be-29c4be269a0e', '1.18', (SELECT id FROM map WHERE name = 'Faerieland 1')),
    ('5a1009df-55ca-4c3f-ae2e-1f26e5e17e69', '1.19', (SELECT id FROM map WHERE name = 'Faerieland 1')),
    ('2e1cb2b0-21c0-4d2b-8a4f-ea4469f8b318', '1.20', (SELECT id FROM map WHERE name = 'Faerieland 1'));

-- INSERT OR IGNORE values for the piece table
INSERT OR IGNORE INTO piece (id, name, map_id)
VALUES
    ('feae758a-986b-4eb8-8441-eacb3f50c506', '2.1', (SELECT id FROM map WHERE name = 'Faerieland 2')),
    ('900a59ca-db0a-4867-ac34-e241405f46cb', '2.2', (SELECT id FROM map WHERE name = 'Faerieland 2')),
    ('04603733-2497-42ba-b9ee-2bdbf37275ee', '2.3', (SELECT id FROM map WHERE name = 'Faerieland 2')),
    ('1e2d85e0-286b-4f18-afdc-4a967ec3cbe2', '2.4', (SELECT id FROM map WHERE name = 'Faerieland 2')),
    ('bd96a1b2-6465-4bfb-87ae-56bb31a383f7', '2.5', (SELECT id FROM map WHERE name = 'Faerieland 2')),
    ('d04427ea-d7ca-461c-9db7-4b754b009d6b', '2.6', (SELECT id FROM map WHERE name = 'Faerieland 2')),
    ('435355a4-7098-494d-bdb9-ef5614035e3f', '2.7', (SELECT id FROM map WHERE name = 'Faerieland 2')),
    ('17879847-b55e-42c1-b2e0-7497d377b82c', '2.8', (SELECT id FROM map WHERE name = 'Faerieland 2')),
    ('d103dbc1-a9df-402c-a0e0-201e772e84bf', '2.9', (SELECT id FROM map WHERE name = 'Faerieland 2')),
    ('811ee2a0-1973-4b07-a9ea-bc1b0a87546f', '2.10', (SELECT id FROM map WHERE name = 'Faerieland 2')),
    ('de978f58-5da2-4ceb-93f2-95f5d9e24904', '2.11', (SELECT id FROM map WHERE name = 'Faerieland 2')),
    ('43cca21a-a491-43e0-bbd3-7519486beb99', '2.12', (SELECT id FROM map WHERE name = 'Faerieland 2')),
    ('bb805a9b-73ed-4347-8420-40683639137c', '2.13', (SELECT id FROM map WHERE name = 'Faerieland 2')),
    ('794001e3-da64-48a8-a920-84d5b5a5401b', '2.14', (SELECT id FROM map WHERE name = 'Faerieland 2')),
    ('82f88620-014c-4848-a953-01ea70f8d1b9', '2.15', (SELECT id FROM map WHERE name = 'Faerieland 2')),
    ('68ea3599-0f4e-485c-bf23-c3865f3231b6', '2.16', (SELECT id FROM map WHERE name = 'Faerieland 2')),
    ('9730d79b-05c2-46f2-8fa3-131dd90663e7', '2.17', (SELECT id FROM map WHERE name = 'Faerieland 2')),
    ('0aedc0b8-8cee-44c7-a52e-4fb318ce0e99', '2.18', (SELECT id FROM map WHERE name = 'Faerieland 2')),
    ('bc837ed0-2f37-44e8-bce3-743aca7ca4b7', '2.19', (SELECT id FROM map WHERE name = 'Faerieland 2')),
    ('67afdd94-8434-4e31-9f84-56099bcecd49', '2.20', (SELECT id FROM map WHERE name = 'Faerieland 2'));

-- INSERT OR IGNORE values for the piece table
INSERT OR IGNORE INTO piece (id, name, map_id)
VALUES
    ('752347f9-3acb-4727-8f04-6e555e9de20e', '3.1', (SELECT id FROM map WHERE name = 'Faerieland 3')),
    ('69fc2b09-5626-426a-b281-cd1d3e237a45', '3.2', (SELECT id FROM map WHERE name = 'Faerieland 3')),
    ('7f577eeb-dcf9-4642-af67-58b7691a7ad0', '3.3', (SELECT id FROM map WHERE name = 'Faerieland 3')),
    ('63d5166d-6f74-47d9-8116-f0aa70e585ea', '3.4', (SELECT id FROM map WHERE name = 'Faerieland 3')),
    ('b39854ac-463d-4f5e-aff0-961195c8b6ef', '3.5', (SELECT id FROM map WHERE name = 'Faerieland 3')),
    ('cedd571f-a80b-40a7-8449-b948373430c9', '3.6', (SELECT id FROM map WHERE name = 'Faerieland 3')),
    ('6a19be88-911c-4331-bb0c-08bf5473bdcf', '3.7', (SELECT id FROM map WHERE name = 'Faerieland 3')),
    ('5566f38e-d83a-4afc-9df5-21f984dacb4f', '3.8', (SELECT id FROM map WHERE name = 'Faerieland 3')),
    ('65246b8f-ec51-448a-a63b-5c207bc36af4', '3.9', (SELECT id FROM map WHERE name = 'Faerieland 3')),
    ('278a15c8-587f-4963-a0b0-a01417bf9f92', '3.10', (SELECT id FROM map WHERE name = 'Faerieland 3')),
    ('00a41b27-63a5-4e84-8ca3-ebccab2abc8a', '3.11', (SELECT id FROM map WHERE name = 'Faerieland 3')),
    ('511bbf6a-3f7a-488f-9f0c-4c515fcfc5e8', '3.12', (SELECT id FROM map WHERE name = 'Faerieland 3')),
    ('e1266fd0-afc5-40b5-a3fe-31c974f86441', '3.13', (SELECT id FROM map WHERE name = 'Faerieland 3')),
    ('bbe6aacc-8b30-4bd3-aa51-519e828aea3b', '3.14', (SELECT id FROM map WHERE name = 'Faerieland 3')),
    ('f31bc09f-015f-4062-9655-7b3df5329caa', '3.15', (SELECT id FROM map WHERE name = 'Faerieland 3')),
    ('2831b768-ce9d-41fb-968c-383ec5f3a572', '3.16', (SELECT id FROM map WHERE name = 'Faerieland 3')),
    ('220b7289-86e6-489c-9d3c-5103d8a3dd7c', '3.17', (SELECT id FROM map WHERE name = 'Faerieland 3')),
    ('75a1f502-6609-4917-b89c-7fae7b337c09', '3.18', (SELECT id FROM map WHERE name = 'Faerieland 3')),
    ('6c7117cc-f646-4a7b-9afa-c5bb7bdf089d', '3.19', (SELECT id FROM map WHERE name = 'Faerieland 3')),
    ('3516abf2-41a5-488e-bef7-f4f16d75a921', '3.20', (SELECT id FROM map WHERE name = 'Faerieland 3'));

-- INSERT OR IGNORE values for the piece table
INSERT OR IGNORE INTO piece (id, name, map_id)
VALUES
    ('9de73900-ca4c-46c7-bf3b-2ace001d5d83', '1.1', (SELECT id FROM map WHERE name = 'Krawk Island 1')),
    ('c55e929c-f340-4450-8cb9-4fe76aad8cec', '1.2', (SELECT id FROM map WHERE name = 'Krawk Island 1')),
    ('79ed9318-5251-403a-bb36-b93219b923e6', '1.3', (SELECT id FROM map WHERE name = 'Krawk Island 1')),
    ('54115b26-ae13-49ab-ab0a-89765e569884', '1.4', (SELECT id FROM map WHERE name = 'Krawk Island 1')),
    ('2f76174b-9ecb-4777-897f-eaa93a265e36', '1.5', (SELECT id FROM map WHERE name = 'Krawk Island 1')),
    ('2860eb48-1eaa-4a9a-b771-9947ae7a1c7c', '1.6', (SELECT id FROM map WHERE name = 'Krawk Island 1')),
    ('210e080e-696f-49ea-b9df-ada7f3ff36da', '1.7', (SELECT id FROM map WHERE name = 'Krawk Island 1')),
    ('620db207-a9b4-4b50-ac52-4e391c80a800', '1.8', (SELECT id FROM map WHERE name = 'Krawk Island 1')),
    ('78742f01-0ff4-4c0b-849e-ba79046312c7', '1.9', (SELECT id FROM map WHERE name = 'Krawk Island 1')),
    ('11d92822-f468-4a87-8c4e-47c2f9079e4c', '1.10', (SELECT id FROM map WHERE name = 'Krawk Island 1')),
    ('7be0d0c2-dc7a-4110-8eba-4524a1ecf885', '1.11', (SELECT id FROM map WHERE name = 'Krawk Island 1')),
    ('6c1d6ba6-8146-47c4-9300-49f8bb82b6f2', '1.12', (SELECT id FROM map WHERE name = 'Krawk Island 1')),
    ('b01a16a2-d59f-4ec2-be5e-28ab06702a28', '1.13', (SELECT id FROM map WHERE name = 'Krawk Island 1')),
    ('1e84e2b0-fac3-4120-b592-a7607f2be826', '1.14', (SELECT id FROM map WHERE name = 'Krawk Island 1')),
    ('b435e0fc-55c9-4d35-9711-79553081feb5', '1.15', (SELECT id FROM map WHERE name = 'Krawk Island 1')),
    ('e64bafb2-76df-4d75-9395-40da0729879a', '1.16', (SELECT id FROM map WHERE name = 'Krawk Island 1')),
    ('c6c2fb22-b4f6-49b0-bcd7-a8ae4facf0f8', '1.17', (SELECT id FROM map WHERE name = 'Krawk Island 1')),
    ('7cc70274-5c93-46a9-ae1e-79e9e8b294b1', '1.18', (SELECT id FROM map WHERE name = 'Krawk Island 1')),
    ('c1570001-8553-436d-82d2-224adcb9dbd4', '1.19', (SELECT id FROM map WHERE name = 'Krawk Island 1')),
    ('c812ff74-f41e-4b14-9254-c6b13b6037ed', '1.20', (SELECT id FROM map WHERE name = 'Krawk Island 1'));

-- INSERT OR IGNORE values for the piece table
INSERT OR IGNORE INTO piece (id, name, map_id)
VALUES
    ('813aa449-b1ba-453b-8275-1b97cbe92329', '2.1', (SELECT id FROM map WHERE name = 'Krawk Island 2')),
    ('3944ec3e-2f83-4b29-b9cb-5cb7494e90d8', '2.2', (SELECT id FROM map WHERE name = 'Krawk Island 2')),
    ('ad8f1f29-cf2e-4326-8eb2-b3c1be9c66d3', '2.3', (SELECT id FROM map WHERE name = 'Krawk Island 2')),
    ('bbadd659-4213-4f4f-876a-3f51ccc49e44', '2.4', (SELECT id FROM map WHERE name = 'Krawk Island 2')),
    ('2c7d7e12-ff84-424f-a73e-806648fb531c', '2.5', (SELECT id FROM map WHERE name = 'Krawk Island 2')),
    ('ca8a901f-e041-47ae-8345-4d964e17f541', '2.6', (SELECT id FROM map WHERE name = 'Krawk Island 2')),
    ('e21158ce-b3ea-4bad-8b25-aa100e5333a7', '2.7', (SELECT id FROM map WHERE name = 'Krawk Island 2')),
    ('d1ed93ff-e79f-4208-a0c4-d0d48102e74b', '2.8', (SELECT id FROM map WHERE name = 'Krawk Island 2')),
    ('bb387ac4-1d5d-4466-ad4d-dc17fe41a058', '2.9', (SELECT id FROM map WHERE name = 'Krawk Island 2')),
    ('ac3cfd73-d80f-4b3d-bc24-1e043b970fe8', '2.10', (SELECT id FROM map WHERE name = 'Krawk Island 2')),
    ('cdf57380-ab0d-4888-ba18-5bcdaa0c7379', '2.11', (SELECT id FROM map WHERE name = 'Krawk Island 2')),
    ('7c952ddf-adaf-4e62-98a1-24555663d18f', '2.12', (SELECT id FROM map WHERE name = 'Krawk Island 2')),
    ('d307ce55-784f-4fd4-94d2-31fa592d7718', '2.13', (SELECT id FROM map WHERE name = 'Krawk Island 2')),
    ('48304a88-c406-45c6-9ff0-32234f48e0e0', '2.14', (SELECT id FROM map WHERE name = 'Krawk Island 2')),
    ('3ffa507c-049d-4897-b09d-fa708cdc8b03', '2.15', (SELECT id FROM map WHERE name = 'Krawk Island 2')),
    ('425552ac-9a70-4ad2-a158-e91b5e97226c', '2.16', (SELECT id FROM map WHERE name = 'Krawk Island 2')),
    ('bd0236b9-2fbe-44bf-ba0b-d76a5235795a', '2.17', (SELECT id FROM map WHERE name = 'Krawk Island 2')),
    ('32b82b6c-958e-42b6-bf73-e07173455eae', '2.18', (SELECT id FROM map WHERE name = 'Krawk Island 2')),
    ('81c23ebd-5ed1-4b0e-9f19-dcaad6a90b92', '2.19', (SELECT id FROM map WHERE name = 'Krawk Island 2')),
    ('c254fcaf-8fde-488c-ac5a-98332669c62f', '2.20', (SELECT id FROM map WHERE name = 'Krawk Island 2'));

-- INSERT OR IGNORE values for the piece table
INSERT OR IGNORE INTO piece (id, name, map_id)
VALUES
    ('e8e6b7b9-4dd5-4b8a-b7d0-857031209bd6', '3.1', (SELECT id FROM map WHERE name = 'Krawk Island 3')),
    ('18743118-0be6-448d-a5ce-bfb5a2422a9e', '3.2', (SELECT id FROM map WHERE name = 'Krawk Island 3')),
    ('649822a9-6b75-4a18-b847-d5ab99717adf', '3.3', (SELECT id FROM map WHERE name = 'Krawk Island 3')),
    ('c0a9c171-4e69-4a7f-8404-e3d12e72498a', '3.4', (SELECT id FROM map WHERE name = 'Krawk Island 3')),
    ('5693426e-de73-446d-aee7-047d18abf853', '3.5', (SELECT id FROM map WHERE name = 'Krawk Island 3')),
    ('75c86018-f234-4e48-811f-c456f9f89545', '3.6', (SELECT id FROM map WHERE name = 'Krawk Island 3')),
    ('bd9cee12-4c11-4c1f-81c4-5d21b2d5eefb', '3.7', (SELECT id FROM map WHERE name = 'Krawk Island 3')),
    ('2734d7f7-5cb6-4a34-ad12-0e1d1a34fb4c', '3.8', (SELECT id FROM map WHERE name = 'Krawk Island 3')),
    ('a1412185-e16a-40fd-875d-eb31535d58f4', '3.9', (SELECT id FROM map WHERE name = 'Krawk Island 3')),
    ('237f1288-9cf3-4fff-8d8c-019aed664559', '3.10', (SELECT id FROM map WHERE name = 'Krawk Island 3')),
    ('77b7353a-24c8-49b5-8790-53d492fa6447', '3.11', (SELECT id FROM map WHERE name = 'Krawk Island 3')),
    ('085f29c5-664b-4a2a-ace6-ce3ba7529db6', '3.12', (SELECT id FROM map WHERE name = 'Krawk Island 3')),
    ('b0431526-ad79-4775-9422-27778d4f8ca6', '3.13', (SELECT id FROM map WHERE name = 'Krawk Island 3')),
    ('81881bb4-ae1c-4068-a64f-3972e3499f7f', '3.14', (SELECT id FROM map WHERE name = 'Krawk Island 3')),
    ('732f8a92-52de-42c5-b976-1a252ba920ff', '3.15', (SELECT id FROM map WHERE name = 'Krawk Island 3')),
    ('a808a04b-7472-4c9e-b409-b3e22f985d15', '3.16', (SELECT id FROM map WHERE name = 'Krawk Island 3')),
    ('5ffcd87d-d2aa-496a-8e2d-8ccdc31b5e75', '3.17', (SELECT id FROM map WHERE name = 'Krawk Island 3')),
    ('66b4255b-7b04-4fc2-90a7-463ede4063c4', '3.18', (SELECT id FROM map WHERE name = 'Krawk Island 3')),
    ('c04d0e68-6803-4163-bb65-ca0ee3d996d2', '3.19', (SELECT id FROM map WHERE name = 'Krawk Island 3')),
    ('2941e69f-cffd-4497-9753-cfd4e41dab9c', '3.20', (SELECT id FROM map WHERE name = 'Krawk Island 3'));

-- INSERT OR IGNORE values for the piece table
INSERT OR IGNORE INTO piece (id, name, map_id)
VALUES
    ('c3ba95ed-bc7c-4e97-8d9d-6eacbe86b58f', '1.1', (SELECT id FROM map WHERE name = 'Mystery Island 1')),
    ('2b00d1d5-0966-40f2-a576-f55e5bc1497e', '1.2', (SELECT id FROM map WHERE name = 'Mystery Island 1')),
    ('d85cba6a-02b3-46eb-aa91-7e25b2de5c39', '1.3', (SELECT id FROM map WHERE name = 'Mystery Island 1')),
    ('8683c403-2d2b-4392-ba1a-1d86c38f31da', '1.4', (SELECT id FROM map WHERE name = 'Mystery Island 1')),
    ('bf91af88-9f79-4c5c-b75e-f1c060e94c8e', '1.5', (SELECT id FROM map WHERE name = 'Mystery Island 1')),
    ('621f7932-3ffd-44f7-bf77-4ec2fce760ee', '1.6', (SELECT id FROM map WHERE name = 'Mystery Island 1')),
    ('61a9008e-a90e-4d78-9efa-35aec0bdb327', '1.7', (SELECT id FROM map WHERE name = 'Mystery Island 1')),
    ('b1de4546-139e-4d78-82b3-034e2ca30f96', '1.8', (SELECT id FROM map WHERE name = 'Mystery Island 1')),
    ('6339eeb7-fe49-42e5-a4c5-92907c947ad4', '1.9', (SELECT id FROM map WHERE name = 'Mystery Island 1')),
    ('3e7bc405-fb83-4ac7-9af0-02f3f5c5c7f5', '1.10', (SELECT id FROM map WHERE name = 'Mystery Island 1')),
    ('c46c18c3-a645-488c-851a-21b2a9272e6c', '1.11', (SELECT id FROM map WHERE name = 'Mystery Island 1')),
    ('5ad0983f-04ed-4619-8de3-c675a58d517f', '1.12', (SELECT id FROM map WHERE name = 'Mystery Island 1')),
    ('c4a7ca4b-177e-474c-b350-a98730d383d6', '1.13', (SELECT id FROM map WHERE name = 'Mystery Island 1')),
    ('88f682c1-c630-4344-9e88-8ec33d98a710', '1.14', (SELECT id FROM map WHERE name = 'Mystery Island 1')),
    ('65e30b6b-5dde-473c-98d2-58118480fe76', '1.15', (SELECT id FROM map WHERE name = 'Mystery Island 1')),
    ('761278b8-9daa-4c55-b2f2-41dd5eeaca5d', '1.16', (SELECT id FROM map WHERE name = 'Mystery Island 1')),
    ('e18d52b1-c359-4bb5-a061-3d37039ba9a0', '1.17', (SELECT id FROM map WHERE name = 'Mystery Island 1')),
    ('cfd3d8cf-e2d3-45df-847c-2b4838fe39a3', '1.18', (SELECT id FROM map WHERE name = 'Mystery Island 1')),
    ('28cf9fd4-0ab8-486c-ac50-17b73b94371c', '1.19', (SELECT id FROM map WHERE name = 'Mystery Island 1')),
    ('f223dc59-9a74-4519-940c-2328a3f0ca3c', '1.20', (SELECT id FROM map WHERE name = 'Mystery Island 1'));

-- INSERT OR IGNORE values for the piece table
INSERT OR IGNORE INTO piece (id, name, map_id)
VALUES
    ('b4e2680d-6291-4deb-860e-f7ee7a7198e3', '2.1', (SELECT id FROM map WHERE name = 'Mystery Island 2')),
    ('5f11c632-a299-4ea5-a70b-506b12e4bffa', '2.2', (SELECT id FROM map WHERE name = 'Mystery Island 2')),
    ('97914737-e78e-406e-a5f6-ab3e866b68c6', '2.3', (SELECT id FROM map WHERE name = 'Mystery Island 2')),
    ('98b36b42-a49b-451d-a402-c7360dbf2021', '2.4', (SELECT id FROM map WHERE name = 'Mystery Island 2')),
    ('5c136a3a-d91d-442c-98d8-d3f7bd181e4a', '2.5', (SELECT id FROM map WHERE name = 'Mystery Island 2')),
    ('15ccf12c-7161-4d2b-a9e8-65c3e92eb2f0', '2.6', (SELECT id FROM map WHERE name = 'Mystery Island 2')),
    ('aa2e145c-1ade-420e-b067-97931618f168', '2.7', (SELECT id FROM map WHERE name = 'Mystery Island 2')),
    ('877e639a-4010-47db-9923-4fa0f28e39ae', '2.8', (SELECT id FROM map WHERE name = 'Mystery Island 2')),
    ('2d3dab41-12cf-4536-9b03-f79a221bd2ae', '2.9', (SELECT id FROM map WHERE name = 'Mystery Island 2')),
    ('84623466-5072-434f-95d7-0b96b5f04327', '2.10', (SELECT id FROM map WHERE name = 'Mystery Island 2')),
    ('3e299ca1-c791-4532-a07a-8e7957fdd23b', '2.11', (SELECT id FROM map WHERE name = 'Mystery Island 2')),
    ('dd045cb3-02a9-4f9f-8413-d09df7a44585', '2.12', (SELECT id FROM map WHERE name = 'Mystery Island 2')),
    ('453d2533-12df-4ea9-b2cb-ac7c694b10c1', '2.13', (SELECT id FROM map WHERE name = 'Mystery Island 2')),
    ('3742e6b8-be54-458a-b8bc-9a9480fc188f', '2.14', (SELECT id FROM map WHERE name = 'Mystery Island 2')),
    ('eafbd257-288d-4973-a732-6765ec7aabce', '2.15', (SELECT id FROM map WHERE name = 'Mystery Island 2')),
    ('c05c4cb3-b0f1-47ef-a06b-3b3d6be4fe07', '2.16', (SELECT id FROM map WHERE name = 'Mystery Island 2')),
    ('a1c98073-63bd-4240-affb-38bf0623272d', '2.17', (SELECT id FROM map WHERE name = 'Mystery Island 2')),
    ('21b6be58-08a2-4321-9be6-1c2b79f66c4a', '2.18', (SELECT id FROM map WHERE name = 'Mystery Island 2')),
    ('088ff840-2f9f-4ca0-8985-d1de8f1241f8', '2.19', (SELECT id FROM map WHERE name = 'Mystery Island 2')),
    ('161464f4-e4fd-4bcf-ac4e-ec7f5df67df7', '2.20', (SELECT id FROM map WHERE name = 'Mystery Island 2'));

-- INSERT OR IGNORE values for the piece table
INSERT OR IGNORE INTO piece (id, name, map_id)
VALUES
    ('d9a67885-33cf-4024-b665-b121799cbe64', '3.1', (SELECT id FROM map WHERE name = 'Mystery Island 3')),
    ('6963e81c-b17e-42e8-aa07-6243ada049b0', '3.2', (SELECT id FROM map WHERE name = 'Mystery Island 3')),
    ('655969e6-722f-4180-ae44-f038f93e3e72', '3.3', (SELECT id FROM map WHERE name = 'Mystery Island 3')),
    ('979fe48d-0507-4c7e-b7d0-11f3318dd597', '3.4', (SELECT id FROM map WHERE name = 'Mystery Island 3')),
    ('e1608bd1-20a3-4b04-ba0b-cb00ae2a11e0', '3.5', (SELECT id FROM map WHERE name = 'Mystery Island 3')),
    ('a8719230-ed8d-4670-b66b-432047055dc2', '3.6', (SELECT id FROM map WHERE name = 'Mystery Island 3')),
    ('cad77a54-9ff4-4814-bf27-e9fa3e96e676', '3.7', (SELECT id FROM map WHERE name = 'Mystery Island 3')),
    ('52129b15-0102-47e5-962a-0565e269e5bc', '3.8', (SELECT id FROM map WHERE name = 'Mystery Island 3')),
    ('fd0773b9-4917-4025-ac35-1903ce70373b', '3.9', (SELECT id FROM map WHERE name = 'Mystery Island 3')),
    ('db80627d-1329-4274-9963-aef37fbfd67d', '3.10', (SELECT id FROM map WHERE name = 'Mystery Island 3')),
    ('eedb8468-e02f-4cf8-9755-4fca006e5a23', '3.11', (SELECT id FROM map WHERE name = 'Mystery Island 3')),
    ('86f04b82-0f67-4118-97e5-85ee85f000e3', '3.12', (SELECT id FROM map WHERE name = 'Mystery Island 3')),
    ('f4b8da25-9b02-4888-b46e-a1caf962c3df', '3.13', (SELECT id FROM map WHERE name = 'Mystery Island 3')),
    ('9006d72a-6c74-4ac6-a6ac-4ef1c26eb276', '3.14', (SELECT id FROM map WHERE name = 'Mystery Island 3')),
    ('b2957ed7-2d7c-4edb-9c2f-1704ed4b9230', '3.15', (SELECT id FROM map WHERE name = 'Mystery Island 3')),
    ('e1d0d591-69a4-4c28-ad10-19b3d40bbee6', '3.16', (SELECT id FROM map WHERE name = 'Mystery Island 3')),
    ('961d9b04-7906-4954-a375-04385b186887', '3.17', (SELECT id FROM map WHERE name = 'Mystery Island 3')),
    ('4cc698fe-b665-408e-8e90-5e1a051c4bf5', '3.18', (SELECT id FROM map WHERE name = 'Mystery Island 3')),
    ('e3a82c71-5808-4893-8bf7-065e3b3729cf', '3.19', (SELECT id FROM map WHERE name = 'Mystery Island 3')),
    ('cae45f90-648c-4822-986d-c639a7922d5e', '3.20', (SELECT id FROM map WHERE name = 'Mystery Island 3'));

-- INSERT OR IGNORE values for the piece table
INSERT OR IGNORE INTO piece (id, name, map_id)
VALUES
    ('0991f493-a929-43bd-aacf-62c204c5cafa', '1.1', (SELECT id FROM map WHERE name = 'Virtupets 1')),
    ('722c1f5c-73ab-4a1c-883e-85dc218e3c69', '1.2', (SELECT id FROM map WHERE name = 'Virtupets 1')),
    ('c3d521bf-bd4d-4ca2-9808-3d6eb5d19a12', '1.3', (SELECT id FROM map WHERE name = 'Virtupets 1')),
    ('a3ae7b35-a6f0-4fd6-8726-c90dc02e92fc', '1.4', (SELECT id FROM map WHERE name = 'Virtupets 1')),
    ('7b272926-963b-49b5-a5f3-0493c9ada8d6', '1.5', (SELECT id FROM map WHERE name = 'Virtupets 1')),
    ('990bce13-b7a7-48da-902a-4140659a17c4', '1.6', (SELECT id FROM map WHERE name = 'Virtupets 1')),
    ('92526eda-b6b2-4cae-9f54-1edcecc0f419', '1.7', (SELECT id FROM map WHERE name = 'Virtupets 1')),
    ('6235406b-6d0c-4eb3-b6e2-431013bdd1b3', '1.8', (SELECT id FROM map WHERE name = 'Virtupets 1')),
    ('265844f5-cc71-4bee-91fc-f9b55b77dfe5', '1.9', (SELECT id FROM map WHERE name = 'Virtupets 1')),
    ('08cc1773-f360-4537-bf0b-efadcb6b596b', '1.10', (SELECT id FROM map WHERE name = 'Virtupets 1')),
    ('88fcf86d-0ced-48b2-b0a9-90357def3dbc', '1.11', (SELECT id FROM map WHERE name = 'Virtupets 1')),
    ('a03d07b9-9dbe-4476-b721-5e20a300f9b3', '1.12', (SELECT id FROM map WHERE name = 'Virtupets 1')),
    ('fda025dc-d362-47fa-a96f-941485219430', '1.13', (SELECT id FROM map WHERE name = 'Virtupets 1')),
    ('1dab6942-4f42-4dd0-a818-754a24e0dbdb', '1.14', (SELECT id FROM map WHERE name = 'Virtupets 1')),
    ('888be197-8d57-4340-9579-9aba142d781c', '1.15', (SELECT id FROM map WHERE name = 'Virtupets 1')),
    ('acf3dfef-02fb-4eb1-8830-daa6eb144347', '1.16', (SELECT id FROM map WHERE name = 'Virtupets 1')),
    ('49d10d10-339d-472a-9a16-22e21d20b851', '1.17', (SELECT id FROM map WHERE name = 'Virtupets 1')),
    ('15e6008a-466c-4bae-9a0b-5efb604ec0f3', '1.18', (SELECT id FROM map WHERE name = 'Virtupets 1')),
    ('0141d17a-7494-4444-ae98-30d84d9e243c', '1.19', (SELECT id FROM map WHERE name = 'Virtupets 1')),
    ('079d11d4-5e0d-4868-83e0-21c80d844649', '1.20', (SELECT id FROM map WHERE name = 'Virtupets 1'));

-- INSERT OR IGNORE values for the piece table
INSERT OR IGNORE INTO piece (id, name, map_id)
VALUES
    ('a8e3dffd-76bc-47f7-8d59-a511a5476ca5', '2.1', (SELECT id FROM map WHERE name = 'Virtupets 2')),
    ('45c7d772-b2ad-4c40-ad62-d7ad8dd20de8', '2.2', (SELECT id FROM map WHERE name = 'Virtupets 2')),
    ('ce79a6d2-915c-4b6c-bbf0-5bd1ce19dd30', '2.3', (SELECT id FROM map WHERE name = 'Virtupets 2')),
    ('6ae16563-1347-4dd0-82db-e78166efffc5', '2.4', (SELECT id FROM map WHERE name = 'Virtupets 2')),
    ('f088b1d4-3d79-4780-a669-188efddb158f', '2.5', (SELECT id FROM map WHERE name = 'Virtupets 2')),
    ('3f3afdb7-34de-4aca-a5ef-eb259823b667', '2.6', (SELECT id FROM map WHERE name = 'Virtupets 2')),
    ('e108704b-a7fc-4bb8-851b-3201a02562b0', '2.7', (SELECT id FROM map WHERE name = 'Virtupets 2')),
    ('9b7fb9fd-dfbf-4731-b179-6c4da7e36143', '2.8', (SELECT id FROM map WHERE name = 'Virtupets 2')),
    ('e9609634-79d8-417d-ad9a-29cc48933d2d', '2.9', (SELECT id FROM map WHERE name = 'Virtupets 2')),
    ('c7bd0633-9ce8-4f2d-9c44-84cf5068abca', '2.10', (SELECT id FROM map WHERE name = 'Virtupets 2')),
    ('443bb351-6d11-43b1-855a-99bb31e5228a', '2.11', (SELECT id FROM map WHERE name = 'Virtupets 2')),
    ('78935aec-55ca-44fa-b19b-9a5e6446965d', '2.12', (SELECT id FROM map WHERE name = 'Virtupets 2')),
    ('30aa9ab2-334f-4b4b-9ebc-140fec4a19b2', '2.13', (SELECT id FROM map WHERE name = 'Virtupets 2')),
    ('35d03e23-3ce3-4531-864f-308f8256ef22', '2.14', (SELECT id FROM map WHERE name = 'Virtupets 2')),
    ('fc3ef722-0355-4137-9703-f7bab857b3cf', '2.15', (SELECT id FROM map WHERE name = 'Virtupets 2')),
    ('cb3a3912-6503-4b77-87f1-55f0a465e3d5', '2.16', (SELECT id FROM map WHERE name = 'Virtupets 2')),
    ('f525c504-d0a1-4c6b-b451-d2752a4982da', '2.17', (SELECT id FROM map WHERE name = 'Virtupets 2')),
    ('7e1708ff-1846-4d7a-8fc6-f73c81db0e8b', '2.18', (SELECT id FROM map WHERE name = 'Virtupets 2')),
    ('231dbe86-5361-43a4-9423-eb35dc43cab1', '2.19', (SELECT id FROM map WHERE name = 'Virtupets 2')),
    ('ded82acd-006b-46a4-bb6e-f86854b12be8', '2.20', (SELECT id FROM map WHERE name = 'Virtupets 2'));

-- INSERT OR IGNORE values for the piece table
INSERT OR IGNORE INTO piece (id, name, map_id)
VALUES
    ('4cb00421-f6df-4f04-aed8-ffcd65e38ec9', '3.1', (SELECT id FROM map WHERE name = 'Virtupets 3')),
    ('3ce1ca97-5b80-4657-84ba-a97ced8e7267', '3.2', (SELECT id FROM map WHERE name = 'Virtupets 3')),
    ('581e7d7b-43a0-45d5-a7cb-00aa4d82e446', '3.3', (SELECT id FROM map WHERE name = 'Virtupets 3')),
    ('165551d7-3624-4334-841d-8f9ffad57f06', '3.4', (SELECT id FROM map WHERE name = 'Virtupets 3')),
    ('dc96fd09-6a6b-44ca-8ef8-36a061d93261', '3.5', (SELECT id FROM map WHERE name = 'Virtupets 3')),
    ('cb9b7aad-8848-43dc-9584-0ed9222e6c29', '3.6', (SELECT id FROM map WHERE name = 'Virtupets 3')),
    ('81827a49-3806-4593-a854-5ef697f99fbb', '3.7', (SELECT id FROM map WHERE name = 'Virtupets 3')),
    ('604537a1-09b8-476c-b465-b612e2c4b2fd', '3.8', (SELECT id FROM map WHERE name = 'Virtupets 3')),
    ('e40c98da-60bb-426c-ba4f-9e4d5472f288', '3.9', (SELECT id FROM map WHERE name = 'Virtupets 3')),
    ('5837aa86-befa-430e-9e2b-55c27a05a194', '3.10', (SELECT id FROM map WHERE name = 'Virtupets 3')),
    ('6770b989-75ca-4d12-ae8c-527be0668047', '3.11', (SELECT id FROM map WHERE name = 'Virtupets 3')),
    ('a975b137-6081-47e0-9551-006f642d2b9e', '3.12', (SELECT id FROM map WHERE name = 'Virtupets 3')),
    ('3fb9eddd-53ab-44bc-acf1-28d52876395e', '3.13', (SELECT id FROM map WHERE name = 'Virtupets 3')),
    ('8693b317-7a65-45eb-a5f9-8c6dc72c30c1', '3.14', (SELECT id FROM map WHERE name = 'Virtupets 3')),
    ('c1630e9b-8f54-49c1-bb9d-1f98f71cb3cf', '3.15', (SELECT id FROM map WHERE name = 'Virtupets 3')),
    ('ad628497-2a4a-486e-a9be-21b70db06102', '3.16', (SELECT id FROM map WHERE name = 'Virtupets 3')),
    ('82c042d9-381c-4e2b-a4a5-d508d0f1aa9c', '3.17', (SELECT id FROM map WHERE name = 'Virtupets 3')),
    ('db7baa34-d540-4fe6-b71a-47cb0be75860', '3.18', (SELECT id FROM map WHERE name = 'Virtupets 3')),
    ('1f4a0067-ba68-4c48-99d2-41f97829154b', '3.19', (SELECT id FROM map WHERE name = 'Virtupets 3')),
    ('300c72c8-8d82-4e44-8140-a0b22c9e7a15', '3.20', (SELECT id FROM map WHERE name = 'Virtupets 3'));

-- INSERT OR IGNORE values for the piece table
INSERT OR IGNORE INTO piece (id, name, map_id)
VALUES
    ('0c7cee4a-b7d4-4fe4-9362-8a4020839f88', '1.1', (SELECT id FROM map WHERE name = 'Meridell 1')),
    ('39080db9-a6d4-4617-a55d-a9a9a648de26', '1.2', (SELECT id FROM map WHERE name = 'Meridell 1')),
    ('d02aad07-3476-4f45-aa99-85d01fe59732', '1.3', (SELECT id FROM map WHERE name = 'Meridell 1')),
    ('35640d7a-7ad4-46f4-ad42-bd3aafa2bca1', '1.4', (SELECT id FROM map WHERE name = 'Meridell 1')),
    ('6d8155f8-e83a-48de-9330-bb56928bfe0b', '1.5', (SELECT id FROM map WHERE name = 'Meridell 1')),
    ('276757cb-e57e-4a84-92bf-f0a7b641dcf0', '1.6', (SELECT id FROM map WHERE name = 'Meridell 1')),
    ('d8c79d55-51b8-443a-ab60-2e686e664884', '1.7', (SELECT id FROM map WHERE name = 'Meridell 1')),
    ('71cd9031-9637-4c5d-a78f-22b0483c0de8', '1.8', (SELECT id FROM map WHERE name = 'Meridell 1')),
    ('4be02631-3b7d-45f2-b050-67b3a8ccb61c', '1.9', (SELECT id FROM map WHERE name = 'Meridell 1')),
    ('19e48dc0-6227-4d6b-83d4-cda95e61918d', '1.10', (SELECT id FROM map WHERE name = 'Meridell 1')),
    ('89f84c8e-47a5-42fc-af32-bf3ac8fce14c', '1.11', (SELECT id FROM map WHERE name = 'Meridell 1')),
    ('30ce5585-315e-4c07-8788-08a1a5bc2a0a', '1.12', (SELECT id FROM map WHERE name = 'Meridell 1')),
    ('ea0b4b29-1a68-4bbd-9727-e85f76c5b03d', '1.13', (SELECT id FROM map WHERE name = 'Meridell 1')),
    ('b1a6a223-9242-40a0-900f-597d9e9e4485', '1.14', (SELECT id FROM map WHERE name = 'Meridell 1')),
    ('773a035d-d2d4-4612-8b1f-ee3b7d24938e', '1.15', (SELECT id FROM map WHERE name = 'Meridell 1')),
    ('d7013db7-a148-43cf-a820-78fc49a042bc', '1.16', (SELECT id FROM map WHERE name = 'Meridell 1')),
    ('3670f0c2-1325-4c22-b333-c68e8de2ea95', '1.17', (SELECT id FROM map WHERE name = 'Meridell 1')),
    ('74244612-657a-4280-b027-19493a55ecd3', '1.18', (SELECT id FROM map WHERE name = 'Meridell 1')),
    ('bde42376-a816-4ab2-895f-32684ddd2142', '1.19', (SELECT id FROM map WHERE name = 'Meridell 1')),
    ('642d6b4d-da49-49be-905c-864f552ff88e', '1.20', (SELECT id FROM map WHERE name = 'Meridell 1'));

-- INSERT OR IGNORE values for the piece table
INSERT OR IGNORE INTO piece (id, name, map_id)
VALUES
    ('ff789092-20ed-46e0-820c-6203233b4990', '2.1', (SELECT id FROM map WHERE name = 'Meridell 2')),
    ('6d110fd3-bbe5-47f4-93f4-38db22d5eaf4', '2.2', (SELECT id FROM map WHERE name = 'Meridell 2')),
    ('eef4c54b-902f-4a24-aa8d-e728f40c11fb', '2.3', (SELECT id FROM map WHERE name = 'Meridell 2')),
    ('e8d5a227-3d86-4a34-ba74-6f4768c68b27', '2.4', (SELECT id FROM map WHERE name = 'Meridell 2')),
    ('65092d56-064e-44d5-8765-665ef8be4809', '2.5', (SELECT id FROM map WHERE name = 'Meridell 2')),
    ('a34b3146-7a72-4bcb-8fc0-1b4c1b3b24d3', '2.6', (SELECT id FROM map WHERE name = 'Meridell 2')),
    ('e4a0cfd1-41bf-4104-bdce-291888a5a6ed', '2.7', (SELECT id FROM map WHERE name = 'Meridell 2')),
    ('3ece4fe0-b6e2-4ca2-a2d7-c67a72887b3d', '2.8', (SELECT id FROM map WHERE name = 'Meridell 2')),
    ('08a9684b-c722-4f51-8000-2933b1bde9ba', '2.9', (SELECT id FROM map WHERE name = 'Meridell 2')),
    ('8bf880d9-2e4f-4908-8983-9a1a478397db', '2.10', (SELECT id FROM map WHERE name = 'Meridell 2')),
    ('bae8e2dd-7fae-401b-aaff-affc692f1d2c', '2.11', (SELECT id FROM map WHERE name = 'Meridell 2')),
    ('98e1bc8e-d79d-43c8-ba66-5188852c6930', '2.12', (SELECT id FROM map WHERE name = 'Meridell 2')),
    ('37645080-ee2f-4162-96c5-1b640c7bdb1a', '2.13', (SELECT id FROM map WHERE name = 'Meridell 2')),
    ('329f8c32-cbc0-4ca6-8a41-f9c696094fdb', '2.14', (SELECT id FROM map WHERE name = 'Meridell 2')),
    ('a93b8cdc-dcf6-4dde-8dac-eab3ad42080d', '2.15', (SELECT id FROM map WHERE name = 'Meridell 2')),
    ('0ee0bf20-3b51-4e9e-b816-c79156dd39a4', '2.16', (SELECT id FROM map WHERE name = 'Meridell 2')),
    ('09609a2e-71e6-4c38-a4d8-c71032241e53', '2.17', (SELECT id FROM map WHERE name = 'Meridell 2')),
    ('644f46c4-c935-4af9-a85f-ed6f4063b3e5', '2.18', (SELECT id FROM map WHERE name = 'Meridell 2')),
    ('872baca1-7837-42e3-b26a-e83b671ffdae', '2.19', (SELECT id FROM map WHERE name = 'Meridell 2')),
    ('10053c64-602c-419d-a17b-edff07b0fcec', '2.20', (SELECT id FROM map WHERE name = 'Meridell 2'));

-- INSERT OR IGNORE values for the piece table
INSERT OR IGNORE INTO piece (id, name, map_id)
VALUES
    ('f5bad613-d51f-45d3-b39e-f2364971dae8', '3.1', (SELECT id FROM map WHERE name = 'Meridell 3')),
    ('ff7ce5d4-3532-4f80-a21c-5177a28893ba', '3.2', (SELECT id FROM map WHERE name = 'Meridell 3')),
    ('1f949745-8b6b-4543-a3d2-9e5bde870bb2', '3.3', (SELECT id FROM map WHERE name = 'Meridell 3')),
    ('10b98635-207c-4fbf-bd58-659b7819468e', '3.4', (SELECT id FROM map WHERE name = 'Meridell 3')),
    ('57ef32b5-ab76-4400-834c-9a1950968ecb', '3.5', (SELECT id FROM map WHERE name = 'Meridell 3')),
    ('ffc2770e-3ac6-43c3-b681-ea3c055305aa', '3.6', (SELECT id FROM map WHERE name = 'Meridell 3')),
    ('55b36c72-cb63-4450-902f-33b759dea8a6', '3.7', (SELECT id FROM map WHERE name = 'Meridell 3')),
    ('7b79cde0-8c0b-43ec-b93c-7ccba31dddd9', '3.8', (SELECT id FROM map WHERE name = 'Meridell 3')),
    ('21957092-0ca4-420b-84e0-04b28b2287a8', '3.9', (SELECT id FROM map WHERE name = 'Meridell 3')),
    ('4dbebda0-c7aa-455a-b9ec-c891b3e02f39', '3.10', (SELECT id FROM map WHERE name = 'Meridell 3')),
    ('5d132194-0e36-4533-9543-403a4f36e155', '3.11', (SELECT id FROM map WHERE name = 'Meridell 3')),
    ('ddc3353a-d7e0-4430-8719-a7b369f1cb9d', '3.12', (SELECT id FROM map WHERE name = 'Meridell 3')),
    ('ec6caba0-11e4-4d21-a7d7-7c40e5082d07', '3.13', (SELECT id FROM map WHERE name = 'Meridell 3')),
    ('44d443c5-ada1-41a4-a3c8-58903c013edf', '3.14', (SELECT id FROM map WHERE name = 'Meridell 3')),
    ('defde93b-8d6b-4da0-92ea-538adbe20778', '3.15', (SELECT id FROM map WHERE name = 'Meridell 3')),
    ('fb7441e7-3edd-4309-abbf-db8432634540', '3.16', (SELECT id FROM map WHERE name = 'Meridell 3')),
    ('ac57b6c9-e3a8-44c3-b7a3-4565599e442f', '3.17', (SELECT id FROM map WHERE name = 'Meridell 3')),
    ('5aebd631-ae43-44cf-bd00-b800256b7966', '3.18', (SELECT id FROM map WHERE name = 'Meridell 3')),
    ('fea5bda8-f488-4578-83fc-68c179483750', '3.19', (SELECT id FROM map WHERE name = 'Meridell 3')),
    ('f63be26c-b4cf-48a4-9dc3-8489b5588812', '3.20', (SELECT id FROM map WHERE name = 'Meridell 3'));

-- INSERT OR IGNORE values for the piece table
INSERT OR IGNORE INTO piece (id, name, map_id)
VALUES
    ('9e4bd05a-240f-43d2-8dd2-0241ef365b84', '1.1', (SELECT id FROM map WHERE name = 'Tyrannia 1')),
    ('69cedd15-d908-484b-85a0-b9b85498d37b', '1.2', (SELECT id FROM map WHERE name = 'Tyrannia 1')),
    ('1c9d7b82-f40d-4271-9035-5fb74a06ce08', '1.3', (SELECT id FROM map WHERE name = 'Tyrannia 1')),
    ('212c6bd9-a946-44d5-a6ee-93aa9edf98a4', '1.4', (SELECT id FROM map WHERE name = 'Tyrannia 1')),
    ('a1702ded-db93-46b0-bdd1-026ce74bc9d0', '1.5', (SELECT id FROM map WHERE name = 'Tyrannia 1')),
    ('12da0bff-f557-4308-96d8-9ae9c388edc7', '1.6', (SELECT id FROM map WHERE name = 'Tyrannia 1')),
    ('1eac30fa-ae11-4a24-ae5a-df05ea26133e', '1.7', (SELECT id FROM map WHERE name = 'Tyrannia 1')),
    ('b4b3d251-feea-4d48-b705-4db196c5a0bb', '1.8', (SELECT id FROM map WHERE name = 'Tyrannia 1')),
    ('ac534d6b-4eac-4b7c-9e57-eefb4609e13f', '1.9', (SELECT id FROM map WHERE name = 'Tyrannia 1')),
    ('90e2a31a-faa2-4baa-ad22-5a349e9dc214', '1.10', (SELECT id FROM map WHERE name = 'Tyrannia 1')),
    ('03eab00d-ad24-4091-9525-e38bc2ed30dc', '1.11', (SELECT id FROM map WHERE name = 'Tyrannia 1')),
    ('443447e8-9ace-4e50-9e22-c25c93185736', '1.12', (SELECT id FROM map WHERE name = 'Tyrannia 1')),
    ('2b91a47c-a034-4daa-bace-d69b623cd2f3', '1.13', (SELECT id FROM map WHERE name = 'Tyrannia 1')),
    ('016094f1-4bfc-4918-ac7d-be1da7176a23', '1.14', (SELECT id FROM map WHERE name = 'Tyrannia 1')),
    ('27591246-197d-4ed7-8140-a78643abafb8', '1.15', (SELECT id FROM map WHERE name = 'Tyrannia 1')),
    ('6b83ec09-1e1c-487d-afa4-95707e72ccfe', '1.16', (SELECT id FROM map WHERE name = 'Tyrannia 1')),
    ('5cad8898-0ea2-4c2d-b384-8fbfa2bc6c2d', '1.17', (SELECT id FROM map WHERE name = 'Tyrannia 1')),
    ('74be7cbb-f51f-48e9-87c1-e4b6f6eb7698', '1.18', (SELECT id FROM map WHERE name = 'Tyrannia 1')),
    ('5b433c2c-cf90-409e-933b-77957496be9d', '1.19', (SELECT id FROM map WHERE name = 'Tyrannia 1')),
    ('b521963a-c50f-4227-8b0f-c4575a30aac7', '1.20', (SELECT id FROM map WHERE name = 'Tyrannia 1'));

-- INSERT OR IGNORE values for the piece table
INSERT OR IGNORE INTO piece (id, name, map_id)
VALUES
    ('0ffa8f83-1944-4abc-a8e5-737694b28cf7', '2.1', (SELECT id FROM map WHERE name = 'Tyrannia 2')),
    ('f2c45d04-17be-4401-924a-274b166e4dc9', '2.2', (SELECT id FROM map WHERE name = 'Tyrannia 2')),
    ('7e77a2e3-fa1d-409a-8035-651858eb96e8', '2.3', (SELECT id FROM map WHERE name = 'Tyrannia 2')),
    ('1d4100e1-8eea-4c98-a7bb-d191decb1883', '2.4', (SELECT id FROM map WHERE name = 'Tyrannia 2')),
    ('83833333-6a4a-4c93-9828-fbaaebdb1183', '2.5', (SELECT id FROM map WHERE name = 'Tyrannia 2')),
    ('7c20be17-63d1-4683-b8cc-13c4300e1e27', '2.6', (SELECT id FROM map WHERE name = 'Tyrannia 2')),
    ('edf78df0-2575-453d-9cd6-7400926a63ff', '2.7', (SELECT id FROM map WHERE name = 'Tyrannia 2')),
    ('6fe9b943-7e47-4f63-beb2-2b262074ea31', '2.8', (SELECT id FROM map WHERE name = 'Tyrannia 2')),
    ('70d73749-f391-4251-83c7-b89f16673069', '2.9', (SELECT id FROM map WHERE name = 'Tyrannia 2')),
    ('e9d88e80-a2c5-498b-929f-f7a3a643b781', '2.10', (SELECT id FROM map WHERE name = 'Tyrannia 2')),
    ('7a7c3e0b-b427-4420-aaff-6d8139deb3c0', '2.11', (SELECT id FROM map WHERE name = 'Tyrannia 2')),
    ('17bec814-de31-4ff5-99f2-8df6bbe3c4ac', '2.12', (SELECT id FROM map WHERE name = 'Tyrannia 2')),
    ('9e8f0791-6b37-4ee8-9285-52a76266bd0f', '2.13', (SELECT id FROM map WHERE name = 'Tyrannia 2')),
    ('86fe1a4a-cc78-4250-aa4a-0dc5849d9fc5', '2.14', (SELECT id FROM map WHERE name = 'Tyrannia 2')),
    ('5863d07a-3f2a-4a8f-adc1-9dcc9f801f1f', '2.15', (SELECT id FROM map WHERE name = 'Tyrannia 2')),
    ('06357bbd-af26-432f-a0c1-b4e798885785', '2.16', (SELECT id FROM map WHERE name = 'Tyrannia 2')),
    ('f68fbfa3-87c0-4501-906e-da62847b2102', '2.17', (SELECT id FROM map WHERE name = 'Tyrannia 2')),
    ('e2955064-9432-4e3b-95eb-7e4b486e4bec', '2.18', (SELECT id FROM map WHERE name = 'Tyrannia 2')),
    ('cd2e3c87-6d23-4f5d-ba56-e2cea9bcc7d8', '2.19', (SELECT id FROM map WHERE name = 'Tyrannia 2')),
    ('d5953eb2-cce0-449d-a11b-589bf90f0030', '2.20', (SELECT id FROM map WHERE name = 'Tyrannia 2'));

-- INSERT OR IGNORE values for the piece table
INSERT OR IGNORE INTO piece (id, name, map_id)
VALUES
    ('d9babeb5-0219-4cb6-b326-cf055aa69271', '3.1', (SELECT id FROM map WHERE name = 'Tyrannia 3')),
    ('d1f9e2d6-b5d1-44da-bb38-ab9435cbc739', '3.2', (SELECT id FROM map WHERE name = 'Tyrannia 3')),
    ('13fa2c28-9829-470e-9a8c-094149da68e6', '3.3', (SELECT id FROM map WHERE name = 'Tyrannia 3')),
    ('49c064b0-ec23-4797-9503-150df3c24aee', '3.4', (SELECT id FROM map WHERE name = 'Tyrannia 3')),
    ('8ab369cd-551b-48e7-b56b-84a089f3cc5a', '3.5', (SELECT id FROM map WHERE name = 'Tyrannia 3')),
    ('bbd5ea14-964a-435f-aab0-aba159ac0866', '3.6', (SELECT id FROM map WHERE name = 'Tyrannia 3')),
    ('4c678d09-725b-49e1-be96-5cc65073f346', '3.7', (SELECT id FROM map WHERE name = 'Tyrannia 3')),
    ('39de28ac-f484-47c7-bf8c-7a4bc0435a8d', '3.8', (SELECT id FROM map WHERE name = 'Tyrannia 3')),
    ('8d705ce5-7b34-4279-9408-77500876cacd', '3.9', (SELECT id FROM map WHERE name = 'Tyrannia 3')),
    ('266fe00e-55f4-469d-90ac-17a63d65be51', '3.10', (SELECT id FROM map WHERE name = 'Tyrannia 3')),
    ('88b90899-806d-449b-b2ae-a6500594f60e', '3.11', (SELECT id FROM map WHERE name = 'Tyrannia 3')),
    ('a56997ef-5253-4d27-91c7-8a8a1140a784', '3.12', (SELECT id FROM map WHERE name = 'Tyrannia 3')),
    ('7433d667-b6f4-4bb6-9e2b-29268bc90f94', '3.13', (SELECT id FROM map WHERE name = 'Tyrannia 3')),
    ('147b1fb3-25af-466a-ab42-f76f6699cf04', '3.14', (SELECT id FROM map WHERE name = 'Tyrannia 3')),
    ('4bf08530-6fb8-4adb-8899-28ed9379ea73', '3.15', (SELECT id FROM map WHERE name = 'Tyrannia 3')),
    ('7484fccd-28ba-4279-a3d7-bc5638eb9820', '3.16', (SELECT id FROM map WHERE name = 'Tyrannia 3')),
    ('a891001f-e9fb-4a9d-8e3e-fcff36cfb78d', '3.17', (SELECT id FROM map WHERE name = 'Tyrannia 3')),
    ('18784058-89a4-41bb-b74a-8453c1287f9d', '3.18', (SELECT id FROM map WHERE name = 'Tyrannia 3')),
    ('0e807ecc-f6f1-4bdd-b9aa-984517b469de', '3.19', (SELECT id FROM map WHERE name = 'Tyrannia 3')),
    ('7b665328-5123-47cf-8421-56feed69fdc9', '3.20', (SELECT id FROM map WHERE name = 'Tyrannia 3'));

-- INSERT OR IGNORE values for the piece table
INSERT OR IGNORE INTO piece (id, name, map_id)
VALUES
    ('bda1e0ce-2ef9-49bf-80d3-3795207b3658', '1.1', (SELECT id FROM map WHERE name = 'Terror Mountain 1')),
    ('00f99bf4-ac92-4bff-93d0-bc9c2efc35a9', '1.2', (SELECT id FROM map WHERE name = 'Terror Mountain 1')),
    ('3654c3b0-323f-42c0-be12-7bb506093794', '1.3', (SELECT id FROM map WHERE name = 'Terror Mountain 1')),
    ('207cb0f3-7746-4687-aa8f-43c8791b2866', '1.4', (SELECT id FROM map WHERE name = 'Terror Mountain 1')),
    ('db1959e6-6389-41f8-99de-7bfc09860b7a', '1.5', (SELECT id FROM map WHERE name = 'Terror Mountain 1')),
    ('7b6ab22d-bac5-4d9f-aa38-5fe486b698fd', '1.6', (SELECT id FROM map WHERE name = 'Terror Mountain 1')),
    ('f188567a-f30e-4264-a1ba-01c91ae01eaa', '1.7', (SELECT id FROM map WHERE name = 'Terror Mountain 1')),
    ('764eda09-391a-40a7-a459-7aca8de0fd44', '1.8', (SELECT id FROM map WHERE name = 'Terror Mountain 1')),
    ('076184ca-f33f-4078-9027-d3e75a2b9ad7', '1.9', (SELECT id FROM map WHERE name = 'Terror Mountain 1')),
    ('ccc35d3b-d4aa-4e18-bbe5-61bd0f3e867e', '1.10', (SELECT id FROM map WHERE name = 'Terror Mountain 1')),
    ('c12f79b4-2248-481e-bc13-cfc807298e3e', '1.11', (SELECT id FROM map WHERE name = 'Terror Mountain 1')),
    ('10eef451-5b3e-40dd-b00d-aea810f8ae4b', '1.12', (SELECT id FROM map WHERE name = 'Terror Mountain 1')),
    ('7e8366ef-f901-401a-98d8-5e24e9a0bd42', '1.13', (SELECT id FROM map WHERE name = 'Terror Mountain 1')),
    ('f0e7d49d-c567-4485-9f74-5d68c782c989', '1.14', (SELECT id FROM map WHERE name = 'Terror Mountain 1')),
    ('81343b07-663f-4e7e-90d1-8370efe780b6', '1.15', (SELECT id FROM map WHERE name = 'Terror Mountain 1')),
    ('a7d36298-27b5-499a-9635-262bc6340f5e', '1.16', (SELECT id FROM map WHERE name = 'Terror Mountain 1')),
    ('8ade11e9-11be-40e5-a487-f117b101574f', '1.17', (SELECT id FROM map WHERE name = 'Terror Mountain 1')),
    ('24aa155a-5708-40da-b911-89dec28e8849', '1.18', (SELECT id FROM map WHERE name = 'Terror Mountain 1')),
    ('60b7dea6-4591-4ea8-a811-b449dfb1e11a', '1.19', (SELECT id FROM map WHERE name = 'Terror Mountain 1')),
    ('0c16483b-2b34-4818-82fd-71a476217eca', '1.20', (SELECT id FROM map WHERE name = 'Terror Mountain 1'));

-- INSERT OR IGNORE values for the piece table
INSERT OR IGNORE INTO piece (id, name, map_id)
VALUES
    ('2950ab56-5cf0-4ab0-b4cb-89f1f0675ed3', '2.1', (SELECT id FROM map WHERE name = 'Terror Mountain 2')),
    ('589d50cd-18a6-4f63-922b-6d535c5b9773', '2.2', (SELECT id FROM map WHERE name = 'Terror Mountain 2')),
    ('7f759840-1a2d-4636-96b4-2cc5a9e32e37', '2.3', (SELECT id FROM map WHERE name = 'Terror Mountain 2')),
    ('7be98a14-ea34-4a43-9bfd-d00510e798a0', '2.4', (SELECT id FROM map WHERE name = 'Terror Mountain 2')),
    ('d015a85d-78c9-4aa8-bef4-f8dc8fb0d52d', '2.5', (SELECT id FROM map WHERE name = 'Terror Mountain 2')),
    ('237fa076-228f-454d-8a5a-ff2b5e4d8059', '2.6', (SELECT id FROM map WHERE name = 'Terror Mountain 2')),
    ('b188d305-d21b-4071-9934-23e269837574', '2.7', (SELECT id FROM map WHERE name = 'Terror Mountain 2')),
    ('9b9e1e24-0164-4351-ad8d-62a0610634b1', '2.8', (SELECT id FROM map WHERE name = 'Terror Mountain 2')),
    ('3fb1ddb3-9e6b-4dff-be56-f54051b40fd6', '2.9', (SELECT id FROM map WHERE name = 'Terror Mountain 2')),
    ('2039703d-7698-4788-833c-38d1f739b481', '2.10', (SELECT id FROM map WHERE name = 'Terror Mountain 2')),
    ('748714d2-5249-4bba-9568-cc23c82d0e2e', '2.11', (SELECT id FROM map WHERE name = 'Terror Mountain 2')),
    ('e6cc4061-cebe-4f75-bb88-ae4bdb8a0d1d', '2.12', (SELECT id FROM map WHERE name = 'Terror Mountain 2')),
    ('1ebfbd49-ec99-4781-bc6f-3429138b041e', '2.13', (SELECT id FROM map WHERE name = 'Terror Mountain 2')),
    ('048c0bea-5c37-4e7f-8822-8b0543dd8f3e', '2.14', (SELECT id FROM map WHERE name = 'Terror Mountain 2')),
    ('35da2d2f-3e2e-4100-a63b-e374c60ae1f7', '2.15', (SELECT id FROM map WHERE name = 'Terror Mountain 2')),
    ('fee6e287-6548-4022-80ff-f3fbbe12b8f2', '2.16', (SELECT id FROM map WHERE name = 'Terror Mountain 2')),
    ('2f12da1d-7a37-4248-9f3f-549b34af1ede', '2.17', (SELECT id FROM map WHERE name = 'Terror Mountain 2')),
    ('9c506e94-e268-4bf9-927b-0537123c7347', '2.18', (SELECT id FROM map WHERE name = 'Terror Mountain 2')),
    ('19564738-0b91-41ea-9234-056e0f132f75', '2.19', (SELECT id FROM map WHERE name = 'Terror Mountain 2')),
    ('7df390cf-3b41-4c44-acab-297840c771ff', '2.20', (SELECT id FROM map WHERE name = 'Terror Mountain 2'));

-- INSERT OR IGNORE values for the piece table
INSERT OR IGNORE INTO piece (id, name, map_id)
VALUES
    ('32f7f9f4-b495-4569-a2e0-7f897c3d7cea', '3.1', (SELECT id FROM map WHERE name = 'Terror Mountain 3')),
    ('2df84917-0233-4531-92d0-71e7f43b5b22', '3.2', (SELECT id FROM map WHERE name = 'Terror Mountain 3')),
    ('68f64ebb-3b76-43f0-b036-318ab484ae9a', '3.3', (SELECT id FROM map WHERE name = 'Terror Mountain 3')),
    ('2ec5b17e-c9ce-4af1-ac6d-b4e24684b2b6', '3.4', (SELECT id FROM map WHERE name = 'Terror Mountain 3')),
    ('23ebef6c-da7f-476f-9282-d4015472ab85', '3.5', (SELECT id FROM map WHERE name = 'Terror Mountain 3')),
    ('533429ae-0e57-489d-938d-e867ae1f2172', '3.6', (SELECT id FROM map WHERE name = 'Terror Mountain 3')),
    ('e59e836f-fc23-447a-b7cf-e4e5cbfbc31f', '3.7', (SELECT id FROM map WHERE name = 'Terror Mountain 3')),
    ('7eebf1da-3e1a-4e48-889d-528de6bf815d', '3.8', (SELECT id FROM map WHERE name = 'Terror Mountain 3')),
    ('96d37dff-a36f-4713-90e2-b3bb61231fbf', '3.9', (SELECT id FROM map WHERE name = 'Terror Mountain 3')),
    ('08968b09-7c06-4298-b48c-9d9c98cc4aa1', '3.10', (SELECT id FROM map WHERE name = 'Terror Mountain 3')),
    ('05d2e963-e040-42dd-8820-913b105a4c5e', '3.11', (SELECT id FROM map WHERE name = 'Terror Mountain 3')),
    ('1ce1c6e8-aa70-4208-b643-32e1ac8d0c55', '3.12', (SELECT id FROM map WHERE name = 'Terror Mountain 3')),
    ('b1354c64-6283-455a-ac28-a18d4199d7d5', '3.13', (SELECT id FROM map WHERE name = 'Terror Mountain 3')),
    ('91f61929-ddbb-4fe8-bd69-4f3332ebdbc4', '3.14', (SELECT id FROM map WHERE name = 'Terror Mountain 3')),
    ('3e605f8c-e91a-49fe-b119-db242b9f8d8f', '3.15', (SELECT id FROM map WHERE name = 'Terror Mountain 3')),
    ('3b066de7-4f93-42f1-9f1e-cf04c20d5121', '3.16', (SELECT id FROM map WHERE name = 'Terror Mountain 3')),
    ('487d1ff6-d2ad-479e-9ec8-8c40e7f33b55', '3.17', (SELECT id FROM map WHERE name = 'Terror Mountain 3')),
    ('fabc9920-ea45-4ca8-9b03-2539bfccb79a', '3.18', (SELECT id FROM map WHERE name = 'Terror Mountain 3')),
    ('0283fdf2-260e-40fa-a963-537f6dc23130', '3.19', (SELECT id FROM map WHERE name = 'Terror Mountain 3')),
    ('73bb49a4-dbf1-4052-b214-d27e1ebaa982', '3.20', (SELECT id FROM map WHERE name = 'Terror Mountain 3'));

-- INSERT OR IGNORE values for the piece table
INSERT OR IGNORE INTO piece (id, name, map_id)
VALUES
    ('089c9031-30da-4df0-b659-af94e6d7c146', '1.1', (SELECT id FROM map WHERE name = 'Maraqua 1')),
    ('61569cd5-6049-4ab6-b6ff-a47cff46011d', '1.2', (SELECT id FROM map WHERE name = 'Maraqua 1')),
    ('4e5787af-7b0f-4a80-b5cd-2b705e57283f', '1.3', (SELECT id FROM map WHERE name = 'Maraqua 1')),
    ('da75c3f0-ac02-400c-b40d-7a02be27653a', '1.4', (SELECT id FROM map WHERE name = 'Maraqua 1')),
    ('37b800d7-fcfb-4164-8775-4c8f5c9f8407', '1.5', (SELECT id FROM map WHERE name = 'Maraqua 1')),
    ('666f54fe-c5da-4e6d-a4b8-3316a85963e5', '1.6', (SELECT id FROM map WHERE name = 'Maraqua 1')),
    ('f42908f5-d874-4266-a7e2-8fbe3a61e379', '1.7', (SELECT id FROM map WHERE name = 'Maraqua 1')),
    ('09ea8617-ff86-40f3-a997-1fd2c3549a53', '1.8', (SELECT id FROM map WHERE name = 'Maraqua 1')),
    ('cfe2d819-1d8d-485f-a849-6af8515d249a', '1.9', (SELECT id FROM map WHERE name = 'Maraqua 1')),
    ('0114fa6b-7bec-4f88-8046-b30530fc7392', '1.10', (SELECT id FROM map WHERE name = 'Maraqua 1')),
    ('547f7870-d366-43d9-96e1-6b74c0c1247c', '1.11', (SELECT id FROM map WHERE name = 'Maraqua 1')),
    ('3ab8d554-044a-4d1d-9902-90fec09ac6ac', '1.12', (SELECT id FROM map WHERE name = 'Maraqua 1')),
    ('32c35bc7-52a3-4353-a81e-93a274b61a5e', '1.13', (SELECT id FROM map WHERE name = 'Maraqua 1')),
    ('bcdde812-6b68-4632-8051-25705b6c9956', '1.14', (SELECT id FROM map WHERE name = 'Maraqua 1')),
    ('bf5a0bc6-aca3-4364-87ae-015d15f7136d', '1.15', (SELECT id FROM map WHERE name = 'Maraqua 1')),
    ('4b853f08-a129-4334-bea8-72c3cc2275d7', '1.16', (SELECT id FROM map WHERE name = 'Maraqua 1')),
    ('efc71b42-d8d9-4d63-945d-7de1c607c639', '1.17', (SELECT id FROM map WHERE name = 'Maraqua 1')),
    ('689b6eba-298c-45c5-82c7-cd197bae244e', '1.18', (SELECT id FROM map WHERE name = 'Maraqua 1')),
    ('e3fd5b42-6897-4cd0-ae22-581c2d97952a', '1.19', (SELECT id FROM map WHERE name = 'Maraqua 1')),
    ('c355d44c-9746-4fe1-886f-699f3dbf04cd', '1.20', (SELECT id FROM map WHERE name = 'Maraqua 1'));

-- INSERT OR IGNORE values for the piece table
INSERT OR IGNORE INTO piece (id, name, map_id)
VALUES
    ('dacab959-f8cf-455d-98f5-c263e3d6e8b4', '2.1', (SELECT id FROM map WHERE name = 'Maraqua 2')),
    ('2631d1d1-1a1c-4832-8e40-fa11739682af', '2.2', (SELECT id FROM map WHERE name = 'Maraqua 2')),
    ('59d564dd-5cd8-45e0-af00-1941aefda908', '2.3', (SELECT id FROM map WHERE name = 'Maraqua 2')),
    ('c199de2a-fa3a-413f-8c7f-d76c7587379b', '2.4', (SELECT id FROM map WHERE name = 'Maraqua 2')),
    ('9da2c85d-4d84-4013-9ad9-ba8c34526e86', '2.5', (SELECT id FROM map WHERE name = 'Maraqua 2')),
    ('6554e792-e72d-4c72-9948-97fdb0a4f951', '2.6', (SELECT id FROM map WHERE name = 'Maraqua 2')),
    ('32c2867f-3a8b-4fcb-8a36-9f4efcc429a5', '2.7', (SELECT id FROM map WHERE name = 'Maraqua 2')),
    ('3fa61fab-1590-4a41-b0aa-97a3e35a59e2', '2.8', (SELECT id FROM map WHERE name = 'Maraqua 2')),
    ('3ad2e0b9-300c-4127-ba64-22c243c5df2d', '2.9', (SELECT id FROM map WHERE name = 'Maraqua 2')),
    ('1cc74039-4a89-44bf-9a2e-15b3e617a61f', '2.10', (SELECT id FROM map WHERE name = 'Maraqua 2')),
    ('81a75be8-b00c-48ba-85d4-52ad49aa95d9', '2.11', (SELECT id FROM map WHERE name = 'Maraqua 2')),
    ('ea63fb9e-5528-4dd1-86de-b3ad402cb45c', '2.12', (SELECT id FROM map WHERE name = 'Maraqua 2')),
    ('ae68738b-9b91-4df4-bbe4-c2103c7f0283', '2.13', (SELECT id FROM map WHERE name = 'Maraqua 2')),
    ('dca80fac-bb91-4f76-90ef-52e8d1b7403c', '2.14', (SELECT id FROM map WHERE name = 'Maraqua 2')),
    ('e29db5a0-799d-4079-b856-ebf0d3d58eb6', '2.15', (SELECT id FROM map WHERE name = 'Maraqua 2')),
    ('5f47dd53-a91c-40f1-aab5-33fa6d6dfd88', '2.16', (SELECT id FROM map WHERE name = 'Maraqua 2')),
    ('4056b6fe-5052-4e14-883a-3b0fc78d8ea4', '2.17', (SELECT id FROM map WHERE name = 'Maraqua 2')),
    ('0ac6ee56-8ec0-4d69-84d2-eb00bf5b1d6e', '2.18', (SELECT id FROM map WHERE name = 'Maraqua 2')),
    ('cff69f63-3184-4c79-81d3-0b0ea3754c24', '2.19', (SELECT id FROM map WHERE name = 'Maraqua 2')),
    ('a7d22d75-601c-499c-9972-5500ba10f389', '2.20', (SELECT id FROM map WHERE name = 'Maraqua 2'));

-- INSERT OR IGNORE values for the piece table
INSERT OR IGNORE INTO piece (id, name, map_id)
VALUES
    ('0950ebce-7e10-4612-b936-1a5c1e35dc31', '3.1', (SELECT id FROM map WHERE name = 'Maraqua 3')),
    ('5d811aa8-1a38-44e6-92fe-54f3bfcb1d48', '3.2', (SELECT id FROM map WHERE name = 'Maraqua 3')),
    ('63f46da1-a55c-457a-9553-eabcc6e514c2', '3.3', (SELECT id FROM map WHERE name = 'Maraqua 3')),
    ('16ee2261-e304-4ff7-a365-67d58e41e088', '3.4', (SELECT id FROM map WHERE name = 'Maraqua 3')),
    ('bc4ae1c2-a314-488c-8bfb-13360e4fd355', '3.5', (SELECT id FROM map WHERE name = 'Maraqua 3')),
    ('f58a9a05-34d2-43f4-92e9-b7a7d52cfb9e', '3.6', (SELECT id FROM map WHERE name = 'Maraqua 3')),
    ('bdea8b93-dbe5-4944-951b-7fd75e194236', '3.7', (SELECT id FROM map WHERE name = 'Maraqua 3')),
    ('e7d28204-5fb0-4e0a-bd76-5231767000db', '3.8', (SELECT id FROM map WHERE name = 'Maraqua 3')),
    ('332a4cd0-9d06-4aa9-9487-a2759336de77', '3.9', (SELECT id FROM map WHERE name = 'Maraqua 3')),
    ('a2fe9432-727c-466a-978c-a105edbe101f', '3.10', (SELECT id FROM map WHERE name = 'Maraqua 3')),
    ('e12d734b-34d7-47a2-8e76-7ee8a64b5144', '3.11', (SELECT id FROM map WHERE name = 'Maraqua 3')),
    ('df742806-42c1-4a5a-a53e-fd1004f2f3c8', '3.12', (SELECT id FROM map WHERE name = 'Maraqua 3')),
    ('eb96fb95-a4bf-40c1-8b90-93c502b158f9', '3.13', (SELECT id FROM map WHERE name = 'Maraqua 3')),
    ('1844bc23-04f5-4a19-8f42-c0e5cead3f55', '3.14', (SELECT id FROM map WHERE name = 'Maraqua 3')),
    ('a0639506-84ce-4a53-b881-6ba71040de6f', '3.15', (SELECT id FROM map WHERE name = 'Maraqua 3')),
    ('902f6df2-905b-4169-a482-fb7034f616b5', '3.16', (SELECT id FROM map WHERE name = 'Maraqua 3')),
    ('a6914549-97bc-4841-9cce-6dca24ddf7b8', '3.17', (SELECT id FROM map WHERE name = 'Maraqua 3')),
    ('1411e0e0-3fbb-4539-9910-ddc0cf61080c', '3.18', (SELECT id FROM map WHERE name = 'Maraqua 3')),
    ('3142bccb-2962-4550-9d22-fa1c2cfe5018', '3.19', (SELECT id FROM map WHERE name = 'Maraqua 3')),
    ('f086e5ac-17b5-4a6c-8655-561d4a9dbb3c', '3.20', (SELECT id FROM map WHERE name = 'Maraqua 3'));


--LIVE DATA TABLES
CREATE TABLE IF NOT EXISTS guilds (
	id INTEGER PRIMARY KEY,
	bot_prefix TEXT DEFAULT "$"
);

CREATE TABLE IF NOT EXISTS user (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS user_piece (
    id TEXT PRIMARY KEY,
    piece_id TEXT,
    user_id INTEGER,
    status INTEGER, --0 needed, 1 owned, 2 uft
    created_date TEXT,
    updated_date TEXT,
    FOREIGN KEY (piece_id) REFERENCES piece (id)
    FOREIGN KEY (user_id) REFERENCES user (id)
);

CREATE TABLE IF NOT EXISTS user_map_completion (
    id TEXT PRIMARY KEY,
    map_id TEXT,
    user_id INTEGER,
    created_date TEXT, 
    FOREIGN KEY (map_id) REFERENCES map (id)
    FOREIGN KEY (user_id) REFERENCES user (id)
);