class SourceVersion < PaperTrail::Version
  self.table_name = :source_versions
  self.sequence_name = :post_versions_id_seq
end
