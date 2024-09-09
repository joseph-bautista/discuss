defmodule DiscussWeb.Topics.TopicController do
  use DiscussWeb, :controller

  alias Discuss.{Repo, Topic}

  def index(conn, _params) do
    topics = Repo.all(Discuss.Topic)

    render(conn, :index, topics: topics, layout: false)
  end

  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})

    render(conn, :new, changeset: changeset, layout: false)
  end

  def create(conn, %{"topic" => topic}) do
    changeset = Topic.changeset(%Topic{}, topic)

    case Repo.insert(changeset) do
      {:ok, _post} ->
        conn
        |> put_flash(:info, "Topic Created")
        |> redirect(to: "/topics")
      {:error, changeset} ->
        render(conn, :new, changeset: changeset, layout: false)
    end
  end
end
