defmodule XdocApi.Repo.Migrations.CreateDocument do
  use Ecto.Migration

  def change do
    create table(:documents) do
      add :title, :string
      add :identifier, :string
      add :author_id, :integer

      add :text, :string
      add :rendered_text, :string
      add :document_type, :string

      add :parent, :integer
      add :subdocuments, {:array, :integer}

      add :associated_documents, :map
      add :related_documents, {:array, :integer}
      add :collections, {:array, :integer}

      add :tags, {:array, :string}
      add :dict, :map

      add :viewed_at, :utc_datetime
      add :edited_at, :utc_datetime
      add :visit_count, :integer

      add :public, :boolean
      add :access_control_lists, {:array, :integer}

      timestamps()
    end

  end
end
