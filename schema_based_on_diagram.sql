CREATE DATABASE clinic;

CREATE TABLE patients(
  id INT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(255) NOT NULL,
  date_of_birth DATE NOT NULL
);

CREATE TABLE medical_histories (
  id INT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY,
  admitted_at TIMESTAMP NOT NULL,
  patient_id INT NOT NULL,
  status VARCHAR(255) NOT NULL,
  FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE invoices(
  id INT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY,
  total_amount DECIMAL NOT NULL,
  generated_at TIMESTAMP NOT NULL,
  payed_at     TIMESTAMP NOT NULL,
  medical_history__id INT NOT NULL UNI,
  FOREIGN KEY (medical_history__id) REFERENCES medical_histories(id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE treatments(
  id INT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY,
  type VARCHAR(255) NOT NULL,
  name VARCHAR(255) NOT NULL
);

CREATE TABLE invoice_items(
  id INT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY,
  unit_price  DECIMAL NOT NULL,
  quantity    INT NOT NULL,
  total_price DECIMAL NOT NULL,
  invoice_id  INT NOT NULL,
  treatment_id INT NOT NULL,
  FOREIGN KEY (invoice_id) REFERENCES invoices(id) ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (treatment_id) REFERENCES treatments(id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE medical_treatments(
  medical_history__id INT NOT NULL,
  treatment_id INT NOT NULL,
  FOREIGN KEY (medical_history__id) REFERENCES medical_histories(id) ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (treatment_id) REFERENCES treatments(id) ON DELETE RESTRICT ON UPDATE CASCADE,
  PRIMARY KEY (medical_history__id, treatment_id)
);

CREATE INDEX ON medical_treatments (treatment_id);
CREATE INDEX ON medical_treatments (medical_history__id);
CREATE INDEX ON invoice_items (invoice_id);
CREATE INDEX ON invoice_items (treatment_id);
CREATE INDEX ON invoices (medical_history__id);
CREATE INDEX ON medical_histories (patient_id);
