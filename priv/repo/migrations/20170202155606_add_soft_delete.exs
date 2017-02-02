defmodule XdocApi.Repo.Migrations.AddSoftDelete do
  use Ecto.Migration

  def change do
    alter table(:documents) do
      add :deleted, :boolean
    end

  end
end
