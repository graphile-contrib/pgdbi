
ALTER TABLE tunz.band_member ADD CONSTRAINT fk_band_member_contact FOREIGN KEY ( musician_id ) REFERENCES org.contact( id );
