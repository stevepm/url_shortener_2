Sequel.migration do
  up do
    alter_table(:urls) do
      add_column :vanity_name, String, :size => 15, :default => nil, :unique => true
    end
  end

  down do
    alter_table(:urls) do
      drop_column :vanity_name
    end
  end
end