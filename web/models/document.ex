defmodule XdocApi.Document do
  use XdocApi.Web, :model

  schema "documents" do
    field :title, :string
    field :author_id, :integer
    field :identifier, :string

    field :text, :string
    field :rendered_text, :string
    field :document_type, :string

    field :parent, :integer
    field :subdocuments, {:array, :integer}

    field :associated_documents, :map
    field :related_documents, {:array, :integer}
    field :collections, {:array, :integer}

    field :tags, {:array, :string}
    field :dict, :map

    field :viewed_at, :utc_datetime
    field :edited_at, :utc_datetime
    field :visit_count, :integer

    field :public, :boolean
    field :access_control_lists, {:array, :integer}
    field :deleted

    timestamps
  end

  def all_fields do
    [:title, :author_id, :identifier, :text, :rendered_text,
      :document_type, :parent, :subdocuments,
      :associated_documents, :related_documents, :collections,
      :tags, :dict,
      :viewed_at, :edited_at, :visit_count,
      :access_control_lists, :public, :deleted]
  end

  def initial_parameters do
     [  "identifier": "-",
        "type": "asciidoc",
        "parent":  0,
        "subdocuments":  [],
        "associated_documents":  {},
        "related_documents":  [],
        "collections":  [],
        "tags":  [],
        "dict":  {},

        "visit_count":  0,
        "access_control_lists":  [],

        "public":  false,
        "deleted":  false
     ]
  end


  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, all_fields)

    |> validate_required([:title, :text, :rendered_text, :author_id])
  end

  def update_changeset(struct, params \\ %{}) do
      struct
      |> cast(params, all_fields)
    end

end
