/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon%';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, AVG(escape_attempts) AS Avg_attempt_escape FROM animals GROUP BY neutered;
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

/* Join queries */
SELECT name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Melody Pond';

SELECT animals.name FROM animals JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';

SELECT owners.full_name, animals.name FROM animals RIGHT JOIN owners ON animals.owner_id = owners.id;

SELECT species.name, COUNT(*) FROM animals JOIN species ON animals.species_id = species.id GROUP BY species.id;

SELECT animals.name, species.name, owners.full_name FROM animals JOIN species ON animals.species_id = species.id JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

SELECT animals.name, owners.full_name, animals.escape_attempts FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

SELECT owners.full_name, COUNT(animals.name) FROM animals RIGHT JOIN owners ON animals.owner_id = owners.id GROUP BY owners.full_name;

/* Join tables queries*/
SELECT animals.name, vets.name, visits.visit_date FROM animals JOIN visits on (animals.id = visits.animals_id) JOIN vets on (vets.id = visits.vets_id) WHERE vets.name = 'William Tatcher' AND visits.visit_date = (SELECT MAX(visits.visit_date) FROM visits JOIN vets on (vets.id = visits.vets_id) GROUP BY vets.name HAVING vets.name = 'William Tatcher');

SELECT COUNT(animals.name) FROM animals JOIN visits ON (animals.id = visits.animals_id) JOIN vets on (vets.id = visits.vets_id) WHERE vets.name = 'Stephanie Mendez';

SELECT vets.name, species.name FROM vets LEFT JOIN specializations ON vets.id = specializations.vets_id LEFT JOIN species ON species.id = specializations.species_id;
    
SELECT animals.name, vets.name, visits.visit_date FROM animals JOIN visits ON visits.animals_id = animals.id JOIN vets ON vets.id = visits.vets_id WHERE vets.name = 'Stephanie Mendez' AND visits.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

SELECT animals.name, COUNT(animals.name) FROM animals JOIN visits ON animals.id = visits.animals_id GROUP BY animals.name
HAVING COUNT (animals_id) = (
SELECT MAX(mycount)
FROM (
SELECT COUNT(animals_id) mycount
FROM visits
GROUP BY animals_id
) AS animals_count);

SELECT animals.name, vets.name, visits.visit_date FROM animals JOIN visits on (animals.id = visits.animals_id) JOIN vets on (vets.id = visits.vets_id) WHERE vets.name = 'Maisy Smith' AND visits.visit_date = (SELECT MIN(visits.visit_date) FROM visits JOIN vets on (vets.id = visits.vets_id) GROUP BY vets.name HAVING vets.name = 'Maisy Smith');

SELECT animals.name, vets.name, visits.visit_date FROM animals JOIN visits on (animals.id = visits.animals_id) JOIN vets on (vets.id = visits.vets_id) WHERE visits.visit_date = (SELECT MAX(visits.visit_date) FROM visits);

SELECT COUNT(visits.visit_date) FROM vets JOIN visits ON visits.vets_id = vets.id JOIN animals ON animals.id = visits.animals_id JOIN specializations ON vets.id = specializations.vets_id JOIN species ON specializations.species_id = species.id WHERE animals.species_id <> specializations.species_id;

SELECT species.name, COUNT(species.name) as visits
FROM animals
JOIN visits ON visits.animals_id = animals.id
JOIN vets ON visits.vets_id = vets.id
JOIN species ON species.id = animals.species_id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY visits DESC
LIMIT 1;
