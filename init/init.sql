-- PowerDNS Schema
CREATE TABLE IF NOT EXISTS domains (
  id INT AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  master VARCHAR(128) DEFAULT NULL,
  last_check INT DEFAULT NULL,
  type VARCHAR(6) NOT NULL,
  notified_serial INT DEFAULT NULL,
  account VARCHAR(40) DEFAULT NULL,
  PRIMARY KEY (id)
);

CREATE UNIQUE INDEX name_index ON domains(name);

CREATE TABLE records (
  id INT AUTO_INCREMENT,
  domain_id INT DEFAULT NULL,
  name VARCHAR(255) DEFAULT NULL,
  type VARCHAR(10) DEFAULT NULL,
  content TEXT,
  ttl INT DEFAULT NULL,
  prio INT DEFAULT NULL,
  change_date INT DEFAULT NULL,
  disabled TINYINT(1) DEFAULT 0,
  ordername VARCHAR(255) BINARY DEFAULT NULL,
  auth TINYINT(1) DEFAULT 1,
  PRIMARY KEY (id)
);

CREATE INDEX nametype_index ON records(name,type);
CREATE INDEX domain_id ON records(domain_id);

CREATE TABLE supermasters (
  ip VARCHAR(64) NOT NULL,
  nameserver VARCHAR(255) NOT NULL,
  account VARCHAR(40) DEFAULT NULL
);

CREATE TABLE comments (
  id INT AUTO_INCREMENT,
  domain_id INT NOT NULL,
  name VARCHAR(255) NOT NULL,
  type VARCHAR(10) NOT NULL,
  modified_at INT NOT NULL,
  account VARCHAR(40) NOT NULL,
  comment TEXT NOT NULL,
  PRIMARY KEY (id)
);

CREATE INDEX comments_name_type_idx ON comments(name, type);
CREATE INDEX comments_order_idx ON comments(domain_id, modified_at);

CREATE TABLE domainmetadata (
  id INT AUTO_INCREMENT,
  domain_id INT NOT NULL,
  kind VARCHAR(32),
  content TEXT,
  PRIMARY KEY (id)
);

CREATE INDEX domainmetadata_idx ON domainmetadata(domain_id, kind);

CREATE TABLE cryptokeys (
  id INT AUTO_INCREMENT,
  domain_id INT NOT NULL,
  flags INT NOT NULL,
  active BOOL,
  content TEXT,
  PRIMARY KEY (id)
);

CREATE INDEX domainidindex ON cryptokeys(domain_id);

CREATE TABLE tsigkeys (
  id INT AUTO_INCREMENT,
  name VARCHAR(255),
  algorithm VARCHAR(50),
  secret VARCHAR(255),
  PRIMARY KEY (id)
);

CREATE UNIQUE INDEX namealgoindex ON tsigkeys(name, algorithm);

-- Sample domain
INSERT INTO domains (name, type) VALUES ('example.com', 'MASTER');

-- Sample A record
INSERT INTO records (domain_id, name, type, content, ttl, prio) 
VALUES (
  (SELECT id FROM domains WHERE name='example.com'),
  'www.example.com',
  'A',
  '192.168.1.100',
  3600,
  NULL
);
