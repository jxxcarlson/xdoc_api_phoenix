defmodule XdocApi.Search do
    use XdocApi.Web, :model

  use Ecto.Schema
  import Ecto.Query
  alias XdocApi.Document
  alias XdocApi.Repo

  def simple_title_search(arg) do
      query = Ecto.Query.from doc in Document,
         where: (ilike(doc.title, ^"%#{arg}%")),
         order_by: [desc: doc.updated_at]
      result = Repo.all(query)
  end

   def by_id(arg) do
     # from(p in Post, where: p.id in [1, 2]) |> Repo.all
        query = Ecto.Query.from doc in Document,
           where: doc.id == ^arg,
           order_by: [desc: doc.updated_at]
        result = Repo.all(query)
    end

  def search_with_non_empty_arg(arg, user_id) do
    query = Ecto.Query.from doc in Document,
       where: (ilike(doc.title, ^"%#{List.first(arg)}%")),
       order_by: [desc: doc.updated_at]
    result = Repo.all(query)
    |> filter_records_for_user(user_id)
    |> filter_records_with_term_list(tl(arg))
    Enum.map(result, fn (record) -> record.id end)
    result
  end

  def search(arg, user_id) do
    arg = Enum.map(arg, fn(x) -> String.downcase(x) end)
    case arg do
      [] -> []
      _ -> search_with_non_empty_arg(arg, user_id)
    end
  end

  def filter_records_for_user(list, user_id) do
    list
    # |> Enum.filter(fn(x) -> x.user_id == user_id end)
  end

  def filter_records_with_term(list, term) do

    Enum.filter(list, fn(x) -> String.contains?(String.downcase(x.title), term) or String.contains?(String.downcase(x.content), term) end)

  end

  def filter_records_with_term_list(list, term_list) do

    case {list, term_list} do
      {list,[]} -> list
      {list, term_list} -> filter_records_with_term_list(
            filter_records_with_term(list, hd(term_list)), tl(term_list)
          )
    end

  end
end