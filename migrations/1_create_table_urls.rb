Sequel.migration do
  up do
    create_table(:urls) do
      primary_key :id
      String :url, :null=>false, :size => 255
      Integer :stats, :default => 0
    end
  end

  down do
    drop_table(:urls)
  end
end