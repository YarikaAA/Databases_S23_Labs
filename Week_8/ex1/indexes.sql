CREATE INDEX id_idx1 ON customer USING btree(LENGTH(review));
CREATE INDEX id_idx2 ON customer USING hash(address);
