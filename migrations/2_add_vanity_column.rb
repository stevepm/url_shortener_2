Sequel.migration do
  up do
    alter_table(:urls) do
      add_column :vanity, String, :size => 15, :default => '', :unique => true
    end
  end

  down do
    alter_table(:urls) do
      drop_column :vanity
    end
  end
end