CREATE TABLE gender(
   id_gender INT NOT NULL AUTO_INCREMENT,
   label VARCHAR(50) NOT NULL,
   PRIMARY KEY(id_gender),
   UNIQUE(label)
);

CREATE TABLE personal(
   id_personal INT NOT NULL AUTO_INCREMENT,
   first_name VARCHAR(50) NOT NULL,
   last_name VARCHAR(50) NOT NULL,
   phone_number VARCHAR(50),
   email VARCHAR(50),
   email_personnal VARCHAR(50),
   id_gender INT NOT NULL,
   PRIMARY KEY(id_personal),
   FOREIGN KEY(id_gender) REFERENCES gender(id_gender)
);

INSERT INTO gender (label) VALUES ('Male');
INSERT INTO gender (label) VALUES ('Female');
INSERT INTO gender (label) VALUES ('Agender');

INSERT INTO personal (first_name, last_name, phone_number, email, email_personnal, id_gender) VALUES
  ('Welsh', 'Moreinis', '+46 938 998 2717', 'wmoreinis0@wordpress.com', 'wmoreinis0@pen.io', 1),
  ('Kalle', 'Darley', '+62 132 546 5279', 'kdarley1@toplist.cz', 'kdarley1@nps.gov', 1),
  ('Isidro', 'Cleyburn', NULL, 'icleyburn2@unicef.org', 'icleyburn2@drupal.org', 1),
  ('Dierdre', 'Tremblay', '+62 842 965 9592', 'dtremblay3@instagram.com', NULL, 2),
  ('Husein', 'Sheather', '+976 194 155 2748', 'hsheather4@un.org', 'hsheather4@wunderground.com', 1),
  ('Natalie', 'McCarver', NULL, 'nmccarver5@redcross.org', 'nmccarver5@senate.gov', 2),
  ('Madalena', 'Scothron', '+351 284 542 3208', 'mscothron6@scientificamerican.com', 'mscothron6@oracle.com', 2),
  ('Granthem', 'Keemer', '+86 114 256 6875', 'gkeemer7@microsoft.com', 'gkeemer7@nationalgeographic.com', 1),
  ('Clarine', 'Alton', '+62 991 541 5653', 'calton8@freewebs.com', 'calton8@jalbum.net', 2),
  ('Salim', 'Clink', '+82 249 749 6306', 'sclink9@zimbio.com', 'sclink9@weebly.com', 1),
  ('Abran', 'Helkin', '+46 560 748 2439', 'ahelkina@ocn.ne.jp', 'ahelkina@latimes.com', 1),
  ('Sigrid', 'MacLachlan', '+504 576 352 0664', 'smaclachlanb@wired.com', 'smaclachlanb@utexas.edu', 2),
  ('Gardie', 'Blomfield', '+86 607 883 9839', 'gblomfieldc@independent.co.uk', 'gblomfieldc@ameblo.jp', 1),
  ('Mattias', 'Brunetti', '+57 884 281 0561', 'mbrunettid@usgs.gov', 'mbrunettid@free.fr', 1),
  ('Allan', 'Clucas', '+46 985 274 7919', 'aclucase@printfriendly.com', 'aclucase@state.gov', 1),
  ('Flory', 'Figiovanni', '+1 897 848 4773', 'ffigiovannif@sciencedirect.com', 'ffigiovannif@tripadvisor.com', 1),
  ('Elton', 'Reynoldson', NULL, 'ereynoldsong@digg.com', NULL, 1),
  ('Rivi', 'Dickons', NULL, 'rdickonsh@smh.com.au', 'rdickonsh@mtv.com', 3),
  ('Hollyanne', 'Pounds', '+63 468 255 7071', 'hpoundsi@elpais.com', 'hpoundsi@comcast.net', 2),
  ('Keelby', 'Freemantle' , '+7 338 298 2691', 'kfreemantlej@weibo.com', 'kfreemantlej@state.tx.us', 1)

