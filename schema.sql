/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id integer,
    name varchar(100),
    date_of_birth date,
    escape_attempts integer,
    neutered boolean,
    weight_kg decimal
);

ALTER TABLE animals ADD species varchar(100);

CREATE TABLE owners (
    id integer GENERATED ALWAYS AS IDENTITY,
    full_name varchar(100),
    age integer,
    PRIMARY KEY (id)
);

CREATE TABLE species (
    id integer GENERATED ALWAYS AS IDENTITY,
    name varchar(100),
    PRIMARY KEY (id)
);

ALTER TABLE animals ALTER COLUMN id SET NOT NULL;
ALTER TABLE animals ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY;
ALTER TABLE animals ADD PRIMARY KEY (id);

ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id integer;
ALTER TABLE animals ADD CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species (id) ON DELETE SET NULL;

ALTER TABLE animals ADD COLUMN owner_id integer;
ALTER TABLE animals ADD CONSTRAINT fk_owner FOREIGN KEY (owner_id) REFERENCES owners (id) ON DELETE SET NULL;

CREATE TABLE vets (
    id integer GENERATED ALWAYS AS IDENTITY,
    name varchar(100),
    age integer,
    date_of_graduation date,
    PRIMARY KEY (id)
);

CREATE TABLE specializations (
    species_id integer NOT NULL,
    vets_id integer NOT NULL,
    CONSTRAINT "fk_species" FOREIGN KEY (species_id) REFERENCES species (id) ON DELETE SET NULL,
    CONSTRAINT "fk_vets" FOREIGN KEY (vets_id) REFERENCES vets (id) ON DELETE SET NULL,
    PRIMARY KEY (species_id, vets_id)
);

CREATE TABLE visits (
    animals_id integer NOT NULL,
    vets_id integer NOT NULL,
    visit_date date NOT NULL,
    CONSTRAINT "fk_animals" FOREIGN KEY (animals_id) REFERENCES animals (id) ON DELETE SET NULL,
    CONSTRAINT "fk_vets" FOREIGN KEY (vets_id) REFERENCES vets (id) ON DELETE SET NULL,
    PRIMARY KEY (animals_id, vets_id, visit_date)
);
