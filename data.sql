/* Populate database with sample data. */

INSERT INTO animals (id, name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES (1, 'Agumon', '2020-02-03', 10.23, true, 0);
INSERT INTO animals (id, name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES (2, 'Gabumon', '2018-11-15', 8, true, 2);
INSERT INTO animals (id, name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES (3, 'Pikachu', '2021-01-07', 15.04, false, 1);
INSERT INTO animals (id, name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES (4, 'Devimon', '2017-05-12', 11, true, 5);

INSERT INTO animals (id, name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES (5, 'Charmander', '2020-02-08', -11, false, 0);
INSERT INTO animals (id, name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES (6, 'Plantmon', '2021-11-15', -5.7, true, 2);
INSERT INTO animals (id, name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES (7, 'Squirtle', '1993-04-02', -12.13, false, 3);
INSERT INTO animals (id, name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES (8, 'Angemon', '2005-06-12', -45, true, 1);
INSERT INTO animals (id, name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES (9, 'Boarmon', '2005-06-07', 20.4, true, 7);    
INSERT INTO animals (id, name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES (10, 'Blossom', '1998-10-13', 17, true, 3);
INSERT INTO animals (id, name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES (11, 'Ditto', '2022-05-14', 22, true, 4);

/* transaction */
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

/* transaction 2 */
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon%';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;
SELECT * FROM animals;

/* transactio 3 */
BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

/* trnsaction 4 */
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT savepoint_01;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SAVEPOINT savepoint_01;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

/* Insert in owners table */
INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34);
INSERT INTO owners (full_name, age) VALUES ('Jennifer Orwell', 19);
INSERT INTO owners (full_name, age) VALUES ('Bob', 45);
INSERT INTO owners (full_name, age) VALUES ('Melody Pond', 77);
INSERT INTO owners (full_name, age) VALUES ('Dean Winchester', 14);
INSERT INTO owners (full_name, age) VALUES ('Jodie Whittaker', 38);

/* Insert into species */
INSERT INTO species (name) VALUES ('Pokemon');
INSERT INTO species (name) VALUES ('Digimon');

UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Digimon') WHERE name LIKE '%mon%';
UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Pokemon') WHERE species_id IS NULL;

UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith') WHERE name = 'Agumon';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell') WHERE name IN ('Gabumon', 'Pikachu');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob') WHERE name IN ('Devimon', 'Plantmon');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond') WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester') WHERE name IN ('Angemon', 'Boarmon');
